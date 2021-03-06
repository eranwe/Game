package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_14_14_WallSliding extends ActorScript
{          	
	
public var _CanSlide:Bool;

public var _CollidingLeft:Bool;

public var _CollidingRight:Bool;

public var _CollidedLeft:Bool;

public var _CollidedRight:Bool;

public var _OldY:Float;

public var _LeftKey:String;

public var _RightKey:String;

public var _SlideSpeed:Float;

public var _SlideRightAnimation:String;

public var _SlideLeftAnimation:String;

public var _LimittoTiles:Bool;

public var _PreventWallSlide:Bool;

public var _AnimationCategory:String;
    
/* ========================= Custom Block ========================= */


/* Params are:__Self __Prevent */
public function _customBlock_PreventWallSlide(__Prevent:Bool):Void
{
var __Self:Actor = actor;
        _PreventWallSlide = __Prevent;
propertyChanged("_PreventWallSlide", _PreventWallSlide);
}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Can Slide?", "_CanSlide");
_CanSlide = false;
nameMap.set("Colliding Left?", "_CollidingLeft");
_CollidingLeft = false;
nameMap.set("Colliding Right?", "_CollidingRight");
_CollidingRight = false;
nameMap.set("Collided Left?", "_CollidedLeft");
_CollidedLeft = false;
nameMap.set("Collided Right?", "_CollidedRight");
_CollidedRight = false;
nameMap.set("Old Y", "_OldY");
_OldY = 0.0;
nameMap.set("Left Key", "_LeftKey");
nameMap.set("Right Key", "_RightKey");
nameMap.set("Slide Speed", "_SlideSpeed");
_SlideSpeed = 7.0;
nameMap.set("Slide Right Animation", "_SlideRightAnimation");
nameMap.set("Slide Left Animation", "_SlideLeftAnimation");
nameMap.set("Limit to Tiles?", "_LimittoTiles");
_LimittoTiles = false;
nameMap.set("Prevent Wall Slide?", "_PreventWallSlide");
_PreventWallSlide = false;
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Wall Sliding";

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute, from \"Walking\" Behavior (required)" */
        /* "\"Is Wall Jumping?\" -- <Boolean> Actor Level Attribute, from \"Wall Jumping\" Behavior (NOT required)" */
        /* "\"Is Climbing?\" -- <Boolean> Actor Level Attribute, from \"Climbing\" Behavior (NOT required)" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute, from \"Ducking\" Behavior (NOT required)" */
        /* "Outputs: ---------------------" */
        /* "\"Is Wall Sliding?\" -- <Boolean> Actor Level Attribute" */
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_PreventWallSlide)
{
            _CanSlide = false;
propertyChanged("_CanSlide", _CanSlide);
            actor.setActorValue("Is Wall Sliding?", false);
            return;
}

        _CanSlide = true;
propertyChanged("_CanSlide", _CanSlide);
        if((asBoolean(actor.getActorValue("Is Climbing?")) || (asBoolean(actor.getActorValue("Is Ducking?")) || asBoolean(actor.getActorValue("On Ground?")))))
{
            _CanSlide = false;
propertyChanged("_CanSlide", _CanSlide);
            actor.setActorValue("Is Wall Sliding?", false);
}

        _CollidedLeft = _CollidingLeft;
propertyChanged("_CollidedLeft", _CollidedLeft);
        _CollidedRight = _CollidingRight;
propertyChanged("_CollidedRight", _CollidedRight);
        _CollidingLeft = false;
propertyChanged("_CollidingLeft", _CollidingLeft);
        _CollidingRight = false;
propertyChanged("_CollidingRight", _CollidingRight);
        if(((actor.getY() > _OldY) && _CanSlide))
{
            if(!(asBoolean(actor.getActorValue("On Ground?"))))
{
                if(((_CollidedLeft && isKeyDown(_LeftKey)) || (_CollidedRight && isKeyDown(_RightKey))))
{
                    actor.setActorValue("Is Wall Sliding?", true);
}

                else
{
                    actor.setActorValue("Is Wall Sliding?", false);
}

}

}

        if(asBoolean(actor.getActorValue("Is Wall Sliding?")))
{
            actor.setYVelocity(_SlideSpeed);
            if(asBoolean(actor.getActorValue("Facing Right?")))
{

}

            else
{

}

}

        else
{

}

        _OldY = asNumber(actor.getY());
propertyChanged("_OldY", _OldY);
}
});
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(event.thisCollidedWithSensor)
{
            return;
}

        if(event.thisFromLeft)
{
            if((_LimittoTiles && !(event.thisCollidedWithTile)))
{
                return;
}

            _CollidingLeft = true;
propertyChanged("_CollidingLeft", _CollidingLeft);
}

        if(event.thisFromRight)
{
            if((_LimittoTiles && !(event.thisCollidedWithTile)))
{
                return;
}

            _CollidingRight = true;
propertyChanged("_CollidingRight", _CollidingRight);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
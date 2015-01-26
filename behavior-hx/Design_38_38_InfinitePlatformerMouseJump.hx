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



class Design_38_38_InfinitePlatformerMouseJump extends ActorScript
{          	
	
public var _Jumping:Bool;

public var _JumpHigher:Bool;

public var _Jump:Bool;

public var _WasJump:Bool;

public var _OnGround:Bool;

public var _VariableJump:Bool;

public var _JumpingForce:Float;

public var _VariableJumpDuration:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_Jump():Void
{
        _Jump = true;
propertyChanged("_Jump", _Jump);
        _JumpHigher = true;
propertyChanged("_JumpHigher", _JumpHigher);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Jumping", "_Jumping");
_Jumping = false;
nameMap.set("Jump Higher", "_JumpHigher");
_JumpHigher = false;
nameMap.set("Jump", "_Jump");
_Jump = false;
nameMap.set("Was Jump", "_WasJump");
_WasJump = false;
nameMap.set("On Ground", "_OnGround");
_OnGround = false;
nameMap.set("Variable Jump", "_VariableJump");
_VariableJump = false;
nameMap.set("Jumping Force", "_JumpingForce");
_JumpingForce = 25.0;
nameMap.set("Variable Jump Duration", "_VariableJumpDuration");
_VariableJumpDuration = 0.2;

	}
	
	override public function init()
	{
		    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _Jump = isMousePressed();
propertyChanged("_Jump", _Jump);
        if((_Jump && _OnGround))
{
            _Jumping = true;
propertyChanged("_Jumping", _Jumping);
            if(_VariableJump)
{
                _JumpHigher = true;
propertyChanged("_JumpHigher", _JumpHigher);
                runLater(1000 * _VariableJumpDuration, function(timeTask:TimedTask):Void {
                            _JumpHigher = false;
propertyChanged("_JumpHigher", _JumpHigher);
                            if(!(_Jumping))
{
                                _JumpHigher = false;
propertyChanged("_JumpHigher", _JumpHigher);
                                timeTask.repeats = false;
return;
}

}, actor);
}

            else
{
                actor.applyImpulse(0, -1, _JumpingForce);
}

}

        if((_JumpHigher && isMouseDown()))
{
            actor.applyImpulse(0, -1, (_JumpingForce / getStepSize()));
}

        _WasJump = _Jump;
propertyChanged("_WasJump", _WasJump);
        _Jump = false;
propertyChanged("_Jump", _Jump);
        _OnGround = false;
propertyChanged("_OnGround", _OnGround);
}
});
    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((event.thisFromBottom && !(event.thisCollidedWithSensor)))
{
            _OnGround = true;
propertyChanged("_OnGround", _OnGround);
}

        if((_OnGround && !(_WasJump)))
{
            _Jumping = false;
propertyChanged("_Jumping", _Jumping);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
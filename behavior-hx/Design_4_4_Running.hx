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



class Design_4_4_Running extends ActorScript
{          	
	
public var _PreventRunning:Bool;

public var _RunKey:String;

public var _KeyReleased:Bool;

public var _OldAccel:Float;

public var _OldMaxSpeed:Float;

public var _AtFullSpeed:Bool;

public var _ElapsedTime:Float;

public var _Acceleration:Float;

public var _MidRunSpeed:Float;

public var _MaxRunSpeed:Float;

public var _RightKey:String;

public var _LeftKey:String;

public var _TimeToMaxSpeed:Float;

public var _CanSlide:Bool;

public var _RunRightAnimation:String;

public var _RunLeftAnimation:String;

public var _SlipRightAnimation:String;

public var _SlipLeftAnimation:String;

public var _FullRunRightAnimation:String;

public var _FullRunLeftAnimation:String;

public var _AnimationCategory:String;

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Prevent Running?", "_PreventRunning");
_PreventRunning = false;
nameMap.set("Run Key", "_RunKey");
nameMap.set("Key Released?", "_KeyReleased");
_KeyReleased = true;
nameMap.set("Old Accel", "_OldAccel");
_OldAccel = 0.0;
nameMap.set("Old Max Speed", "_OldMaxSpeed");
_OldMaxSpeed = 0.0;
nameMap.set("At Full Speed?", "_AtFullSpeed");
_AtFullSpeed = false;
nameMap.set("Elapsed Time", "_ElapsedTime");
_ElapsedTime = 0.0;
nameMap.set("Acceleration", "_Acceleration");
_Acceleration = 100.0;
nameMap.set("Mid Run Speed", "_MidRunSpeed");
_MidRunSpeed = 25.0;
nameMap.set("Max Run Speed", "_MaxRunSpeed");
_MaxRunSpeed = 35.0;
nameMap.set("Right Key", "_RightKey");
nameMap.set("Left Key", "_LeftKey");
nameMap.set("Time To Max Speed", "_TimeToMaxSpeed");
_TimeToMaxSpeed = 0.4;
nameMap.set("Can Slide?", "_CanSlide");
_CanSlide = true;
nameMap.set("Run Right Animation", "_RunRightAnimation");
nameMap.set("Run Left Animation", "_RunLeftAnimation");
nameMap.set("Slip Right Animation", "_SlipRightAnimation");
nameMap.set("Slip Left Animation", "_SlipLeftAnimation");
nameMap.set("Full Run Right Animation", "_FullRunRightAnimation");
nameMap.set("Full Run Left Animation", "_FullRunLeftAnimation");
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Running";

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
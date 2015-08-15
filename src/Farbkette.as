package
{
	import application.StarlingContext;
	
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import models.IGameModel;
	
	import org.flashapi.hummingbird.Hummingbird;
	import org.flashapi.hummingbird.starling.StarlingProperties;
	import org.flashapi.hummingbird.starling.StarlingPropertiesBuilder;
	
	import starling.display.DisplayObjectContainer;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(width="490", height="854", frameRate="60", backgroundColor="#002003")]
	public class Farbkette extends Sprite
	{
		[Model(alias="GameModel")]
		public var gameModel:IGameModel;
		
		public function Farbkette()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if(this.stage) this.init(null);
			else this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void {	Hummingbird.getStarling().start() });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { Hummingbird.getStarling().stop() });
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, function (e:*):void{});
		}
		
		private function init(e:Event):void 
		{
			if (e) this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			
			var starlingProperties:StarlingPropertiesBuilder = new StarlingPropertiesBuilder();
			starlingProperties.antiAliasing(1);
			starlingProperties.multitouchEnabled(true);
			var viewPort:Rectangle = RectangleUtil.fit( new Rectangle(0, 0, 480, 854), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight),	ScaleMode.SHOW_ALL);
			starlingProperties.viewPort(viewPort);
			
			var props:StarlingProperties = starlingProperties.build();
			Hummingbird.setApplicationContext(new StarlingContext(), this.stage, props);
			
		}
	}
}
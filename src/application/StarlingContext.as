package application {
	
	import constants.GameConstants;
	
	import controllers.ILoaderController;
	import controllers.IViewsController;
	
	import org.flashapi.hummingbird.Hummingbird;
	import org.flashapi.hummingbird.core.AbstractApplicationContext;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	public class StarlingContext extends AbstractApplicationContext {
		
		include "dependencies.as"
		
		[Controller(alias="ViewsController")]
		public var viewsController:IViewsController;
		
		[Controller(alias="LoaderController")]
		public var loaderController:ILoaderController;
		
		override public function start():void
		{
			Hummingbird.getStarling().start();
			Hummingbird.getStarling().stage.stageWidth = 480;
			Hummingbird.getStarling().stage.stageHeight = 854;
			
//			var rootScene:DisplayObjectContainer = Hummingbird.getStarling().root as DisplayObjectContainer;
//			var q:Quad = new Quad(480,854,Color.TEAL);
//			q.name = "q";
//			rootScene.addChild(q);
//			trace(rootScene.numChildren,rootScene.getChildByName("q"));
			
			this.loaderController.load();
			this.viewsController.setView(GameConstants.WELCOME_VIEW);
		}
	}
}
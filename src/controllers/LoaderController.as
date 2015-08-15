package controllers
{
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import models.IGameModel;
	
	import org.flashapi.hummingbird.controller.AbstractController;
	
	[Qualifier(alias="LoaderController")]
	public class LoaderController extends AbstractController implements ILoaderController
	{
		[Model(alias="GameModel")]
		public var gameModel:IGameModel;
		
		private var so:SharedObject;
		
		public function LoaderController()
		{
		}
//		================================================
		override protected function onDependencyComplete():void
		{
			so = SharedObject.getLocal("Farbkette");
			addEventListener(Event.DEACTIVATE,onDeactivate);
		}
//		================================================
		public function load():void
		{
			
			so.data.bestScore == undefined ? gameModel.bestScore = 0 : gameModel.bestScore = so.data.bestScore;
			trace("Load Data", "BestScore = ",gameModel.bestScore);
		}
//		================================================		
		private function save():void
		{
			trace("Save Data");
			so.data.bestScore = gameModel.bestScore; 
			so.flush(10000);
		}
//		================================================
		private function onDeactivate(event:Event):void
		{
			save();
		}
	}
}
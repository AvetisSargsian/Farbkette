package scenes {
	
	import constants.GameConstants;
	
	import controllers.IUserInputController;
	import controllers.IViewsController;
	
	import events.ModelEvent;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.ui.Keyboard;
	
	import models.IGameModel;
	import models.IItem;
	
	import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	import views.BestScoreView;
	import views.ComponentView;
	import views.JellyView;
	import views.PlayField;
	import views.ScoreView;
	
	public class InGameScene extends AbstractStarlingSpriteView implements IGameScene 
	{	
		[Controller(alias="ViewsController")]
		public var viewsController:IViewsController;
		
		[Controller(alias="UserInputController")]
		public var userInputController:IUserInputController;
		
		[Model(alias="GameModel")]
		public var gameModel:IGameModel;
		
		private var sprite:Sprite;
		
		override protected function onDependencyComplete():void
		{
			addEventListener(starling.events.TouchEvent.TOUCH, onTouch);
			addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener("TOUCH_SWITCHER",touchSwitcher);
			addEventListener(starling.events.Event.TRIGGERED,buttonClickEvent);
			addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			gameModel.addEventListener(ModelEvent.GAMEMODEL_UPDATE, gameModelUpdate);
			gameModel.addEventListener(ModelEvent.NEW_JELLY_CREATED,createJellyView);
		}
		
		private function onRemoveFromStage(event:Event):void
		{
			removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			removeEventListener(starling.events.TouchEvent.TOUCH, onTouch);
			removeEventListener("TOUCH_SWITCHER",touchSwitcher);
			removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			removeEventListeners(Event.TRIGGERED);
			gameModel.removeEventListener(ModelEvent.GAMEMODEL_UPDATE, gameModelUpdate);
			gameModel.removeEventListener(ModelEvent.NEW_JELLY_CREATED,createJellyView);
		}
//		================================================================================
		override protected function onAddedToStage():void 
		{	
			var newGameBtn:Button = new Button(createTexture(),"New Game");
			newGameBtn.name = "newGameBtn";
			newGameBtn.alignPivot();
			newGameBtn.x = 80;
			newGameBtn.y = 40;
			addChild(newGameBtn);
			
			var menuBtn:Button = new Button(createTexture(),"Main Menu");
			menuBtn.name = "menuBtn";
			menuBtn.alignPivot();
			menuBtn.x = 80;
			menuBtn.y = 110;
			addChild(menuBtn);
			
			var playField:PlayField = new PlayField();
			playField.x = 15;
			playField.y = 200;
			addChild(playField);
			
			sprite = new Sprite();
			addChild(sprite);
			
			var bestScoreView:BestScoreView = new BestScoreView(gameModel);
			bestScoreView.x = 400;
			bestScoreView.y = 40;
			addChild(bestScoreView);
			
			var scoreView:ScoreView = new ScoreView(gameModel);
			scoreView.x = 400;
			scoreView.y = 120;
			addChild(scoreView);
			
			userInputController.startGame();
		}
//		================================================================================
		private function createTexture():Texture
		{
			var bgShape:Shape = new Shape();
			bgShape.graphics.clear();
			bgShape.graphics.beginFill(Color.YELLOW);
			bgShape.graphics.drawRoundRect(0, 0, 150, 60, 15, 15);
			bgShape.graphics.endFill();
			
			var bgBitmapData:BitmapData = new BitmapData(150, 60, true,0x00000000);
			bgBitmapData.draw(bgShape);
			
			return Texture.fromBitmapData(bgBitmapData, false, false, 1);
		}
//		================================================================================
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.ESCAPE:
				case Keyboard.BACK:
					(userInputController as IUserInputController).finishGame();
					this.viewsController.setView(GameConstants.WELCOME_VIEW);
					event.preventDefault();
					break;
				default:
					break;
			}
		}
//		================================================================================
		private function buttonClickEvent(event:Event):void
		{			
			if ((event.target as Button).name == "newGameBtn")
			{
				(userInputController as IUserInputController).finishGame();
				this.viewsController.setView(GameConstants.IN_GAME_VIEW);
			}else
			{
				(userInputController as IUserInputController).finishGame();
				this.viewsController.setView(GameConstants.WELCOME_VIEW);
			}
		}
//		================================================================================
		private function gameModelUpdate(event:ModelEvent):void
		{
				
		}
//		================================================================================		
		private function touchSwitcher(event:Event):void
		{
			if (hasEventListener(starling.events.TouchEvent.TOUCH))
				removeEventListener(starling.events.TouchEvent.TOUCH, onTouch);
			else
			{
				addEventListener(starling.events.TouchEvent.TOUCH, onTouch);
				gameModel.checkField();
			}
		}
//		================================================================================
		protected function onTouch(event:TouchEvent):void
		{		
			(userInputController as IUserInputController).inputHandler(event);
		}
//		================================================================================
		private function createJellyView(event:ModelEvent):void
		{
			var jelly_model:IItem = event.data as IItem;
			if (jelly_model)
			{
				var jelly_view:ComponentView = new JellyView(jelly_model);
				sprite.addChild(jelly_view);
			}
		}
//		================================================================================		
	}
}
package scenes {
	
	import constants.GameConstants;
	
	import controllers.IViewsController;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import models.IGameModel;
	
	import org.flashapi.hummingbird.view.AbstractStarlingSpriteView;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class MainMenuScene extends AbstractStarlingSpriteView implements IGameScene 
	{	
		[Controller(alias="ViewsController")]
		public var viewsController:IViewsController;
		
		[Model(alias="GameModel")]
		public var gameModel:IGameModel;
		
		override protected function onDependencyComplete():void
		{
		}
//		==================================================================
		override protected function onAddedToStage():void 
		{
			var bg_quad:Quad = new Quad(480,854,Color.PURPLE);
			addChild(bg_quad);
			
			var easyLevelBtn:Button = new Button(createTexture(),"Easy Level");
			easyLevelBtn.name = "easyLevelBtn";
			easyLevelBtn.alignPivot();
			easyLevelBtn.x = 240;
			easyLevelBtn.y = 200;
			addChild(easyLevelBtn);
			
			var middleLevelBtn:Button = new Button(createTexture(),"Middle Level");
			middleLevelBtn.name = "middleLevelBtn";
			middleLevelBtn.alignPivot();
			middleLevelBtn.x = 240;
			middleLevelBtn.y = 300;
			addChild(middleLevelBtn);
			
			var hardLevelBtn:Button = new Button(createTexture(),"Hard Level");
			hardLevelBtn.name = "hardLevelBtn";
			hardLevelBtn.alignPivot();
			hardLevelBtn.x = 240;
			hardLevelBtn.y = 400;
			addChild(hardLevelBtn);
			
			addEventListener(Event.TRIGGERED, mainMenuClickEvent);
		}
//		=======================================================================
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
//		=======================================================================
		private function mainMenuClickEvent(event:Event):void 
		{	
			var name:String = (event.target as Button).name;
			switch(name)
			{
				case "easyLevelBtn":
					gameModel.setDifficultyLevel(2);
					break;
				case "middleLevelBtn":
					gameModel.setDifficultyLevel(3);
					break;
				case "hardLevelBtn":
					gameModel.setDifficultyLevel(4);
					break;
				default:
				{
					break;
				}
			}
				this.viewsController.setView(GameConstants.IN_GAME_VIEW);
		}
//		=======================================================================
	}
}
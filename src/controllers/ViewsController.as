package controllers {
	
	import constants.GameState;
	import constants.GameConstants;
	
	import org.flashapi.hummingbird.Hummingbird;
	import org.flashapi.hummingbird.controller.AbstractController;
	
	import scenes.IGameScene;
	import scenes.InGameScene;
	import scenes.MainMenuScene;
	
	[Qualifier(alias="ViewsController")]
	public final class ViewsController extends AbstractController implements IViewsController {
		
		public function setView(viewId:uint):void {
//			Hummingbird.clearScene();//удаляет всех детей с рут сцены старлингаю
			switch(viewId) {
				case GameConstants.WELCOME_VIEW :
					_currentView = this.displayWelcomeView();
					break;
				case GameConstants.IN_GAME_VIEW :
					_currentView = this.displayInGameView();
					break;
			}
			Hummingbird.addToScene(_currentView);
		}
		
		private var _currentView:IGameScene;
		
		private function displayWelcomeView():IGameScene 
		{
			Hummingbird.removeFromScene(_currentView);
			return this.createView(MainMenuScene);
		}
		
		private function displayInGameView():IGameScene 
		{
			Hummingbird.removeFromScene(_currentView);
			return this.createView(InGameScene);
		}
		
		private function createView(ViewRef:Class):IGameScene 
		{
			return Hummingbird.getFactory().createView(ViewRef) as IGameScene;
		}
	}
}
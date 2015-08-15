package controllers
{
	import flash.geom.Point;
	
	import models.IGameModel;
	import models.IItem;
	import models.WaySerchAlgorithm;
	
	import org.flashapi.hummingbird.controller.AbstractController;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import views.ComponentView;
	import views.JellyView;
	import views.PlayField;
	
	[Qualifier(alias="UserInputController")]
	public class UserInputController extends AbstractController implements IUserInputController
	{
		[Model(alias="GameModel")]
		public var gameModel:IGameModel;
		
		public function UserInputController()
		{
			super();
		}
//		===============================================================
		public function inputHandler(event:TouchEvent):void
		{
			var compView:ComponentView;
			var i:int, j:int;
			var array:Array = gameModel.getItemsArray();
			
			var touch:Touch = event.getTouch(event.target as DisplayObject, TouchPhase.BEGAN);
			var wayAlgorithm:WaySerchAlgorithm = new WaySerchAlgorithm();
			
			if (touch)
			{	
				if ((compView = touch.target.parent as JellyView))
				{
					var jelly_model:IItem = compView.data_model as IItem;
					if (gameModel.departure)
					{
						gameModel.departure.unSelect();
						jelly_model.select();
						gameModel.departure = jelly_model; 
					}else
					{
						gameModel.departure = jelly_model;
						gameModel.departure.select();
						
					}
				}
				if ((compView = touch.target.parent as PlayField))
				{
					var cellSize:int = 50;
					var resPoint:Point = compView.globalToLocal(new Point(touch.globalX,touch.globalY));
					i = Math.ceil(resPoint.y/cellSize)-1;
					j = Math.ceil(resPoint.x/cellSize)-1;
					var arrival:String = i.toString()+j.toString();
					
					if (gameModel.departure)
					{
						var departure:String = gameModel.departure.getFieldPosition().i.toString() + 
											   gameModel.departure.getFieldPosition().j.toString();
						var way:Array = wayAlgorithm.getWay(departure,arrival,array);
						
						if (way)
						{
							gameModel.getItemsArray()[WaySerchAlgorithm.strToCoord(departure).i][WaySerchAlgorithm.strToCoord(departure).j] = departure;
							gameModel.getItemsArray()[i][j] = gameModel.departure;
							gameModel.departure.setWay(way);
						}
						gameModel.departure.unSelect();
						gameModel.departure = null;
					}
				}
			}
		}
//		=====================================================================
		public function finishGame():void
		{
			gameModel.finishGame();
		}
//		=====================================================================		
		public function startGame():void
		{
			gameModel.startGame();
		}
	}
}
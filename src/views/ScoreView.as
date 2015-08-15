package views
{
	import events.ModelEvent;
	
	import models.IGameModel;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;

	public class ScoreView extends ComponentView
	{	
		private var _scoreField:TextField;
		
		public function ScoreView(model:IGameModel, cntr:*=null)
		{
			super(model, cntr);
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
		}
//		=========================================================
		private function onRemoveFromStage():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
			data_model.removeEventListener(ModelEvent.SCORE_UPDATE,update);
		}
//		=========================================================
		private function onAddedToStage():void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			data_model.addEventListener(ModelEvent.SCORE_UPDATE,update);
			
			_scoreField = new TextField(145, 70, "0");
			_scoreField.border = true;
			_scoreField.fontSize = 40;
			_scoreField.color = Color.YELLOW;
			_scoreField.autoScale = true;			
//			_scoreField.hAlign   = starling.utils.HAlign.LEFT;
//			_scoreField.autoSize = TextFieldAutoSize.VERTICAL;
			addChild(_scoreField);
			
			_scoreField.alignPivot();	
		}
//		=========================================================
		override protected function update(event:*=null):void
		{
			event = event as ModelEvent;
			_scoreField.text = String(event.data);
		}
	}
}
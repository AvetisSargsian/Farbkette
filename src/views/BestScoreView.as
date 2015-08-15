package views
{
	import events.ModelEvent;
	
	import models.IGameModel;
	
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;

	public class BestScoreView extends ComponentView
	{
		private var _bestScoreField:TextField;
		
		public function BestScoreView(model:IGameModel, cntr:*=null)
		{
			super(model, cntr);
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
		}
//		=================================================================
		private function onRemoveFromStage():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
			data_model.removeEventListener(ModelEvent.BEST_SCORE_UPDATE,update);
		}
//		=================================================================
		private function onAddedToStage():void
		{	
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			data_model.addEventListener(ModelEvent.BEST_SCORE_UPDATE,update);
			
			_bestScoreField = new TextField(145, 70,"");
			_bestScoreField.text = (data_model as IGameModel).bestScore.toString();
			_bestScoreField.border = true;
			_bestScoreField.fontSize = 40;
			_bestScoreField.color = Color.YELLOW;
			_bestScoreField.autoScale = true;			
			addChild(_bestScoreField);
			_bestScoreField.alignPivot();
		}
//		=================================================================
		override protected function update(event:*=null):void
		{
			event = event as ModelEvent;
			_bestScoreField.text = String(event.data);
		}
	}
}
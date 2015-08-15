package events 
{
	import flash.events.Event;
	
	public class ModelEvent extends Event 
	{	
		
		public static const GAMEMODEL_UPDATE :String = "gameModelUpdate";
		public static const NEW_JELLY_CREATED:String = "newJellyCreated";
		public static const JELLYMODEL_UPDATE:String = "jellyModelUpdate";
		public static const JELLYMODEL_REMOVE:String = "jellyModelRemove";
		public static const TOUCH_SWITCHER   :String = "touch_off_on";
		public static const SCORE_UPDATE     :String = "scoreUpdate";
		public static const BEST_SCORE_UPDATE:String = "bestScoreUpdate";
		
		private var _data:Object;
		
		public function ModelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,data:Object = null) 
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
//		====================================================================
		public function get data():Object
		{
			return _data;
		}
//		====================================================================
		override public function clone():Event {
			return new ModelEvent(this.type, this.bubbles, this.cancelable);
		}
//		====================================================================
		override public function toString():String {
			return this.formatToString("ModelEvent", "type", "bubbles", "cancelable");
		}
	}
}
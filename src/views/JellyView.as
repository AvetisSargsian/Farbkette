package views
{
	import events.ModelEvent;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import models.IItem;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;

	public class JellyView extends ComponentView
	{
		public function JellyView(model:IItem, cntr:*=null)
		{
			super(model, cntr);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
			_data_model.addEventListener(ModelEvent.JELLYMODEL_UPDATE, modelUpdated);
			_data_model.addEventListener(ModelEvent.TOUCH_SWITCHER, function():void{ dispatchEventWith("TOUCH_SWITCHER",true)});
			_data_model.addEventListener(ModelEvent.JELLYMODEL_REMOVE, onRemoveEvent);
		}
//		===============================================================
		private function onRemoveEvent(event:ModelEvent):void
		{
			removeFromParent(true);			
		}
//		===============================================================
		private function onRemoveFromStage():void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveFromStage);
			_data_model.removeEventListener(ModelEvent.JELLYMODEL_UPDATE, modelUpdated);
			_data_model.removeEventListener(ModelEvent.TOUCH_SWITCHER, function():void{ dispatchEventWith("TOUCH_SWITCHER",true)});
			_data_model.removeEventListener(ModelEvent.JELLYMODEL_REMOVE, onRemoveFromStage);
		}
//		===============================================================
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createJellyView();
		}
//		===============================================================
		private function modelUpdated(event:ModelEvent):void
		{
			this.scaleX = (_data_model as IItem).getScale().x;
			this.scaleY = (_data_model as IItem).getScale().y;
			
			this.x = (_data_model as IItem).getPosition().x;
			this.y = (_data_model as IItem).getPosition().y;
		}
//		===============================================================
		private function createJellyView():void
		{
			var color:uint = (_data_model as IItem).getColor();
			var position:Object = (_data_model as IItem).getFieldPosition();
			
			var bgShape:Shape = new Shape();
			bgShape.graphics.clear();
			bgShape.graphics.beginFill(color);
			bgShape.graphics.drawCircle(23,23,23)
			bgShape.graphics.endFill();
			
			var bgBitmapData:BitmapData = new BitmapData(46, 46, true, 0x00ffffff);
			bgBitmapData.draw(bgShape);
			
			var texture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, 1);
			
			var jelly:Image = new Image(texture);
			addChild(jelly);
			
			this.x = PlayField.COORDINATES[position.i][position.j].x; 
			this.y = PlayField.COORDINATES[position.i][position.j].y;
			alignPivot();
		}		
		
	}
}
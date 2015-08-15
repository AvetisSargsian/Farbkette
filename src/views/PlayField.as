package views
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	public class PlayField extends ComponentView
	{
		private static var _COORDINATES:Array;
			
		public function PlayField(model:* = null, cntr:*=null)
		{
			super(model,cntr);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
//		==============================================================

		public static function get COORDINATES():Array
		{
			return _COORDINATES;
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createGameField();
			setCoordinates();
		}
//		==============================================================
		private function setCoordinates():void
		{
			_COORDINATES = [];
			
			var cellsSize:int = 50;
			var numCells:int = 9;
			var x_cord:int = this.x + cellsSize/2;
			var y_cord:int = this.y + cellsSize/2;
			
			for (var i:int = 0; i < numCells; i++)
			{ 
				_COORDINATES[i] = [];
				for (var j:int = 0; j < numCells; j++)
				{ 
					_COORDINATES[i][j] = new Point(x_cord,y_cord);
					x_cord += cellsSize;
				}
				x_cord = this.x + cellsSize/2;
				y_cord +=cellsSize;
			}
		}
//		==============================================================
		private function createGameField():void 
		{
			var cellsSize:int = 50;
			var numCells:int = 9;
			var x_cord:int = 0;
			var y_cord:int = 0;
			
			var bgShape:Shape = new Shape();
			bgShape.graphics.clear();
			bgShape.graphics.lineStyle(1.5,Color.RED);
			bgShape.graphics.moveTo(x_cord,y_cord);
			
			for (var i:int = 0; i < numCells+1; i++)
			{
				bgShape.graphics.lineTo(x_cord + (cellsSize * numCells),y_cord);
				y_cord += cellsSize;
				bgShape.graphics.moveTo(x_cord,y_cord);	
			}
			
			x_cord = 0;
			y_cord = 0;
			bgShape.graphics.moveTo(x_cord,y_cord);
			
			for (i = 0; i < numCells+1; i++)
			{
				bgShape.graphics.lineTo(x_cord, y_cord+(cellsSize * numCells));
				x_cord += cellsSize;
				bgShape.graphics.moveTo(x_cord,y_cord);
			}
			
			bgShape.graphics.endFill();
			
			var bgBitmapData:BitmapData = new BitmapData(450, 450, true, 0x00000000);
			bgBitmapData.draw(bgShape);
			
			var texture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, 1);
			
			var bgCells:Image = new Image(texture);
			bgCells.name = "bgCells";
			addChild(bgCells);
		}
		
		override public function toString():String
		{
			return "PlayFieald";
		}
	}
}
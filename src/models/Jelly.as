package models
{
	import events.ModelEvent;
	
	import flash.geom.Point;
	
	import org.flashapi.hummingbird.Hummingbird;
	import org.flashapi.hummingbird.model.AbstractModel;
	
	import starling.animation.Tween;
	import starling.utils.Color;
	
	import views.PlayField;

	public class Jelly extends AbstractModel implements IItem
	{
		private var _color:int;
		private var _fieldPosition:Object = { "i":null,"j":null };
		private var _scale:Object = { "x":1,"y":1 };
		private var _state:Boolean;
		private var _position:Point;
		private static const COLORS:Array = [Color.RED,Color.BLUE,Color.GREEN,Color.AQUA,Color.YELLOW,Color.WHITE];
		
		public function Jelly(i_pos:int,j_pos:int)
		{
			_color = COLORS[Math.floor(Math.random()*(COLORS.length))];
			_fieldPosition.i = i_pos;
			_fieldPosition.j = j_pos;
			
			_position = new Point();
			_position.x = PlayField.COORDINATES[_fieldPosition.i][_fieldPosition.j].x;
			_position.y = PlayField.COORDINATES[_fieldPosition.i][_fieldPosition.j].y;
			_state = false;
		}
//		==========================================================
		public function isSelected():Boolean
		{
			return _state;
		}
//		==========================================================
		public function getScale():Object
		{
			return _scale;
		}
//		==========================================================
		public function getFieldPosition():Object
		{
			return _fieldPosition;
		}
//		==========================================================
		public function getPosition():Point
		{
			return _position;
		}
//		==========================================================
		public function getColor():uint
		{
			return _color;
		}
//		==========================================================
		public function setWay(way:Array):void
		{
			dispatchEvent(new ModelEvent(ModelEvent.TOUCH_SWITCHER));
			move(way);
		}
//		==========================================================
		private function move(way:Array):void
		{
			var to_point:Point = new Point();			
			var i:int = WaySerchAlgorithm.strToCoord(way[0]).i;
			var j:int = WaySerchAlgorithm.strToCoord(way[0]).j;
			to_point.x = PlayField.COORDINATES[i][j].x;
			to_point.y = PlayField.COORDINATES[i][j].y;
			
			var tween:Tween  = new Tween(_position,0.1);
			tween.animate("x",to_point.x);
			tween.animate("y",to_point.y);
			tween.onUpdate = update;
			Hummingbird.getStarling().juggler.add(tween);
			
			tween.onComplete =	function():void
			{
				_fieldPosition = { "i":i,"j":j };
				way.splice(0,1);
				if (way.length>0)
					move(way);
				else
					dispatchEvent(new ModelEvent(ModelEvent.TOUCH_SWITCHER));
			};
		}
//		==========================================================
		public function select():void
		{
			if (_state == true){return;}
			var tween:Tween  = new Tween(_scale,0.1);
			tween.animate("y",0.8);
			tween.onComplete =	function():void{_state = true;};
			tween.onUpdate = update;
			Hummingbird.getStarling().juggler.add(tween);
		}
//		==========================================================
		public function unSelect():void
		{
			if (_state == false) return;
			var tween:Tween  = new Tween(_scale,0.1);
			tween.animate("y",1);
			tween.onComplete =	function():void{_state = false;};
			tween.onUpdate = update;
			Hummingbird.getStarling().juggler.add(tween);
		}
//		==========================================================
		private function update():void
		{
			dispatchEvent(new ModelEvent(ModelEvent.JELLYMODEL_UPDATE));
		}
//		==========================================================
		public function remove():void
		{
			var tween:Tween  = new Tween(_scale,0.2);
			tween.animate("y",0.1);
			tween.animate("x",0.1);
			tween.onComplete =	function():void{ dispatchEvent(new ModelEvent(ModelEvent.JELLYMODEL_REMOVE))};
			tween.onUpdate = update;
			Hummingbird.getStarling().juggler.add(tween);
		}
	}
}
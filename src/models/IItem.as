package models
{
	import flash.geom.Point;
	
	import org.flashapi.hummingbird.model.IModel;

	public interface IItem extends IModel
	{
		function getFieldPosition():Object;
		function getPosition():Point;
		function getColor():uint;
		function select():void;
		function unSelect():void
		function getScale():Object;
		function isSelected():Boolean;
		function setWay(way_array:Array):void;
		function remove():void;
	}
}
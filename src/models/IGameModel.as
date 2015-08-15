package models
{
	import org.flashapi.hummingbird.model.IModel;
	
	public interface IGameModel extends IModel
	{
		function finishGame():void
		function startGame():void
		function getScore():int;
		function get departure():IItem;
		function set departure(value:IItem):void;
		function checkField():void;
		function getItemsArray():Array;
		function setDifficultyLevel(level:int):void;
		function get bestScore():int;
		function set bestScore(value:int):void
	}
}
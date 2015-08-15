package controllers
{
	import starling.events.TouchEvent;
	import org.flashapi.hummingbird.controller.IController;

	public interface IUserInputController extends IController
	{
		function finishGame():void;
		function startGame():void;
		function inputHandler(event:TouchEvent):void;
		
	}
}
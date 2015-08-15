package controllers
{
	import org.flashapi.hummingbird.controller.IController;
	
	public interface ILoaderController extends IController
	{
		function load():void;
	}
}
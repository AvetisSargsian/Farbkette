package controllers {
	
	import org.flashapi.hummingbird.controller.IController;
	
	public interface IViewsController extends IController
	{	
		function setView(viewId:uint):void;
	}
}
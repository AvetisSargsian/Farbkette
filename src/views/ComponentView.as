package views
{	
	import starling.display.Sprite;
	import starling.errors.AbstractMethodError;
	
	public class ComponentView extends Sprite
	{
		protected var _data_model:*;
		protected var _controller:*;
		
		public function ComponentView(model:* = null,cntr:* = null)
		{
			super();
			_data_model = model;
			_controller = cntr;
		}
//		======================================================================
		public function get data_model():*
		{
			return _data_model;
		}
//		======================================================================
		public function get controller():*
		{
			return _controller;
		}
//		======================================================================
		public function add(c:ComponentView):void
		{
			throw new AbstractMethodError("add operation not suported");
		}
//		======================================================================
		public function remove(c:ComponentView):void
		{
			throw new AbstractMethodError("remove operation not suported");
		}
//		======================================================================
		public function getChild(n:int):ComponentView
		{
			throw new AbstractMethodError("add operation not suported");
			return null;
		}
//		======================================================================
		public function getChildrenCount():int
		{
			throw new AbstractMethodError("add operation not suported");
			return null;
		}
//		======================================================================
		protected function update(event:* = null):void {}
//		======================================================================
		public function toString():String
		{
			return "ComponentView";
		}
	}
}
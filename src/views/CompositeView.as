package views
{
	import starling.events.Event;
	
	public class CompositeView extends ComponentView
	{
		private var children:Array;
		
		public function CompositeView(model:* = null, cntr:*=null)
		{
			super(model, cntr);
			children = new Array();
		}
//		==============================================================
		override public function add(c:ComponentView):void
		{
			children.push(c);
		}
//		==============================================================
		override public function remove(c:ComponentView):void
		{
			for (var i:int = 0,l:int = children.length;i<l;i++)
			{
				if (c == children[i])
				{
					children.splice(i,1);
					break;
				}
			}
		}
//		==============================================================
		override public function getChild(n:int):ComponentView
		{
			return children[n];
		}
//		==============================================================
		override public function getChildrenCount():int
		{
			return children.length;
		}
//		==============================================================
		override public function update(event:Event = null):void
		{
			for each(var child:ComponentView in children)
			{
				child.update(event);
			}
		}
		override public function toString():String
		{
			return "CompositeView";
		}
	}
}
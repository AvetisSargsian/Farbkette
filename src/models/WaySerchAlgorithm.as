package models
{
	public class WaySerchAlgorithm
	{	
		private var _departure:String;
		private var _arrival:String;
		private var treeTable:Array;
		private var _mainTableCopy:Array;
		
		public function WaySerchAlgorithm()
		{
			
		}
//		==========================================================
		public function getWay(departure:String,arrival:String,mainTable:Array):Array
		{
			_departure = departure;
			_arrival = arrival;
			_mainTableCopy = copy(mainTable);
			treeTable = new Array();
			gatherTreeTable(_departure,treeTable);
			return getWayPoints(treeTable);
		}
//		==========================================================
		private function copy(mainTable:Array):Array
		{
			var array:Array = [];
			for (var i:int=0,l:int=mainTable.length;i<l;i++)
			{
				array[i] = [];
				for(var j:int = 0,ln:int=mainTable[i].length;j<ln;j++)
				{
					array[i][j] = mainTable[i][j];
				}
			}
			return array;
		}
//		==========================================================
		private function gatherTreeTable(startPoint:String,arrayTree:Array):Array
		{
			var points:Array = [];
			var nextPoints:Array = [];
				
			if (!arrayTree[0]){
				arrayTree[0] = [startPoint];
				_mainTableCopy[strToCoord(startPoint).i][strToCoord(startPoint).j] = null;
			}
			points = arrayTree[arrayTree.length-1];
			
			for (var i:int = 0,l:int = points.length; i < l;i++)
			{	
				var n:int = strToCoord(points[i]).i - 1;
				var m:int = strToCoord(points[i]).j;
				if (n>=0 && _mainTableCopy[n][m] is String) {
					nextPoints.push( _mainTableCopy[n][m]);
					_mainTableCopy[n][m] = null 
				}
				
				n = strToCoord(points[i]).i + 1;
				m = strToCoord(points[i]).j;
				if(n<9 && _mainTableCopy[n][m] is String) {
					nextPoints.push(_mainTableCopy[n][m]);
					_mainTableCopy[n][m] = null; 
				}
				
				n = strToCoord(points[i]).i;
				m = strToCoord(points[i]).j - 1;
				if (m>=0 && _mainTableCopy[n][m] is String) {
					nextPoints.push(_mainTableCopy[n][m]);
					_mainTableCopy[n][m] = null;
				}
				
				n = strToCoord(points[i]).i;
				m = strToCoord(points[i]).j + 1;
				if (m<9 && _mainTableCopy[n][m] is String) {
					nextPoints.push(_mainTableCopy[n][m]);
					_mainTableCopy[n][m] = null;
				}
			}
			if (nextPoints.length != 0)
			{
				arrayTree.push(nextPoints);
				if ( !enterInArray(_arrival,nextPoints) )
					gatherTreeTable(startPoint,arrayTree);
			}
			return arrayTree;
		}
//		==========================================================
		private function getWayPoints(tree:Array):Array
		{
			var wayPoints:Array = new Array();
			if ( enterInArray( _arrival, tree[tree.length-1]))
			{	
				wayPoints.push(_arrival);
				
				for (var n:int = tree.length-2; n >= 0; n--)
				{
					for (var m:int=0, len:int=tree[n].length; m<len; m++)
					{
						var difI:int = Math.abs(strToCoord(tree[n][m]).i - strToCoord(wayPoints[0]).i);
						var difJ:int = Math.abs(strToCoord(tree[n][m]).j - strToCoord(wayPoints[0]).j);
						if (difI <= 1 && difJ <=1){
							wayPoints.unshift(tree[n][m]);
							break;
						}
					}
				}
				return wayPoints;
			}else
			{
				return null;
			}
		}
//		==========================================================
		public static function strToCoord(str:String):Object
		{	
			var obj:Object = {"i":null,"j":null};
			if (str)
			{	
				obj.i = int(str.charAt(0));
				obj.j = int(str.charAt(1));
			}else
			{
				obj.i = -1;
				obj.j = -1;
			}
			return obj
		}
//		==========================================================
		private function enterInArray(value:String, array:Array):Boolean
		{
			for (var i:int = 0,l:int = array.length; i < l; i++){
				if (array[i] == value){
					return true;
				}
			}
			return false;
		}
//		==========================================================
	}
}
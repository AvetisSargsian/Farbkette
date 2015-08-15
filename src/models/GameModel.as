package models
{
	import events.ModelEvent;
	
	import flash.events.Event;
	
	import org.flashapi.hummingbird.model.AbstractModel;
	
	[Qualifier(alias="GameModel")]
	public class GameModel extends AbstractModel implements IGameModel
	{
		private const fieldSize:uint = 9;
		private var _score:int = 0;
		private var _bestScore:int;
		private var _itemsArray:Array;
		private var _departure:IItem = null;
		private var _difficultyLevel:int;
		
		public function GameModel() 
		{
			initialize();
		}
//		==========================================================
		public function get departure():IItem
		{
			return _departure;
		}
//		==========================================================
		public function setDifficultyLevel(level:int):void
		{
			_difficultyLevel = level;
		}
//		==========================================================
		public function set departure(value:IItem):void
		{
			_departure = value;
		}
//		==========================================================
		public function getItemsArray():Array
		{
			return _itemsArray;
		}
//		==========================================================
		public function getScore():int
		{
			return _score;
		}
//		==========================================================
		public function get bestScore():int
		{
			return _bestScore;
		}
//		==========================================================
		public function set bestScore(value:int):void
		{
			_bestScore = value;
			dispatchEvent(new ModelEvent(ModelEvent.BEST_SCORE_UPDATE,false,false,_bestScore));
		}		
//		==========================================================
		public function startGame():void
		{
			addItemsOnField(5);
		}
//		==========================================================
		public function finishGame():void
		{
			initialize();
			score = 0;
			_departure = null;
		}
//		==========================================================
		public function checkField():void
		{
			var score:int = _score;
			chekForRemove(_itemsArray);
			if (score == _score)
			{
				addItemsOnField(3);
				chekForRemove(_itemsArray);
			}
		}
//		==========================================================
		private function initialize():void
		{
			_itemsArray = inintPlayField();	
		}
//		==========================================================
		private function inintPlayField():Array
		{
			var array:Array = [];
			for (var i:int = 0;i < fieldSize; i++)
			{
				array[i] = [];
				for(var j:int = 0;j < fieldSize; j++)
				{
					array[i][j] = String(i)+String(j);
				}
			}
			return array;
		}
//		==========================================================
		private function set score(value:int):void
		{
			_score = value;
			if (_score > _bestScore)
				bestScore = _score;
			dispatchEvent(new ModelEvent(ModelEvent.SCORE_UPDATE,false,false,_score));
		}
//		==========================================================
		private function findRandomPlaces(plCount:uint, itemsArray:Array):Array
		{
			if (plCount < 0) return null;
			var table:Array = new Array();
			for (var i:int = 0; i < fieldSize; i++){
				for (var j:int = 0; j < fieldSize; j++){
					if (_itemsArray[i][j] is String){
						table.push( _itemsArray[i][j] );
					}
				}
			}
			
			if (table.length >= plCount)
			{
				var placeArray:Array = new Array(), n:int;
				for (i=0; i < plCount; i++)
				{
					n = Math.ceil(Math.random() * (table.length - 1));
					placeArray.push(table[n]);
					table.splice(n,1);
				}
				return placeArray;
			}else
			{
				return null
			}
		}
//		==========================================================
		private function addItemsOnField(items_count:uint):void
		{
			var places:Array = findRandomPlaces(items_count,_itemsArray);
			
			if (places)
			{
				for(var i:int = 0,l:int = places.length; i<l; i++)
				{
					var n:int = WaySerchAlgorithm.strToCoord(places[i]).i;
					var m:int = WaySerchAlgorithm.strToCoord(places[i]).j;
					_itemsArray[n][m] = new Jelly(n,m);
					this.dispatchEvent(new ModelEvent(ModelEvent.NEW_JELLY_CREATED,false,false,_itemsArray[n][m]));
				}
			}else
			{
				//закончить игру так как не осталось достаточно мест для добавления предметов
				//finishGame();
				trace("GameEnd");
			}
		}
//		==========================================================
		private function chekForRemove(itemsArray:Array):void
		{
			var gorizontal_array:Array = [];
			var vertical_array:Array = [];
			var n:int;
			for(var i:int=0; i<fieldSize; i++)
			{
				for(var j:int=0; j<fieldSize; j++)
				{
					
					if (itemsArray[i][j] is Jelly)
					{
						if (gorizontal_array.length > 0)
						{
							n = gorizontal_array[gorizontal_array.length-1].getFieldPosition().j;
							if ( Math.abs(n-j)>1 || 
								 gorizontal_array[gorizontal_array.length-1].getColor() != itemsArray[i][j].getColor())
							{
								removeItems(gorizontal_array);
								gorizontal_array.length = 0;
							}
						} 
						gorizontal_array.push(itemsArray[i][j]);
					}
					
					if (itemsArray[j][i] is Jelly)
					{	
						if (vertical_array.length > 0)
						{
							n = vertical_array[vertical_array.length-1].getFieldPosition().i;
							if ( Math.abs(n - j) > 1 ||  
								vertical_array[vertical_array.length-1].getColor() != itemsArray[j][i].getColor() )
							{
								removeItems(vertical_array);
								vertical_array.length = 0;
							}
						}
						vertical_array.push(itemsArray[j][i]);
					}
				}
				removeItems(gorizontal_array);
				gorizontal_array.length = 0;
				
				removeItems(vertical_array);
				vertical_array.length = 0;
			}
		}
//		==========================================================
		private function removeItems(array:Array):void
		{
			var k:int,p:int,i:int;
			if (array.length > _difficultyLevel)
			{
				switch(array.length)
				{
					case 3:
						score = _score + 2;
						break;
					case 4:
						score = _score + 5;
						break;
					case 5:
						score = _score + 10;
						break;
					case 6:
						score = _score + 14;
						break;
					case 7:
						_score = _score + 20;
						break;
					case 8:
						score = _score + 28;
						break;
					case 9:
						score = _score + 40;
						break;
				}
				
				for (i=0; i<array.length; i++)
				{
					(array[i] as IItem).remove();
					k = (array[i] as IItem).getFieldPosition().i;
					p = (array[i] as IItem).getFieldPosition().j;
					_itemsArray[k][p] = k.toString() + p.toString();
				} 
				array.length = 0;
			}
		}
//		==========================================================
		private function update():void
		{
			this.dispatchEvent(new ModelEvent(ModelEvent.GAMEMODEL_UPDATE));
		}
	}
}
package com.andywoods.multitrialapp.view
{
	import com.andywoods.multitrialapp.data.CardProperties;
	import com.andywoods.multitrialapp.data.GroupProperties;
	import com.andywoods.multitrialapp.data.ItemVO;
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.events.RowEvent;
	import com.andywoods.multitrialapp.view.ui.FullScreenScrollBar;
	import com.andywoods.multitrialapp.view.ui.Group;
	import com.andywoods.multitrialapp.view.ui.Row;
	import com.andywoods.multitrialapp.view.ui.TileBackgroundFiller;
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class CardContainer extends AbstractView
	{
		private var container:Sprite;
		private var rowNames:Array;
		private var groupedCards:Dictionary;
		private var scrollBar:FullScreenScrollBar;
		private var background:TileBackgroundFiller;
		
		public  var rows:Array;
		
		public function CardContainer(w:Number, h:Number)
		{
			super();
			
			background = new TileBackgroundFiller();
			background.addEventListener( MouseEvent.MOUSE_DOWN, handleBackgroundClicked );
			addChild( background );
			
			container = new Sprite();
			
			scrollBar = new FullScreenScrollBar(container, background, 0x222222, 0xff4400, 0x05b59a, 0xffffff, 15, 15, 4, true);
			addChild(scrollBar);
		}
		
		protected function handleBackgroundClicked(event:MouseEvent):void
		{
			dispatchEvent( new AppEvent( AppEvent.DESELECT_EVERYTHING ) );
		}
		
		public function build(items:Vector.<ItemVO>, cardProperties:CardProperties = null, groupProperties:GroupProperties = null):void
		{
			container = new Sprite();
			scrollBar.content = container;
			addChild( container );
			rows = [];
			rowNames = [];
			groupedCards = new Dictionary;
				
		
			for (var a:int = 0; a < items.length; a++) 
			{
				if(rowNames.indexOf( items[a].groupID ) == -1)
				{
					rowNames.push( items[a].groupID );
					groupedCards[ items[a].groupID ] = [];
				}
				
				groupedCards[ items[a].groupID ].push( items[a] );
			}
			
			var previousRow:Row = null;
			
			for (var b:int = 0; b < rowNames.length; b++) 
			{
				var group:Group = new Group( cardProperties, groupProperties );
				group.popuplate( groupedCards[ rowNames[b] ] );
				
				var row:Row = new Row();
				row.index = b;
				row.addEventListener( "empty", handleEmptyRow );
				row.addGroup( group );
				row.verticalPosition = b * group.height;
				row.onDrag = handleRowDrag;
				row.onDrop = handleRowDrop;
				row.y = b * group.height;
				
				if(previousRow == null)
				{
					previousRow = row;
				}
				else
				{
					row.previousRow = previousRow;
					previousRow.nextRow = row;
				}
				
				previousRow = row;
				
				container.addChild( row );
				rows.push( row );
			}
			
			previousRow = null;
			
			scrollBar.adjustSize();
			
			log( this, "Created." );
		}
		
		protected function handleRowDrag( draggingRow:Row ):void
		{			
			container.setChildIndex(draggingRow, container.numChildren-1);
			
			var row:Row;
			for (var i:int = 0; i < container.numChildren; i++)
			{
				if(container.getChildAt(i) is Row)
				{
					row = container.getChildAt(i) as Row;
					if( row != draggingRow )
					{
						var point:Point = container.localToGlobal(new Point(10, row.y + (row.height*0.5)));
						if(draggingRow.hitTestPoint(point.x, point.y))
						{
							swapVerticalPosition( row, draggingRow );
							row.y = row.verticalPosition;
						}
					}
				}
			}
			row = null;
		}
		
		public function handleRowDrop( draggingRow:Row = null ):void
		{
			var needsUpdating:Boolean = invalidateRows();			
			var rowIds:Array = toArray();
			
			if(needsUpdating)	
				dispatchEvent( new RowEvent( RowEvent.ROW_POSITION_UPDATE, {rowsAsStringArray:rowIds} ) );
		}
		
		private function swapVerticalPosition(rowA:Row, rowB:Row):void
		{
			var tempA:Number = rowA.verticalPosition;
			var tempB:Number = rowB.verticalPosition;
			
			rowA.verticalPosition = tempB;
			rowB.verticalPosition = tempA;
		}
		
		private function toArray():Array
		{
			var arr:Array = [];
			var row:Row;
			
			for (var a:int = 0; a < rows.length; a++) 
			{
				if(container.getChildAt(a) is Row)
				{
					row = container.getChildAt(a) as Row;
					arr.push( row.toArray() );
				}
			}			
			
			return arr;
		}
		
		protected function handleEmptyRow(event:Event):void
		{
			var row:Row = event.target as Row;
			
			rows.splice(rows.indexOf(row), 1);
			
			row.previousRow = null;
			row.nextRow = null;
			row.removeEventListener( "empty", handleEmptyRow );
			container.removeChild( row );
			
			invalidateRows();
		}
		
		private function invalidateRows():Boolean
		{
			var previousRow:Row 		= null;			
			var row:Row 				= null;		
			var verticalPosition:Number = 0;
			var a:int 					= 0;
			
			rows.sortOn("y", Array.NUMERIC);
			
			var needsUpdating:Boolean = false;
			
			for (a = 0; a < rows.length; a++) 
			{
				row = rows[a];
				
				container.setChildIndex( row, a );
				
				if( a == 0 )
				{
					row.verticalPosition = 0;
				}
				else
				{
					row.verticalPosition = a * previousRow.height;
				}
				
				
				TweenMax.to( row, 0.2, {y:row.verticalPosition, x:0, onUpdate:scrollBar.adjustSize} );				
				
				if(previousRow)
				{
					if(row.previousRow != previousRow) needsUpdating = true;
					
					row.previousRow = previousRow;
					previousRow.nextRow = row;
				}
				
				previousRow = row;
			}	

			row = null;
			previousRow = null;
			
			return needsUpdating;
		}
		
		override protected function onResize():void
		{
			background.width  = stage.stageWidth;
			background.height = stage.stageHeight;
			scrollBar.adjustSize();
		}
	}
}
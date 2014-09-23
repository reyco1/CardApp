package com.andywoods.multitrialapp.view.ui
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Row extends Sprite
	{
		private var _previousRow:Row = null;
		private var _nextRow:Row = null;
		
		public var verticalPosition:Number;
		public var onDrag:Function;
		public var index:int;
		
		public function Row()
		{
			super();			
			addEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
		}

		protected function handleMouseUp(event:MouseEvent):void
		{
			stopDrag();
			
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
			
			TweenMax.to(this, 0.2, {y:verticalPosition});
		}
		
		protected function handleMouseDown(event:MouseEvent):void
		{
			startDrag( false, new Rectangle(0, 0, 0, parent.height) );
			
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, handleMouseMove );
		}
		
		protected function handleMouseMove(event:MouseEvent):void
		{
			if( onDrag != null )
				onDrag.call( null, this );
		}
		
		public function addGroup(group:Group):void
		{
			group.addEventListener( Event.RESIZE, handleGroupResize );
			group.addEventListener( "empty", handleGroupEmpty );
			
			if(group.row)
				group.previousRow = group.row;
			
			group.row = this;
			
			group.x = width;
			
			addChild( group );
		}
		
		public function removeGroup(group:Group):void
		{
			if( contains(group) )
			{
				group.removeEventListener( Event.RESIZE, handleGroupResize );
				group.removeEventListener( "empty", handleGroupEmpty );
				
				removeChild( group );
			}
		}
		
		public function clear():void
		{
			removeEventListener( MouseEvent.MOUSE_DOWN, handleMouseDown );
			removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
		}
		
		protected function handleGroupEmpty(event:Event):void
		{
			var g:Group = event.target as Group;
			removeGroup( g );
			handleGroupResize(null);
			
			if(numChildren == 0)
				dispatchEvent( new Event("empty") );
		}
		
		protected function handleGroupResize(event:Event):void
		{
			for (var a:int = 1; a < numChildren; a++) 
			{
				getChildAt( a ).x = getChildAt( a-1 ).x + getChildAt( a-1 ).width;
			}
		}		
		
		public function get nextRow():Row { return _nextRow; }
		public function set nextRow(value:Row):void
		{
			_nextRow = value;
		}
		
		public function get previousRow():Row { return _previousRow; }
		public function set previousRow(value:Row):void
		{
			_previousRow = value;
		}
	}
}
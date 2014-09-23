package com.andywoods.multitrialapp.manager
{
	import com.andywoods.multitrialapp.data.DragProperties;
	import com.andywoods.multitrialapp.model.AppModel;
	import com.andywoods.multitrialapp.util.Delegate;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	public class DragManager
	{
		[Inject] public var model:AppModel;
		
		public var draggableObjects:Dictionary;
		public var isDragging:Boolean;
		
		public function init():void
		{
			draggableObjects = new Dictionary();
			isDragging = false;
			log( this, "Initialized." );
		}
		
		public function enableDrag( displayObj:DisplayObject, dragProperties:DragProperties = null ):void
		{
			displayObj.addEventListener(MouseEvent.MOUSE_DOWN, startDrag);
			draggableObjects[displayObj] = dragProperties;
		}
		
		public function disableDrag( displayObj:DisplayObject ):void
		{
			displayObj.removeEventListener(MouseEvent.MOUSE_DOWN, startDrag);
			delete draggableObjects[displayObj];
		}
		
		public function clear():void
		{
			for each(var key:Object in draggableObjects)
			{
				var targetProps:DragProperties = draggableObjects[key];
				var target:Sprite 			   = draggableObjects[key].target as Sprite;
				
				disableDrag(target);
			}
		}
		
		protected function startDrag(event:Event):void
		{
			var displayObj:Sprite 				= event.target as Sprite;
			var dragProperties:DragProperties 	= draggableObjects[displayObj];
			
			displayObj.startDrag(dragProperties.snapToCenter, dragProperties.dragRect);			
			
			displayObj.stage.addEventListener(MouseEvent.MOUSE_UP,   stopDrag);
			displayObj.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			
			isDragging = true;
		}
		
		protected function stopDrag(event:MouseEvent):void
		{
			var displayObj:Sprite 				= event.target as Sprite;
			var dragProperties:DragProperties 	= draggableObjects[displayObj];
			
			if( displayObj )
			{
				displayObj.stopDrag();
				displayObj.stage.removeEventListener(MouseEvent.MOUSE_UP,   stopDrag);
				displayObj.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			}
			
			isDragging = false;
			
			if(dragProperties && dragProperties.onRelease) 
				Delegate.execute(dragProperties.onRelease, dragProperties.onReleaseParams);
		}
		
		protected function handleMove(event:MouseEvent):void
		{
			var displayObj:Sprite 				= event.target as Sprite;
			var dragProperties:DragProperties 	= draggableObjects[displayObj];
			
			if(dragProperties && dragProperties.onUpdate) 
				Delegate.execute(dragProperties.onUpdate, dragProperties.onUpdateParams);
			
			event.updateAfterEvent();
		}
	}
}
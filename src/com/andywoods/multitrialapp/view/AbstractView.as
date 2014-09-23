package com.andywoods.multitrialapp.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	
	public class AbstractView extends Sprite
	{
		protected var isFullscreen:Boolean;
		
		public function AbstractView()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, handleAdded );
			isFullscreen = false;
		}
		
		private function handleAdded(event:Event):void
		{
			onAdded();
			
			removeEventListener( Event.ADDED_TO_STAGE, handleAdded );
			
			addEventListener( Event.REMOVED_FROM_STAGE, handleRemove );
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, handleFullScreen);
			stage.addEventListener(Event.RESIZE, handleResize); 
		}
		
		private function handleResize(event:Event):void
		{
			onResize();
		}
		
		private function handleRemove(event:Event):void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, handleRemove );
			stage.removeEventListener(FullScreenEvent.FULL_SCREEN, handleFullScreen);
			stage.removeEventListener(Event.RESIZE, handleResize);
			onRemoved();
		}
		
		private function handleFullScreen(event:FullScreenEvent):void
		{
			isFullscreen = event.fullScreen;
			onResize();
		}		
		
		protected function onResize():void{}		
		protected function onRemoved():void{}		
		protected function onAdded():void{}
	}
}


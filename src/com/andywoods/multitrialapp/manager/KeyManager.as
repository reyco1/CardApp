package com.andywoods.multitrialapp.manager
{
	import com.andywoods.multitrialapp.events.ExternalRequestEvent;
	import com.andywoods.multitrialapp.events.KeyManagerEvent;
	import com.andywoods.multitrialapp.model.AppModel;
	
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KeyManager
	{
		[Inject] public var model:AppModel;
		[Inject] public var dispatcher:IEventDispatcher;
		
		private var stage:Stage;
		private var lib:Array = [];
		
		public function init( s:Stage ):void
		{
			stage = s;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, 	handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, 	handleKeyUp);
			
			log( this, "Initialized." );
		}
		
		public function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, 	handleKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, 	handleKeyUp);
		}
		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			lib[e.keyCode] = true;
			
			if( e.keyCode == Keyboard.DELETE )
			{
				dispatcher.dispatchEvent( new ExternalRequestEvent(ExternalRequestEvent.DELETE) );
			}
			
			if( e.keyCode == Keyboard.M )
			{
				if( model.selecteGroups.length == 1 )
				{
					dispatcher.dispatchEvent( new ExternalRequestEvent(ExternalRequestEvent.MERGE) );
				}
			}
			
			if( e.keyCode == Keyboard.A )
			{
				if( model.selecteGroups.length == 1 )
				{
					dispatcher.dispatchEvent( new ExternalRequestEvent(ExternalRequestEvent.ADD) );
				}
			}
		}
		
		private function handleKeyUp(e:KeyboardEvent):void
		{
			lib[e.keyCode] = false;
		}
		
		public function isKeyDown( keyCode:uint ):Boolean
		{
			return lib[keyCode] as Boolean;
		}
	}
}
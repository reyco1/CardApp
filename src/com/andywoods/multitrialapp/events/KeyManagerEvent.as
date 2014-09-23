package com.andywoods.multitrialapp.events
{
	import flash.events.Event;
	
	public class KeyManagerEvent extends Event
	{
		private var _data:*;
		
		public static const MERGE:String	= "KeyManagerEvent.mergeRequest";
		public static const ADD:String		= "KeyManagerEvent.addRequest";
		
		public function KeyManagerEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data():*
		{
			return _data;
		}

		override public function clone():Event
		{
			return new KeyManagerEvent(type, bubbles, cancelable);
		}
	}
}
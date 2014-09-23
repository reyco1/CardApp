package com.andywoods.multitrialapp.events
{
	import flash.events.Event;
	
	public class ExternalRequestEvent extends Event
	{
		public static const MERGE:String 	= "ExternalRequestEvent.onMergeRequest";
		public static const ADD:String 	 	= "ExternalRequestEvent.onAddRequest";
		public static const DELETE:String 	= "ExternalRequestEvent.onDeleteRequest";
		public static const ADD_CARDS:String= "ExternalRequestEvent.onAddCardsRequest";
		
		private var _data:String;
		
		public function ExternalRequestEvent(type:String, data:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_data = data;
			super(type, bubbles, cancelable);
		}

		public function get data():String
		{
			return _data;
		}
		
		override public function clone():Event
		{
			return new ExternalRequestEvent(type, _data, bubbles, cancelable);
		}

	}
}
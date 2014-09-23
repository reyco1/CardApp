package com.andywoods.multitrialapp.events
{
	import flash.events.Event;
	
	public class RowEvent extends Event
	{
		public var _data:*;
		
		public static const ROW_POSITION_UPDATE:String = "RowEvent.onUpdatePosition";
		
		public function RowEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return new RowEvent(type, _data, bubbles, cancelable);
		}
	}
}
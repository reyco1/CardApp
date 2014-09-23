package com.andywoods.multitrialapp.events
{
	import flash.events.Event;

	public class GroupEvent extends Event
	{
		private var _data:*;
		
		public static const DESELECT_ALL_SELECTED_GROUPS:String = "GroupEvent.onDeselectAll";
		public static const GROUP_EDIT_CLICKED:String 			= "GroupEvent.onGroupEditClicked";
		
		public function GroupEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return new GroupEvent(type, _data, bubbles, cancelable);
		}
	}
}
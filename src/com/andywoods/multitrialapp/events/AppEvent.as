package com.andywoods.multitrialapp.events
{
	import flash.events.Event;

	public class AppEvent extends Event
	{
		private var _data:*;
		
		public static const INITIALIZE:String 				 = "AppEvent.init";
		public static const INITIALIZE_COMPLETE:String 		 = "AppEvent.initComplete";
		public static const SELECTED_CARD_LIST_CHANGE:String = "AppEvent.selectedCardListChange";
		public static const DESELECT_EVERYTHING:String 		 = "AppEvent.deselectEverything";
		public static const POPULATE:String					 = "AppEvent.cardsAdded";
		public static const ADD_CARDS:String				 = "AppEvent.addCards";
		public static const DELETE_CARDS:String				 = "AppEvent.deleteCards";
		
		
		public function AppEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return new AppEvent(type, _data, bubbles, cancelable);
		}
	}
}
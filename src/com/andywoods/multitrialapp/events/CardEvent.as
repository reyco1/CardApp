package com.andywoods.multitrialapp.events
{
	import flash.events.Event;
	
	public class CardEvent extends Event
	{
		private var _data:*;
		
		public static const CARD_DRAG:String 			= "CardEvent.onCardDrag";
		public static const CARD_DROP:String 			= "CardEvent.onCardDrop";
		public static const CARD_CLICKED:String			= "CardEvent.onCardClick";
		public static const CARD_EDIT_CLICKED:String	= "CardEvent.onCardEditClick";
		public static const CARD_DESELECT_ALL:String	= "CardEvent.onDeselectAll";
		public static const CARD_DOUBLE_CLICKED:String  = "CardEvent.onDoubleClick";
		
		public function CardEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
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
			return new CardEvent(type, _data, bubbles, cancelable);
		}
	}
}


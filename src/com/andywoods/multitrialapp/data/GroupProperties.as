package com.andywoods.multitrialapp.data
{
	public class GroupProperties
	{
		public var gap		 	: Number;
		public var padding	 	: Number;
		public var color 	 	: uint;
		public var selectedColor: uint;
		
		public function GroupProperties(gap:Number = 15, padding:Number = 15, color:uint = 0xFFFF00, selectedColor:uint = 0x00FF00)
		{
			this.gap 			= gap;
			this.padding 		= padding;
			this.color 			= color;
			this.selectedColor  = selectedColor;
		}
	}
}
package com.andywoods.multitrialapp.data
{
	public class CardProperties
	{
		public var width	: Number;
		public var height	: Number;
		public var color	: uint;
		public var border	: uint;
		
		public function CardProperties(width:Number = 100, height:Number = 125, color:uint = 0x4F81BD, border:uint = 0x385D8A)
		{
			this.width 	= width;
			this.height = height;
			this.color 	= color;
			this.border = border;
		}
	}
}
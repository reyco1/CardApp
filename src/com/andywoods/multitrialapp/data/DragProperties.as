package com.andywoods.multitrialapp.data
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	public class DragProperties
	{
		public var target			: DisplayObject = null;
		public var dragRect			: Rectangle 	= null;
		public var snapToCenter		: Boolean 		= false;
		public var onRelease		: Function 		= null;
		public var onReleaseParams	: Array 		= null;
		public var onUpdate			: Function 		= null;
		public var onUpdateParams	: Array 		= null;
		
		public function DragProperties()
		{
		}
	}
}
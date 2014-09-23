package com.andywoods.multitrialapp.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class DisplayUtils 
	{	
		public static function fitIntoRect(displayObject : DisplayObject, rectangle : Rectangle, fillRect : Boolean = true, align : String = "C", applyTransform : Boolean = true) : Matrix
		{
			var g:Sprite = new Sprite();
			g.graphics.drawRect(displayObject.x, displayObject.y, displayObject.width, displayObject.height);			
			
			var matrix : Matrix = new Matrix();
			
			var wD : Number = displayObject.width / displayObject.scaleX;
			var hD : Number = displayObject.height / displayObject.scaleY;
			
			var wR : Number = rectangle.width;
			var hR : Number = rectangle.height;
			
			var sX : Number = wR / wD;
			var sY : Number = hR / hD;
			
			var rD : Number = wD / hD;
			var rR : Number = wR / hR;
			
			var sH : Number = fillRect ? sY : sX;
			var sV : Number = fillRect ? sX : sY;
			
			var s : Number = rD >= rR ? sH : sV;
			var w : Number = wD * s;
			var h : Number = hD * s;
			
			var tX : Number = 0.0;
			var tY : Number = 0.0;
			
			switch(align)
			{
				case Alignment.LEFT :
				case Alignment.TOP_LEFT :
				case Alignment.BOTTOM_LEFT :
					tX = 0.0;
					break;
					
				case Alignment.RIGHT :
				case Alignment.TOP_RIGHT :
				case Alignment.BOTTOM_RIGHT :
					tX = w - wR;
					break;
					
				default : 					
					tX = 0.5 * (w - wR);
			}
			
			switch(align)
			{
				case Alignment.TOP :
				case Alignment.TOP_LEFT :
				case Alignment.TOP_RIGHT :
					tY = 0.0;
					break;
					
				case Alignment.BOTTOM :
				case Alignment.BOTTOM_LEFT :
				case Alignment.BOTTOM_RIGHT :
					tY = h - hR;
					break;
					
				default : 					
					tY = 0.5 * (h - hR);
			}
			
			matrix.scale(s, s);
			matrix.translate(rectangle.left - tX, rectangle.top - tY);
			
			if(applyTransform)
			{
				g.transform.matrix = matrix;
			}
			
			displayObject.x 		= g.x;
			displayObject.y 		= g.y;
			displayObject.width 	= g.width;
			displayObject.height 	= g.height;
			
			g = null;
			
			return matrix;
		}

		public static function createThumb(image : BitmapData, width : int, height : int, align : String = "C", smooth : Boolean = true) : Bitmap
		{
			var source : Bitmap = new Bitmap(image);
			var thumbnail : BitmapData = new BitmapData(width, height, false, 0x0);
			
			thumbnail.draw(image, fitIntoRect(source, thumbnail.rect, true, align, false), null, null, null, smooth);
			source = null;
			
			return new Bitmap(thumbnail, PixelSnapping.AUTO, smooth);
		}
	}
}

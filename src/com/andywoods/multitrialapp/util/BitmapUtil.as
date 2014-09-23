package com.andywoods.multitrialapp.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;

	public class BitmapUtil
	{
		public static function displayObjectToString( displayObject:DisplayObject ):String
		{
			var bmd:BitmapData = new BitmapData(displayObject.width, displayObject.height, true);
			bmd.draw( displayObject );
			
			var bytes:ByteArray = new ByteArray();
			bytes.writeUnsignedInt( bmd.width );
			bytes.writeBytes( bmd.getPixels(bmd.rect) );
			bytes.compress();
			
			return Base64.encodeByteArray( bytes );
		}
		
		public static function stringToBitmap( str:String ):Bitmap
		{
			var data:ByteArray = Base64.decodeToByteArray( str );
			var bmd:BitmapData;
			var bm:Bitmap;
			
			if( data )
			{
				data.uncompress();
				
				var w:int = data.readUnsignedInt();
				var h:int = ((data.length - 4) / 4) / w;
				
				bmd = new BitmapData(w, h, true, 0);				
				bmd.setPixels(bmd.rect, data);
				
				bm = new Bitmap(bmd);
			}
			
			return bm;
		}
	}
}
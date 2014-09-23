package com.andywoods.multitrialapp.util
{
	import flash.utils.ByteArray;

	public class EncodeUtil
	{
		public static function encodeArray( arr:Array ):String
		{
			var byteArray:ByteArray = new ByteArray(); 
			byteArray.writeObject(arr);
			byteArray.position = 0;
			
			var encoded:String = Base64.encodeByteArray( byteArray );
			return encoded;
		}
	}
}
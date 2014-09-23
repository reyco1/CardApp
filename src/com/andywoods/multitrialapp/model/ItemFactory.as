package com.andywoods.multitrialapp.model
{
	import com.andywoods.multitrialapp.data.ItemVO;
	import com.andywoods.multitrialapp.util.Base64;
	import com.andywoods.multitrialapp.util.BitmapUtil;
	
	import flash.utils.ByteArray;

	public class ItemFactory
	{
		public static function parse( data:String ):Vector.<ItemVO>
		{
			var items:Vector.<ItemVO> = new Vector.<ItemVO>();
			
			var ba:ByteArray = Base64.decodeToByteArray( data );
			ba.position = 0;
			
			var arr2:Array = ba.readObject();
			var item:ItemVO;
			
			for each(var obj:Object in arr2)
			{
				item = new ItemVO();
				for (var key:String in obj)
				{
					if(key != "bitmap")
					{
						item[key] = obj[key];
					}
					else if(key == "bitmap")
					{
						item[key] = BitmapUtil.stringToBitmap( obj[key] );
					}
				}
				items.push( item );
			}
			
			return items;
		}
	}
}
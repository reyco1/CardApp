package com.andywoods.multitrialapp.data
{
	import flash.display.Bitmap;

	public class ItemVO
	{
		public var id:String;			// group_id+"_"+trialNum;	//{ text:String } a single card's unique ID formed from group_id + its horizontal position among peers in SAME group.
		public var desc:int;			// description; //{ text:String = ""} text description of card. The user can give a card a text name if they want, else "" given. 
		public var groupID:String;		// group_id;	//{ text:String } each group has a unique id.
		public var verPosition:int;		// rollingVertical; //{ num:int } vertical position (zero is top).
		public var horPosition:int;		// startNum+trialNum; //{ num:int } horizontal position in the given row of cards (nb a row can consist of several groups).
		public var enabled:Boolean;		// enabled; //could disabled trials be a lighter colour.
		public var bitmap:Bitmap;		// snapshot
		
		public function ItemVO()
		{
		}
		
		public function toString():String
		{
			var str:String = "\n";
			
			str += "id: " 			+ id 			+ "\n";
			str += "desc: " 		+ desc 			+ "\n";
			str += "groupID: " 		+ groupID 		+ "\n";
			str += "verPosition: " 	+ verPosition 	+ "\n";
			str += "horPosition: " 	+ horPosition 	+ "\n";
			str += "enabled: " 		+ enabled 		+ "\n";
			
			return str;
		}
	}
}
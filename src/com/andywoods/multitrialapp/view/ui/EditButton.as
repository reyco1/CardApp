package com.andywoods.multitrialapp.view.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class EditButton extends Sprite
	{
		private var label:TextField;
		private var background:Sprite;
		private var dimentions:Object;
		
		public var onClick:Function;
		
		public function EditButton()
		{
			super();
			
			label = new TextField();
			label.autoSize = TextFieldAutoSize.LEFT;
			label.defaultTextFormat = new TextFormat( "Arial", 10, 0x000000 );
			label.text = "EDIT";
			addChild( label );
			
			background = new Sprite();
			background.graphics.beginFill( 0x33cc00, 1 );
			background.graphics.drawRect( 0, 0, label.width + 2, label.height + 2 );
			background.graphics.endFill();
			addChildAt( background, 0 );
			
			label.x = 1;
			label.y = 1;
			
			mouseChildren = false;
			buttonMode = true;
			
			addEventListener( MouseEvent.MOUSE_OVER, handlOver );
			addEventListener( MouseEvent.MOUSE_OUT,  handlOut );
			addEventListener( MouseEvent.CLICK,  	 handlClick );
			
			dimentions = { width:label.width + 2, height:label.height + 2 };
		}
		
		protected function handlClick(event:MouseEvent):void
		{
			if( onClick !=null )
				onClick.call();
		}
		
		protected function handlOut(event:MouseEvent):void
		{
			background.graphics.beginFill( 0x00cc33, 1 );
			background.graphics.drawRect( 0, 0, dimentions.width, dimentions.height );
			background.graphics.endFill();
		}
		
		protected function handlOver(event:MouseEvent):void
		{
			background.graphics.beginFill( 0xFFFFFF, 1 );
			background.graphics.drawRect( 0, 0, dimentions.width, dimentions.height );
			background.graphics.endFill();
		}
	}
}
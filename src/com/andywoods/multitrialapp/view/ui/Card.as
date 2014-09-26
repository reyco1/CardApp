package com.andywoods.multitrialapp.view.ui
{
	import com.andywoods.multitrialapp.data.CardProperties;
	import com.andywoods.multitrialapp.data.ItemVO;
	import com.andywoods.multitrialapp.events.CardEvent;
	import com.andywoods.multitrialapp.util.DisplayUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Card extends Sprite
	{
		private var cardWidth  	  	: Number = 100;
		private var cardHeight 	  	: Number = 125;		
		private var cardColor	 	: uint   = 0x4F81BD;		
		private var cardBorderColor : uint   = 0x385D8A;		
		
		public  var data:ItemVO;
		
		public  var next:Card;
		public  var stackOrder:int;
		public  var group:Group;
		public  var previousGoup:Group;
		
		private var image:Bitmap;
		
		private var _selected:Boolean = false;
		private var editButton:EditButton;
		private var background:Sprite;
		
		public function Card( itemVO:ItemVO = null, properties:CardProperties = null )
		{
			if( properties )
			{
				cardWidth 		= properties.width;
				cardHeight 		= properties.height;
				cardColor 		= properties.color;
				cardBorderColor = properties.border;
			}
			
			build();
			
			if(itemVO)
			{
				setItem( itemVO );
			}
			
			buttonMode    		= true;
		}
		
		protected function handleMouseEvent(event:MouseEvent):void
		{
			switch( event.type )
			{
				case MouseEvent.CLICK :
					
					dispatchEvent( new CardEvent(CardEvent.CARD_CLICKED) );
					
					break;
				
				case MouseEvent.MOUSE_UP :
					
					dispatchEvent( new CardEvent(CardEvent.CARD_DROP) );
					
					break;
				
				case MouseEvent.DOUBLE_CLICK :
					
					dispatchEvent( new CardEvent(CardEvent.CARD_DOUBLE_CLICKED) );
					
					break;					
			}
		}
		
		private function build():void
		{
			background = new Sprite();			
			background.graphics.clear();
			background.graphics.beginFill( cardColor, 1 );
			background.graphics.lineStyle( 2, cardBorderColor, 1, true );
			background.graphics.drawRoundRect(0, 0, cardWidth, cardHeight, 25, 25);
			background.graphics.endFill();
			background.doubleClickEnabled 	= true;
			addChild( background );
			
			background.addEventListener( MouseEvent.CLICK, 			handleMouseEvent );
			background.addEventListener( MouseEvent.MOUSE_UP, 	 	handleMouseEvent );
			background.addEventListener( MouseEvent.DOUBLE_CLICK, 	handleMouseEvent );
		}
		
		public function setItem( itemVO:ItemVO ):void
		{
			data = itemVO;
			
			if( data.bitmap )
			{
				image = data.bitmap;
				image.smoothing = true;
				addChild( image );
				
				DisplayUtils.fitIntoRect( image, new Rectangle(10, 10, cardWidth - 20, cardHeight - 20), false );
			}
			
			editButton = new EditButton();
			editButton.x = cardWidth - editButton.width - 8;
			editButton.y = cardHeight - editButton.height - 8;
			addChild( editButton );
			
			editButton.onClick = function():void
			{
				dispatchEvent( new CardEvent(CardEvent.CARD_EDIT_CLICKED) );
			};
		}		

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if(value)
			{
				background.graphics.clear();
				background.graphics.beginFill( cardBorderColor, 1 );
				background.graphics.lineStyle( 2, cardColor, 1, true );
				background.graphics.drawRoundRect(0, 0, cardWidth, cardHeight, 25, 25);
				background.graphics.endFill();
			}
			else
			{
				background.graphics.clear();
				background.graphics.beginFill( cardColor, 1 );
				background.graphics.lineStyle( 2, cardBorderColor, 1, true );
				background.graphics.drawRoundRect(0, 0, cardWidth, cardHeight, 25, 25);
				background.graphics.endFill();
			}
		}
		
		public function get verPosition():int
		{
			return data.verPosition;
		}
		
		public function get horPosition():int
		{
			return data.horPosition;
		}
		
		public function clear():void
		{
			if( contains( image ) )
			{
				removeChild( image );
				image = null;
			}
			
			next = null;
			
			removeEventListener( MouseEvent.MOUSE_DOWN, 	handleMouseEvent );
			removeEventListener( MouseEvent.MOUSE_UP, 	 	handleMouseEvent );
			removeEventListener( MouseEvent.DOUBLE_CLICK, 	handleMouseEvent );
		}
	}
}
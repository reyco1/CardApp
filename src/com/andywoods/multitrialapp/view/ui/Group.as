package com.andywoods.multitrialapp.view.ui
{
	import com.greensock.TweenMax;
	import com.andywoods.multitrialapp.data.CardProperties;
	import com.andywoods.multitrialapp.data.GroupProperties;
	import com.andywoods.multitrialapp.events.GroupEvent;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Group extends Sprite
	{
		private var background:Shape;
		private var count:uint;
		private var groupWidth:uint;
		private var mainDelta:int;
		private var cardProperties:CardProperties;
		private var groupProperties:GroupProperties;
		private var editButton:EditButton;
		private var container:Sprite;
		
		private var _selected:Boolean;
		
		public var previousRow:Row;
		public var row:Row;		
		
		
		public function Group( cardProperties:CardProperties = null, groupProperties:GroupProperties = null )
		{
			this.cardProperties  = cardProperties;
			this.groupProperties = groupProperties;
			
			build();
			
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheelEvent);
		}
		
		private function build():void
		{
			container = new Sprite();
			addChild( container );
			
			background = new Shape();
			background.graphics.beginFill( groupProperties.color, 1 );
			background.graphics.drawRect(0, 0, 120, cardProperties.height + (groupProperties.padding * 2));
			background.graphics.endFill();
			
			container.addChild( background );
			
			editButton = new EditButton();
			editButton.x = background.width - editButton.width;
			editButton.y = background.height - editButton.height;
			addChild( editButton );
			
			editButton.onClick = function():void
			{
				dispatchEvent( new GroupEvent(GroupEvent.GROUP_EDIT_CLICKED) );
			};
		}
		
		public function popuplate( group:Array ):void
		{
			var card:Card;
			var prevCard:Card;
			
			for (var a:int = 0; a < group.length; a++) 
			{
				card = new Card( group[a], cardProperties );
				card.group = this;
				card.x = groupProperties.padding + (groupProperties.gap * a);
				card.y = groupProperties.padding;
				addCard( card );
				
				card.stackOrder = container.getChildIndex( card );
				
				if(prevCard)
					prevCard.next = card;
				
				prevCard = card;
			}
			
			card = null;
			prevCard = null;
			
			updateWidth();
		}
		
		public function addCard(card:Card):void
		{
			container.addChild( card );
			spread(0);
			
			if(card.group)
			{
				card.group.checkIfEmpty();
				card.group = this;
			}
		}
		
		public function deleteCard(card:Card):void
		{
			card.clear();
			container.removeChild( card );
			card = null;
			closeSpread();
			
			checkIfEmpty();
		}
		
		public function checkIfEmpty():void
		{
			if(container.numChildren == 1)
				dispatchEvent( new Event("empty") );
			else
				closeSpread();
		}
		
		public function spread(delta:int):void
		{
			var card:Card;
			var prevCard:Card;
			var index:int;
			
			mainDelta += ( (delta/3) * 10 );
			mainDelta = mainDelta < 0 ? 0 : mainDelta;
			mainDelta = mainDelta > cardProperties.width ? cardProperties.width : mainDelta;
			
			for (var a:int = 1; a < container.numChildren; a++) 
			{
				index 	 = a - 1;
				card 	 = container.getChildAt(a) as Card;
				
				if(container.getChildAt(a - 1) is Card)
				{
					prevCard = container.getChildAt(a - 1) as Card;				
					prevCard.next = card;
				}				
				
				TweenMax.to( card, 0.2, {x:(groupProperties.padding + (groupProperties.gap * index)) + (mainDelta * index)} );
			}
			card = null;
			
			updateWidth();
		}
		
		public function closeSpread():void
		{
			spread( 0 );
		}
		
		private function updateWidth( tweenTime:Number = 0.2 ):void
		{
			count 	   = container.numChildren - 2;
			groupWidth = ((groupProperties.gap + mainDelta) * count) + cardProperties.width;
			
			TweenMax.to( background, tweenTime, {width:groupWidth + (groupProperties.padding * 2), onUpdate:function():void
			{
				editButton.x = background.width - editButton.width;
				editButton.y = background.height - editButton.height;
				dispatchEvent( new Event(Event.RESIZE) );
			}} );
			
			updateBackgroundVisibility();
		}
		
		protected function onMouseWheelEvent(event:MouseEvent):void
		{
			spread(event.delta);
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			
			if( _selected )
			{
				background.graphics.clear();
				background.graphics.beginFill( groupProperties.selectedColor, 1 );
				background.graphics.drawRect(0, 0, 120, cardProperties.height + (groupProperties.padding * 2));
				background.graphics.endFill();
			}
			else
			{
				background.graphics.clear();
				background.graphics.beginFill( groupProperties.color, 1 );
				background.graphics.drawRect(0, 0, 120, cardProperties.height + (groupProperties.padding * 2));
				background.graphics.endFill();
			}
			
			for (var a:int = 0; a < container.numChildren; a++) 
			{
				if( container.getChildAt(a) is Card )
				{
					Card( container.getChildAt(a) ).selected = value;	
				}				
			}			
			
			updateWidth();
		}
		
		public function updateBackgroundVisibility():void
		{
			background.alpha = !_selected ? (container.numChildren >= 3 ? 0.5 : 0) : 0.5;
			editButton.visible = background.alpha > 0;
		}
		
		public function getIdForAllCardsInGroup():Array
		{
			var ids:Array = [];
			for (var a:int = 0; a < container.numChildren; a++)
			{
				if(container.getChildAt(a) is Card)
				{
					ids.push( Card(container.getChildAt(a)).data.id );
				}
			}
			return ids;
		}
	}
}
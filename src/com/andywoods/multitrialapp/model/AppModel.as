package com.andywoods.multitrialapp.model
{
	import com.andywoods.multitrialapp.data.CardProperties;
	import com.andywoods.multitrialapp.data.GroupProperties;
	import com.andywoods.multitrialapp.data.ItemVO;
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.view.ui.Card;
	import com.andywoods.multitrialapp.view.ui.Group;	
	import flash.events.IEventDispatcher;
	
	
	public class AppModel extends BaseActor
	{
		[Inject] public var dispatcher:IEventDispatcher;

		
		public var cardProperties 	: CardProperties 	= new CardProperties();	
		public var groupProperties	: GroupProperties 	= new GroupProperties();	
		
		public var items			: Vector.<ItemVO> 	= new Vector.<ItemVO>();
		public var selecteCards		: Vector.<Card>		= new Vector.<Card>();
		public var selecteGroups	: Vector.<Group>	= new Vector.<Group>();
		
		public function updateSelectedCardsList(card:Card, shiftKey:Boolean):void
		{
			if( !shiftKey )
			{
				for (var a:int = 0; a < selecteCards.length; a++) 
				{
					if(selecteCards[a] != card)
						selecteCards[a].selected = false;
					
					if( selecteCards.indexOf( selecteCards[a] ) > -1 )
						selecteCards.splice( selecteCards.indexOf( selecteCards[a] ), 1 );
				}				
			}
			
			if( card.selected )
			{
				if( selecteCards.indexOf( card ) == -1 )
					selecteCards.push( card );
			}
			else
			{
				if( selecteCards.indexOf( card ) > -1 )
					selecteCards.splice( selecteCards.indexOf( card ), 1 );
			}
			
			dispatcher.dispatchEvent( new AppEvent(AppEvent.SELECTED_CARD_LIST_CHANGE) );
		}
		
		public function updateSelectedGroupsList(group:Group, shiftKey:Boolean):void
		{
			for each( var card:Card in group )
			{
				updateSelectedCardsList( card, shiftKey );
			}
			
			if( group.selected )
			{
				if( selecteGroups.indexOf( group ) == -1 )
					selecteGroups.push( group );
			}
			else
			{
				if( selecteGroups.indexOf( group ) > -1 )
					selecteGroups.splice( selecteGroups.indexOf( group ), 1 );
			}
			
			dispatcher.dispatchEvent( new AppEvent(AppEvent.SELECTED_CARD_LIST_CHANGE) );
		}
		
		public function deselectAllSelectedCards():void
		{
			
			for (var a:int = 0; a < selecteCards.length; a++) 
			{
				selecteCards[a].selected = false;
			}
			
			selecteCards = new Vector.<Card>();
			
			dispatcher.dispatchEvent( new AppEvent(AppEvent.SELECTED_CARD_LIST_CHANGE) );
		}
		
		public function deleteSelectedCards():void
		{

			var deletedCardIds:Array = [];
			while( selecteCards.length > 0 )
			{
				deletedCardIds.push(selecteCards[0].data.id);
				selecteCards[0].group.deleteCard( selecteCards[0] );
				selecteCards.splice(0, 1);
			}
			
			var deletedGroupsIds:Array = [];
			
			
			while( selecteGroups.length > 0 )
			{
				deletedGroupsIds.push(selecteGroups[0].getGroupId());
				selecteGroups[0].deleteGroup();
				selecteGroups.splice(0, 1);
			}
			deselectAllSelectedGroups();
			
			
			if(deletedCardIds.length>0 || deletedGroupsIds.length>0){
				dispatcher.dispatchEvent( new AppEvent(AppEvent.DELETE_CARDS,{cards:deletedCardIds,groups:deletedGroupsIds}) );		
			}
		}
		
		public function deselectAllSelectedGroups():void
		{
			while( selecteGroups.length > 0 )
			{
				selecteGroups[0].selected = false;
				selecteGroups.splice(0, 1);
			}
		}
		
		public function mergeSlectedCardsToSelectedGroup():void
		{
			var selectedGroup:Group = selecteGroups[0];
			
			for (var a:int = 0; a < selecteCards.length; a++) 
			{
				if( selecteCards[a].group != selectedGroup )
				{
					selectedGroup.addCard( selecteCards[a] );
				}
			}
			
			deselectAllSelectedCards();	
			deselectAllSelectedGroups();
		}
		
		public function addSlectedCardsToSelectedGroupsRow():void
		{
			var selectedGroup:Group = selecteGroups[0];
			
			for (var a:int = 0; a < selecteCards.length; a++) 
			{
				if( selecteCards[a].group.row != selectedGroup.row )
				{
					var tempGroup:Group = new Group( cardProperties, groupProperties );
					tempGroup.addCard( selecteCards[a] );
					selectedGroup.row.addGroup( tempGroup );
				}
			}
			
			deselectAllSelectedCards();	
			deselectAllSelectedGroups();
		}
		
		public function populate(data:String):void
		{
			var items:Vector.<ItemVO> = ItemFactory.parse( data );			
			dispatcher.dispatchEvent( new AppEvent(AppEvent.POPULATE,items) );			
		}
		
		public function addCards(data:String):void
		{
			var items:Vector.<ItemVO> = ItemFactory.parse( data );			
			dispatcher.dispatchEvent( new AppEvent(AppEvent.ADD_CARDS,items) );		
		}
		
		public function getSelected():Object
		{
			var selected:String;
			
			var cardsSelected:Array = [];
			for(var i:int=0;i<selecteCards.length;i++){
				cardsSelected.push(selecteCards[i].data.id);
			}
			
			var groupsSelected:Array = [];
			for(i=0;i<selecteGroups.length;i++){
				groupsSelected.push(selecteGroups[i].getGroupId());
			}
			
			return {cardsSelected:cardsSelected, groupsSelected:groupsSelected};
		}
		
		
	}
}
package com.andywoods.multitrialapp.view
{
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.events.RowEvent;
	import com.andywoods.multitrialapp.manager.ExternalInterfaceManager;
	import com.andywoods.multitrialapp.model.AppModel;
	//import com.andywoods.multitrialapp.util.EncodeUtil;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CardContainerMediator extends Mediator
	{
		[Inject] public var view:CardContainer;
		[Inject] public var model:AppModel;
		[Inject] public var externalInterfaceManager:ExternalInterfaceManager;
		
		override public function initialize():void
		{
			// context event listeners
			addContextListener( AppEvent.INITIALIZE_COMPLETE, handleInitializeComplete, AppEvent );
			addContextListener( AppEvent.CARDS_ADDED, handleCardsAdded, AppEvent );
			addContextListener( AppEvent.SELECTED_CARD_LIST_CHANGE, handleCardlistChanged, AppEvent );
			
			// view event listeners
			addViewListener( AppEvent.DESELECT_EVERYTHING, handleBackgroundClicked, AppEvent );
			addViewListener( RowEvent.ROW_POSITION_UPDATE, handleRowPositionChange, RowEvent );
		}
		
		private function handleCardlistChanged( event:AppEvent ):void
		{
			view.handleRowDrop();
		}
		
		private function handleRowPositionChange( event:RowEvent ):void
		{
			//externalInterfaceManager.orderChanged( EncodeUtil.encodeArray(event.data) );
			externalInterfaceManager.orderChanged( event.data );
		}
		
		private function handleBackgroundClicked( event:AppEvent ):void
		{
			model.deselectAllSelectedCards();
			model.deselectAllSelectedGroups();
		}
		
		private function handleInitializeComplete( event:AppEvent ):void
		{
			view.build( model.items, model.cardProperties, model.groupProperties );
		}
		
		private function handleCardsAdded( event:AppEvent ):void
		{
			view.destroy();
			view.build( event.data, model.cardProperties, model.groupProperties );
		}
	}
}
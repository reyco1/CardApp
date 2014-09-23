package com.andywoods.multitrialapp.view
{
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.model.AppModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CardContainerMediator extends Mediator
	{
		[Inject] public var view:CardContainer;
		[Inject] public var model:AppModel;
		
		override public function initialize():void
		{
			// context event listeners
			addContextListener( AppEvent.INITIALIZE_COMPLETE, handleInitializeComplete, AppEvent );
			addContextListener( AppEvent.CARDS_ADDED, handleCardsAdded, AppEvent );
			
			// view event listeners
			addViewListener( AppEvent.DESELECT_EVERYTHING, handleBackgroundClicked, AppEvent );
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
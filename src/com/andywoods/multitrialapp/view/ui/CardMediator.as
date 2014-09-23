package com.andywoods.multitrialapp.view.ui
{
	import com.andywoods.multitrialapp.events.CardEvent;
	import com.andywoods.multitrialapp.manager.ExternalInterfaceManager;
	import com.andywoods.multitrialapp.manager.KeyManager;
	import com.andywoods.multitrialapp.model.AppModel;
	
	import flash.events.IEventDispatcher;
	import flash.ui.Keyboard;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class CardMediator extends Mediator
	{
		[Inject] public var model:AppModel;
		[Inject] public var card:Card;
		[Inject] public var keyManager:KeyManager;
		[Inject] public var externalInterfaceManager:ExternalInterfaceManager;
		[Inject] public var dispatcher:IEventDispatcher;
		[Inject] public var context:ContextView;
		
		override public function initialize():void
		{
			addViewListener( CardEvent.CARD_CLICKED, handleCardClicked, CardEvent );
			addViewListener( CardEvent.CARD_EDIT_CLICKED, handleEditClicked, CardEvent );
			addViewListener( CardEvent.CARD_DOUBLE_CLICKED, handleDoubleClicked, CardEvent );
		}
		
		private function handleDoubleClicked( event:CardEvent ):void
		{
			card.selected = true;
			externalInterfaceManager.editCard( card.data.id );
		}
		
		private function handleEditClicked( event:CardEvent ):void
		{
			card.selected = true;
			externalInterfaceManager.editCard( card.data.id );
		}
		
		private function handleCardClicked( event:CardEvent ):void
		{		
			if( keyManager.isKeyDown( Keyboard.CONTROL ) )
			{
				card.group.selected = !card.group.selected;
				model.updateSelectedGroupsList( card.group, keyManager.isKeyDown( Keyboard.SHIFT ) );
				return;
			}
			
			card.selected = !card.selected;
			model.updateSelectedCardsList( card, keyManager.isKeyDown( Keyboard.SHIFT ) );
		}
	}
}
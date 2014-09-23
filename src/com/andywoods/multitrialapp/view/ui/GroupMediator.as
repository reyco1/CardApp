package com.andywoods.multitrialapp.view.ui
{
	import com.andywoods.multitrialapp.events.GroupEvent;
	import com.andywoods.multitrialapp.manager.ExternalInterfaceManager;
	import com.andywoods.multitrialapp.manager.KeyManager;
	import com.andywoods.multitrialapp.model.AppModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class GroupMediator extends Mediator
	{
		[Inject] public var model:AppModel;
		[Inject] public var group:Group;
		[Inject] public var keyManager:KeyManager;
		[Inject] public var externalInterfaceManager:ExternalInterfaceManager;
		
		override public function initialize():void
		{
			addContextListener( GroupEvent.DESELECT_ALL_SELECTED_GROUPS, handleDeselectGroup, GroupEvent );
			
			addViewListener( GroupEvent.GROUP_EDIT_CLICKED, handleEditClicked, GroupEvent );
		}
		
		private function handleEditClicked(event:GroupEvent):void
		{
			externalInterfaceManager.editGroup( group.getIdForAllCardsInGroup().join("|") );
		}
		
		private function handleDeselectGroup(event:GroupEvent):void
		{
			group.selected = false;
		}
	}
}
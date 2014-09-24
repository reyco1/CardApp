package com.andywoods.multitrialapp.manager
{
	import com.andywoods.multitrialapp.events.ExternalRequestEvent;
	import com.andywoods.multitrialapp.model.AppModel;
	
	import flash.events.IEventDispatcher;
	import flash.external.ExternalInterface;

	public class ExternalInterfaceManager
	{
		[Inject] public var dispatcher:IEventDispatcher;
		[Inject] public var appModel:AppModel;
		
		public var allowed:Boolean = false;
		
		public function init():void
		{
			allowed = ExternalInterface.available;
			if(allowed)
			{
				ExternalInterface.addCallback("merge"	, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.MERGE)) });
				ExternalInterface.addCallback("delete"	, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.DELETE)) });
				ExternalInterface.addCallback("add"		, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.ADD)) });
				ExternalInterface.addCallback("addCards", function(data:String):void{ appModel.addCards(data) });
			}
			log( this, "Initialized." );
		}
		
		public function editCard( cardId:String ):void
		{
			call( "editCard", cardId );
		}
		
		public function editGroup( groupIds:String ):void
		{
			call( "editGroup", groupIds );
		}
		
		public function orderChanged( order:Object ):void
		{
			call( "orderChanged", order );
		}
		
		public function call(method:String, ...arguments):void
		{
			log( this, method, arguments );
			
			arguments.unshift( method );
			if(allowed)
				ExternalInterface.call.apply( null, arguments );
			
			arguments.unshift( ExternalInterfaceManager );
		}
	}
}
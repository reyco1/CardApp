package com.andywoods.multitrialapp.commands
{
	import com.andywoods.multitrialapp.data.TestData;
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.manager.DragManager;
	import com.andywoods.multitrialapp.manager.ExternalInterfaceManager;
	import com.andywoods.multitrialapp.manager.KeyManager;
	import com.andywoods.multitrialapp.model.AppModel;
	import com.andywoods.multitrialapp.model.ItemFactory;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class InitializeCommand extends Command
	{
		[Inject] public var model:AppModel;
		[Inject] public var context:ContextView;
		[Inject] public var dispatcher:IEventDispatcher;
		[Inject] public var dragManager:DragManager;
		[Inject] public var keyManager:KeyManager;
		[Inject] public var externalInterfaceManager:ExternalInterfaceManager;
		
		override public function execute():void
		{
			log( this, "Initializing..." );
			
			var flashVar:String = context.view.loaderInfo.parameters.cardData;
			//var testData:String = TestData.data2;
			var data:String;
			
			if(flashVar && flashVar.length > 5)
				data = flashVar;
			//else
				//data = testData;
			
			if(data)	model.items = ItemFactory.parse( data );
			
			
			dragManager.init();
			keyManager.init( context.view.stage );
			externalInterfaceManager.init();
			dispatcher.dispatchEvent( new AppEvent(AppEvent.INITIALIZE_COMPLETE) );
		}
	}
}
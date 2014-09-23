package com.andywoods.multitrialapp 
{
	import com.andywoods.multitrialapp.commands.AddCommand;
	import com.andywoods.multitrialapp.commands.DeleteCommand;
	import com.andywoods.multitrialapp.commands.InitializeCommand;
	import com.andywoods.multitrialapp.commands.MergeCommand;
	import com.andywoods.multitrialapp.events.AppEvent;
	import com.andywoods.multitrialapp.events.ExternalRequestEvent;
	import com.andywoods.multitrialapp.manager.DragManager;
	import com.andywoods.multitrialapp.manager.ExternalInterfaceManager;
	import com.andywoods.multitrialapp.manager.KeyManager;
	import com.andywoods.multitrialapp.model.AppModel;
	import com.andywoods.multitrialapp.view.CardContainer;
	import com.andywoods.multitrialapp.view.CardContainerMediator;
	import com.andywoods.multitrialapp.view.ui.Card;
	import com.andywoods.multitrialapp.view.ui.CardMediator;
	import com.andywoods.multitrialapp.view.ui.Group;
	import com.andywoods.multitrialapp.view.ui.GroupMediator;
	import com.andywoods.multitrialapp.view.ui.Row;
	import com.andywoods.multitrialapp.view.ui.RowMediator;
	
	import flash.events.IEventDispatcher;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;

	public class MultiTrialAppConfig implements IConfig
	{
		[Inject] public var injector	: IInjector;		
		[Inject] public var mediatorMap	: IMediatorMap;		
		[Inject] public var commandMap	: IEventCommandMap;
		[Inject] public var context 	: IContext;
		[Inject] public var dispatcher 	: IEventDispatcher;
		
		public function configure():void
		{
			// models
			injector.map(AppModel).asSingleton();
			
			// managers
			injector.map(DragManager).asSingleton();
			injector.map(KeyManager).asSingleton();
			injector.map(ExternalInterfaceManager).asSingleton();
			
			// commands
			commandMap.map(AppEvent.INITIALIZE, AppEvent).toCommand(InitializeCommand);
			commandMap.map(ExternalRequestEvent.DELETE, ExternalRequestEvent).toCommand(DeleteCommand);
			commandMap.map(ExternalRequestEvent.ADD, ExternalRequestEvent).toCommand(AddCommand);
			commandMap.map(ExternalRequestEvent.MERGE, ExternalRequestEvent).toCommand(MergeCommand);
			
			// services
			// injector.map(IAuthenticationService).toSingleton(AuthenticateService);
			
			// mediators
			mediatorMap.map(CardContainer).toMediator(CardContainerMediator);
			mediatorMap.map(Card).toMediator(CardMediator);
			mediatorMap.map(Group).toMediator(GroupMediator);
			mediatorMap.map(Row).toMediator(RowMediator);
			
			// startup
			context.afterInitializing( init );
		}
		
		private function init():void
		{
			dispatcher.dispatchEvent(new AppEvent( AppEvent.INITIALIZE ));
		}
	}
}
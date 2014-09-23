package com.andywoods.multitrialapp
{
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextViewExtension;
	import robotlegs.bender.extensions.contextView.ContextViewListenerConfig;
	import robotlegs.bender.extensions.contextView.StageSyncExtension;
	import robotlegs.bender.extensions.directCommandMap.DirectCommandMapExtension;
	import robotlegs.bender.extensions.eventCommandMap.EventCommandMapExtension;
	import robotlegs.bender.extensions.eventDispatcher.EventDispatcherExtension;
	import robotlegs.bender.extensions.localEventMap.LocalEventMapExtension;
	import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
	import robotlegs.bender.extensions.viewManager.StageCrawlerExtension;
	import robotlegs.bender.extensions.viewManager.StageObserverExtension;
	import robotlegs.bender.extensions.viewManager.ViewManagerExtension;
	import robotlegs.bender.extensions.vigilance.VigilanceExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;
	
	public class MinimalBundle extends MVCSBundle implements IBundle
	{
		public function MinimalBundle()
		{
			super();
		}
		
		override public function extend(context:IContext):void
		{
			context.install(
				
				VigilanceExtension,
				ContextViewExtension,
				EventDispatcherExtension,
				DirectCommandMapExtension,
				EventCommandMapExtension,
				LocalEventMapExtension,
				ViewManagerExtension,
				StageObserverExtension,
				MediatorMapExtension,
				StageCrawlerExtension,
				StageSyncExtension				
			);
			
			context.configure( ContextViewListenerConfig );
		}
	}
}
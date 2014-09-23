package com.andywoods.multitrialapp.view.ui
{
	import com.andywoods.multitrialapp.model.AppModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class RowMediator extends Mediator
	{
		[Inject] public var view:Row;
		[Inject] public var model:AppModel;
		
		override public function initialize():void
		{
		}
	}
}
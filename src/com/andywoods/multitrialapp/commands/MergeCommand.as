package com.andywoods.multitrialapp.commands
{
	import com.andywoods.multitrialapp.model.AppModel;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class MergeCommand extends Command
	{
		[Inject] public var model:AppModel;
		
		override public function execute():void
		{
			model.mergeSlectedCardsToSelectedGroup();
		}
	}
}
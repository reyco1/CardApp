package
{
	import com.andywoods.multitrialapp.MinimalBundle;
	import com.andywoods.multitrialapp.MultiTrialAppConfig;
	import com.andywoods.multitrialapp.view.AbstractView;
	import com.andywoods.multitrialapp.view.CardContainer;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	
	[SWF(width="800", height="800", frameRate="60")]
	public class MultiTrialApp extends AbstractView
	{
		public function MultiTrialApp()
		{
			stage.align 	= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override protected function onAdded():void
		{
			createChildren();
			new Context().install(MinimalBundle).configure(MultiTrialAppConfig, new ContextView(this));
		}
		
		private function createChildren():void
		{
			var cardContianer:CardContainer = new CardContainer(stage.stageWidth, stage.stageHeight);
			addChild( cardContianer );
		}
	}
}
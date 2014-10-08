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
				if(isReady())	linkUpExternalInterfaces();
				else{
					Pingback.delay(1000,isReady,linkUpExternalInterfaces);
				}
			}
	
			log( this, "Initialized.","Allowed:",allowed );
		}
		
		private function isReady():Boolean
		{
			/*
			calling below JS
			finishedLoading is a bool that is Trued upon SWF load 
			api.isReady = function(){
				return finishedLoading;
			}*/
			
			return ExternalInterface.call("cardsHelper.isReady");
		}
		
		private function linkUpExternalInterfaces():void
		{
			isReady(); //ping back to let JS know it can send stuff
			ExternalInterface.addCallback("merge"	, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.MERGE)) });
			ExternalInterface.addCallback("delete"	, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.DELETE)) });
			ExternalInterface.addCallback("add"		, function():void{ dispatcher.dispatchEvent(new ExternalRequestEvent(ExternalRequestEvent.ADD)) });
			ExternalInterface.addCallback("addCards", function(data:String):void{appModel.addCards(data) });
			ExternalInterface.addCallback("getSelected", function():Object{
				return appModel.getSelected();
				//appModel.addCards(data) 
			});
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
import flash.events.TimerEvent;
import flash.utils.Timer;

class Pingback{
	
	
	
	public static function delay(delay:int, check:Function, onGood:Function):void
	{
		var timeOut:int=20;
		var t:Timer = new Timer(delay);
		var found:Boolean;
		t.addEventListener(TimerEvent.TIMER,function(e:TimerEvent):void{
			found=check();
			if(found || timeOut<=0){
				t.removeEventListener(e.type, arguments.callee);
				if(found)onGood();
			}
			timeOut--;
		});
		t.start();
	}

}
package com.andywoods.multitrialapp.util
{
	public class Delegate
	{
		public static function create( handler:Function, ...args ):Function
		{
			return function( ...innerArgs ):*
			{
				return handler.apply( this, innerArgs.concat( args ) );
			}
		}
		
		public static function execute(method:Function, arguments:Array = null, scope:* = null):void
		{
			if(arguments != null)
			{
				method.apply(scope, arguments);
			}
			else
			{
				method.call(scope);
			}			
		}
		
	}
}
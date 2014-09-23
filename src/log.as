package
{
	import flash.utils.getQualifiedClassName;

	public function log(classObj:Object, ...rest):void
	{
		var className:String = "["+getQualifiedClassName(classObj).split("::")[getQualifiedClassName(classObj).split("::").length-1]+"]";
		rest.unshift( className );
		trace.apply(classObj, rest);
		
		rest.shift();
		var str:String = rest.join(" ");
	}
}
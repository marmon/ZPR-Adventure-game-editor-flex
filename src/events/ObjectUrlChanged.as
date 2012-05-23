package events
{
	import flash.events.Event;

	public class ObjectUrlChanged extends Event
	{
		public var url:String;
		public function ObjectUrlChanged(type:String, url:String)
		{
			super(type);
			this.url = url;
		}
	}
}
package events
{
	import flash.events.Event;
	
	public class RoomColorChanged extends Event
	{
		public var color:uint;
		
		public function RoomColorChanged(type:String, color:uint)
		{
			super(type);
			this.color = color;
		}
	}
}
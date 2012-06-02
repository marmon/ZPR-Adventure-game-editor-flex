package events
{
	import flash.events.Event;
	
	public class RoomColorChanged extends Event
	{
		public var color:uint;
        public var roomId:int;
		
		public function RoomColorChanged(type:String, color:uint, roomId:int)
		{
			super(type);
			this.color = color;
            this.roomId = roomId;
		}
	}
}
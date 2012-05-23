package events
{
	import flash.events.Event;

	public class OperationTypeChanged extends Event
	{
		public var operationType:int;
		public function OperationTypeChanged(type:String, operationType:int)
		{
			super(type);
			this.operationType = operationType;
		}
	}
}
package logic.commands
{
	import components.RoomCreator;
	
	import config.Config;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class AddRoom implements Command
	{
		public var name:String;
		public var color:uint;
		private var remoteObj:RemoteObject;
		private var id:int;
		public var roomCreator:RoomCreator;
		public var levelId:int;
		public function AddRoom()
		{
			remoteObj = new RemoteObject();
			remoteObj.endpoint = Config.getInstance().getEndpoint();
			remoteObj.destination = Config.getInstance().getDestination();
			remoteObj.addRoom.addEventListener("result", onAddRoom);
			remoteObj.delRoom.addEventListener("result", onDelRoom);
		}
		public function execute():void
		{
			remoteObj.addRoom(levelId, name, color);
		}
		public function rollback():void
		{
			remoteObj.delRoom(id);
		}
		private function onAddRoom(resEvent:ResultEvent):void
		{
			id = (resEvent.result as int);
			roomCreator.refreshRoomList();
		}
		private function onDelRoom(resEvent:ResultEvent)
		{
			roomCreator.refreshRoomList();
		}
	}
}
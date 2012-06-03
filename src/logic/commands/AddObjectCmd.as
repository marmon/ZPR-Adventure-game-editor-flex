package logic.commands
{
	import config.Config;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import view.BigBlockView;
	import view.BoardView;

	public class AddObjectCmd implements Command
	{
		private var remoteObj:RemoteObject;
		private var x:int;
		private var y:int;
		private var bigBlockView:BigBlockView;
		private var boardView:BoardView;
		private var id:int;
		public function AddObjectCmd(x:int, y:int, bigBlockView:BigBlockView, boardView:BoardView)
		{
			this.x = x;
			this.y = y;
			this.bigBlockView = bigBlockView;
			this.boardView = boardView;
			
			remoteObj = new RemoteObject();
			remoteObj.endpoint = Config.getInstance().getEndpoint();
			remoteObj.destination = Config.getInstance().getDestination();
			remoteObj.addItem.addEventListener("result", onAddObject); 
			remoteObj.delItem.addEventListener("result", onDelObject);
		}
		private function onAddObject(re:ResultEvent)
		{
			id = (re.result as int);
		}
		private function onDelObject(re:ResultEvent)
		{
			
		}
		public function execute():void
		{
			remoteObj.addItem(x, y, "item");
			bigBlockView.drawObject(x, y, true);
			var cmd:ChangeRoomMode = new ChangeRoomMode(true, boardView);
			cmd.removeBlock();
			cmd.doChangeMode(true);
		}
		public function rollback():void
		{
			remoteObj.delItem(id);
			bigBlockView.drawObject(x, y, false);
			var cmd:ChangeRoomMode = new ChangeRoomMode(true, boardView);
			cmd.removeBlock();
			cmd.doChangeMode(true);
		}
	}
}
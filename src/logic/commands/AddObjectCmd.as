package logic.commands
{
	import config.Config;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import view.BigBlockView;

	public class AddObjectCmd implements Command
	{
		private var remoteObj:RemoteObject;
		private var x:int;
		private var y:int;
		private var bigBlockView:BigBlockView;
		private var id:int;
		public function AddObjectCmd(x:int, y:int, bigBlockView:BigBlockView)
		{
			this.x = x;
			this.y = y;
			this.bigBlockView = bigBlockView;
			
			remoteObj = new RemoteObject();
			remoteObj.endpoint = Config.getInstance().getEndpoint();
			remoteObj.destination = Config.getInstance().getDestination();
			remoteObj.addObject.addEventListener("result", onAddObject);                                                                  
		}
		private function onAddObject(re:ResultEvent)
		{
			id = (re.result as int);
		}
		public function execute():void
		{
			remoteObj.addItem(x, y, "item");
			bigBlockView.drawObject(x, y, true);
		}
		public function rollback():void
		{
			
		}
	}
}
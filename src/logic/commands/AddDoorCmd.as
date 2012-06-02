package logic.commands
{
    import mx.rpc.remoting.mxml.RemoteObject;
    import config.Config;
    import mx.rpc.events.ResultEvent;

    public class AddDoorCmd implements Command
    {
        private var room1X:uint;
        private var room1Y:uint;
        private var room2X:uint;
        private var room2Y:uint;
        private var remoteObj:RemoteObject;
        
        public function AddDoorCmd(room1X:uint, room1Y:uint, room2X:uint, room2Y:uint)
        {
            this.room1X = room1X;
            this.room1Y = room1Y;
            this.room2X = room2X;
            this.room2Y = room2Y;
            
            // some remote object
            remoteObj = new RemoteObject();
            remoteObj.endpoint = Config.getInstance().getEndpoint();
            remoteObj.destination = Config.getInstance().getDestination();
            remoteObj.addDoor.addEventListener("result", onAddDoor);
            remoteObj.delDoor.addEventListener("result", onDelDoor);
        }
        
        private function onAddDoor(resEvent:ResultEvent):void
        {
           
        }
        private function onDelDoor(resEvent:ResultEvent):void
        {
           
        }
        
        
        public function execute():void
        {
        }
        
        public function rollback():void
        {
        }
    }
}
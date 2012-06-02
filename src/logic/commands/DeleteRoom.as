package logic.commands
{
    import components.Board;
    import components.RoomCreator;
    
    import config.Config;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class DeleteRoom implements Command
    {
        private var blocks:ArrayCollection = new ArrayCollection();
        private var remoteObj:RemoteObject;
        public function DeleteRoom(board:Board, roomCreator:RoomCreator)
        {

            //remoteObj = new RemoteObject();
            //remoteObj.endpoint = Config.getInstance().getEndpoint();
            //remoteObj.destination = Config.getInstance().getDestination();
            //remoteObj.addRoom.addEventListener("result", onAddRoom);
            //remoteObj.delRoom.addEventListener("result", onDelRoom);
        }
        
        public function execute():void
        {
        }
        
        public function rollback():void
        {
        }
    }
}
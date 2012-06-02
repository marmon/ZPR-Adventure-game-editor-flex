package logic.commands
{
    import config.Config;
    
    import model.BlockViewModel;
    
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.RemoteObject;
    
    import view.BigBlockView;
    import view.BlockView;

    /*
    Example: var cmd:ChangeBlockColor = new ChangeBlockColor();
    cmd.bigBlockView = bigBlockView
    cmd.oldColor = oldColor
    cmd.newColor = newColor
    
    // then use RedoUndo object to execute cmd
    redoUndo.execute(cmd);
    */
    public class ChangeBlockColor implements Command
    {
        public var bigBlockView:BigBlockView;
        public var oldColor:uint;
        public var newColor:uint;
        public var roomId:int;
        public var isAddition:Boolean = true;
        
        private var remoteObj:RemoteObject;
        
        public function ChangeBlockColor()
        {
            remoteObj = new RemoteObject();
            remoteObj.endpoint = Config.getInstance().getEndpoint();
            remoteObj.destination = Config.getInstance().getDestination();
            remoteObj.addRoomPoint.addEventListener("result", onAddRoomPoint);
            remoteObj.delRoomPoint.addEventListener("result", onDelRoomPoint);
        }
        
        private function onAddRoomPoint(resEvent:ResultEvent):void
        {
            //id = (resEvent.result as int);
           // roomCreator.refreshRoomList();
        }
        private function onDelRoomPoint(resEvent:ResultEvent)
        {
            //roomCreator.refreshRoomList();
        }
     // addRoomPoint( roomId, roomX, roomY ):   
     // delRoomPoint( roomX, roomY ):
        public function execute():void
        {
            // change visual appeal
            bigBlockView.changeColor(newColor);
            bigBlockView.draw();
            // add points to db
            if(isAddition)
            {
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.addRoomPoint(roomId, block.col, block.row );
                }
            }
            else
            {
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.delRoomPoint(block.col, block.row );
                }
            }
        }
        
        public function rollback():void
        {
            bigBlockView.changeColor(oldColor);
            bigBlockView.draw();
            if(isAddition)
            {
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.delRoomPoint(block.col, block.row );
                }
            }
            else
            {
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.addRoomPoint(roomId, block.col, block.row );
                }
            }
            
        }
    }
}
package logic.commands
{
    import components.RoomCreator;
    
    import config.Config;
    
    import model.BlockViewModel;
    
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.RemoteObject;
    
    import view.BigBlockView;
    import view.BlockView;

    public class ChangeBlockColor implements Command
    {
        public var bigBlockView:BigBlockView;
        public var oldColor:uint;
        public var newColor:uint;
		public var oldRoomId:int;
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
			
        }
        private function onDelRoomPoint(resEvent:ResultEvent)
        {
        }

        public function execute():void
        {
            // change visual appeal
            bigBlockView.changeColor(newColor, roomId);
            bigBlockView.draw();
            // add points to db
            if(isAddition)
            {
				if(oldRoomId != -1)
				{
					for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
					{
						remoteObj.delRoomPoint(block.col, block.row );
					}
				}
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.addRoomPoint(roomId, block.col, block.row );
                }
            }
            else
            {
				if(oldRoomId != -1)
				{
	                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
	                {
	                    remoteObj.delRoomPoint(block.col, block.row );
	                }
				}
            }
        }
        
        public function rollback():void
        {
            bigBlockView.changeColor(oldColor, oldRoomId);
            bigBlockView.draw();
            if(isAddition)
            {
                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
                {
                    remoteObj.delRoomPoint(block.col, block.row );
                }
				if(oldRoomId != -1)
				{
					for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
					{
						remoteObj.addRoomPoint(oldRoomId, block.col, block.row );
					}
				}
            }
            else
            {
				if(oldRoomId != -1)
				{
					
	                for each (var block:BlockViewModel in bigBlockView.blocksViewModel) 
	                {
	                    remoteObj.addRoomPoint(oldRoomId, block.col, block.row );
	                }
				}
            }
            
        }
    }
}
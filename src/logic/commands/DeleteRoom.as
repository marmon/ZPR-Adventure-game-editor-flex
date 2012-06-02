package logic.commands
{
    import components.Board;
    import components.RoomCreator;
    
    import config.Config;
    
    import model.BlockViewModel;
    import model.BoardViewModel;
    
    import mx.collections.ArrayCollection;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.remoting.mxml.RemoteObject;
    
    import valueObject.Room;
    
    import view.BigBlockView;

    public class DeleteRoom implements Command
    {
        private var changeBlockCmds:ArrayCollection = new ArrayCollection();
        private var remoteObj:RemoteObject;
        private var roomCreator:RoomCreator;
        private var board:Board;
        private var room:Room;
        private var index:int;
        private var id:int;
        
        public function DeleteRoom(board:Board, roomCreator:RoomCreator)
        {
            this.board = board;
            this.roomCreator = roomCreator;
            // firstly get the room
            room = (roomCreator.list.selectedItem as Room);
            var blocks:Array = board.boardView.bigBlockViews;
            
            var newColor:uint = board.getBoardViewModel().defaultColorOfEmptyBlock
            // now add all big blocks models which belongs to room to the blocks collection
            for(var row:int = 0 ; row < blocks.length ; ++row)
                for(var col:int = 0 ; col < blocks[row].length ; ++col)
                {
                    if((blocks[row][col] as BigBlockView).getCurrentColor() == room.color)
                    {
                        var cmd:ChangeBlockColor = new ChangeBlockColor();
                        cmd.bigBlockView = blocks[row][col];
                        cmd.oldColor = room.color;
                        cmd.newColor = newColor;
                        cmd.roomId = room.id;
                        cmd.isAddition = false;
                        changeBlockCmds.addItem(cmd);
                    }
                }
            
            remoteObj = new RemoteObject();
            remoteObj.endpoint = Config.getInstance().getEndpoint();
            remoteObj.destination = Config.getInstance().getDestination();
            remoteObj.addRoom.addEventListener("result", onAddRoom);
            remoteObj.delRoom.addEventListener("result", onDelRoom);
        }
        
        private function onAddRoom(resEvent:ResultEvent):void
        {
            id = (resEvent.result as int);
            roomCreator.refreshRoomList();
            
            // add points to board and db
            // set all blocks
            for each (var cmd:ChangeBlockColor in changeBlockCmds) 
            {
                cmd.roomId = id;
                cmd.rollback();
            }
        }
        private function onDelRoom(resEvent:ResultEvent)
        {
            roomCreator.refreshRoomList();
        }
        
        public function execute():void
        {
            // remove room from the list
            index = roomCreator.removeRoomFromTheList(room);
            
            // firstly delete all blocks
            for each (var cmd:ChangeBlockColor in changeBlockCmds) 
            {
               cmd.execute();
            }
            // then remove room
            remoteObj.delRoom(id);
        }
        
        public function rollback():void
        {
            // add room to the list
            roomCreator.addRoomToTheList(room, index);
            
            // add room to db
            remoteObj.addRoom(roomCreator.levelId, room.name, room.color);
            
            // rest of the operation in the onAddRoom handler
        }
    }
}
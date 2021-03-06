package view
{
	import com.adobe.serialization.json.JSON;
	
	import events.AddDoorEvent;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	
	import logic.Tools;
	import logic.UndoRedo;
	import logic.commands.AddDoorCmd;
	import logic.commands.AddObjectCmd;
	import logic.commands.ChangeBlockColor;
	import logic.commands.ChangeRoomMode;
	import logic.commands.SetItem;
	
	import model.BlockViewModel;
	import model.BoardViewModel;
	
	public class BoardView extends Sprite
	{
		public var boardViewModel:BoardViewModel;
		public var blockLength:uint;
        private var currentRoomColor:uint;
        private var url:String;
        
		public var tool:String = Tools.SELECTION; 
        
        public var blockViews:Array; //I wouldn't need that if I could dispatch event from BLockViewModel after color change.
                                    // but it is easier to expiclitly keep references to views.
        public var bigBlockViews:Array;
        
        // true - mode where you add objects to room
        // false - mode where you create rooms and add doors
        [Bindable]
        public var isRoomModeOn:Boolean = false;
        private var roomId:int;
        
        public function BoardView(x:uint, y:uint, boardViewModel:BoardViewModel, defaultBlockLength:uint = 20)
        {
            super();
            this.boardViewModel = boardViewModel;
            this.blockLength = defaultBlockLength;
            this.x = x;
            this.y = y;
            
            
            
            // Initialization of BigBlockView
            bigBlockViews = new Array(boardViewModel.board.length / 3);
            for(var row:int = 0 ; row < boardViewModel.board.length / 3 ; ++row)
                bigBlockViews[row] = new Array(boardViewModel.board[row].length / 3);
            // Creating objects in array
            for(var row:int = 0 ; row < bigBlockViews.length ; ++row)
            {
                for(var col:int = 0 ; col < bigBlockViews[row].length ; ++col)
                {
                    var bigBlockView:BigBlockView = new BigBlockView(blockLength);
                    bigBlockViews[row][col] = bigBlockView;
                    bigBlockView.x = col*blockLength;
                    bigBlockView.y = row*blockLength;
                    this.addChild(bigBlockView);
                    bigBlockView.addEventListener(MouseEvent.CLICK, bigBlockClicked);
                    bigBlockView.addEventListener(MouseEvent.DOUBLE_CLICK, blockDoubleClicked); 
                }
            }
            
            // Adding 9 model blocks into each view object.
            for(var row:int = 0 ; row < bigBlockViews.length ; ++row)
            {
                for(var col:int = 0 ; col < bigBlockViews[row].length ; ++col)
                {
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3][col*3] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3][col*3 + 1] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3][col*3 + 2] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 1][col*3] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 1][col*3 + 1] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 1][col*3 + 2] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 2][col*3] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 2][col*3 + 1] );
                    (bigBlockViews[row][col] as BigBlockView).addBlockViewModel( boardViewModel.board[row*3 + 2][col*3 + 2] );
                    (bigBlockViews[row][col] as BigBlockView).draw();
                }
            }
        }
        

        public function blockClicked(event:MouseEvent):void
        {
            // TODO Auto-generated method stub
			if(tool == Tools.ADD_OBJECT)
			{
				var selectedX:int;
				var selectedY:int;
				selectedX = (event.target as BlockView).x;
				selectedY = (event.target as BlockView).y;
				selectedX = (selectedX / blockLength);
				selectedY = (selectedY / blockLength);
				var cmd:AddObjectCmd = new AddObjectCmd(selectedX, selectedY, bigBlockViews[(selectedY - (selectedY % 3))/3][(selectedX - (selectedX % 3))/3], this);
				UndoRedo.getInstance().execute(cmd);
			}
            
        }
        
        public function setIsRoomModeOn(value:Boolean):void
        {
			var cmd:ChangeRoomMode = new ChangeRoomMode(value, this);
			UndoRedo.getInstance().execute(cmd);
        }
        
        public function blockDoubleClicked(event:MouseEvent):void
        {
            dispatchEvent(event);

        }
        
		// Set color to block model and update view to reflect changes.
		protected function bigBlockClicked(event:MouseEvent):void
		{
			var selectedX:int;
			var selectedY:int 
			if(event.target is Loader)
			{
	            selectedX = ((event.target as Loader).parent as BigBlockView).x;
	            selectedY = ((event.target as Loader).parent as BigBlockView).y;
				
			}
			else
			{
				selectedX = (event.target as BigBlockView).x;
				selectedY = (event.target as BigBlockView).y;
			}
            selectedX = (selectedX / blockLength);
            selectedY = (selectedY / blockLength);
            
            if(tool == Tools.PAINT)	
			{
            // Cmd design pattern
	            var cmd:ChangeBlockColor = new ChangeBlockColor();
	            var row:int = selectedY;
	            var col:int = selectedX;
                cmd.oldColor = bigBlockViews[row][col].getCurrentColor();
				cmd.oldRoomId =  bigBlockViews[row][col].roomId;
                cmd.newColor = currentRoomColor;
                cmd.bigBlockView = bigBlockViews[row][col];
                cmd.roomId = roomId;
                cmd.isAddition = true;
                UndoRedo.getInstance().execute(cmd);
                var eventObject:Event = new Event("roomChanged");
                dispatchEvent(eventObject);
                return;
			}
            else if( tool == Tools.ERASE)
            {
                // TODO handle erase here
				var cmd:ChangeBlockColor = new ChangeBlockColor();
				var row:int = selectedY;
				var col:int = selectedX;
				cmd.oldColor = bigBlockViews[row][col].getCurrentColor();
				cmd.oldRoomId =  bigBlockViews[row][col].roomId;
				cmd.newColor = boardViewModel.defaultColorOfEmptyBlock;
				cmd.bigBlockView = bigBlockViews[row][col];
				cmd.roomId = -1;
				cmd.isAddition = false;
				UndoRedo.getInstance().execute(cmd);
				var eventObject:Event = new Event("roomChanged");
				dispatchEvent(eventObject);
				return;
            }
            // Doors will be added like this:
            // If in horizontal mode then you point to the left side on the door and the right side is added also
            // If in vertical mode then you point to the bottom and upper will be added also
            else if(tool == Tools.DOOR_H)
            {
				var row:int = selectedY;
				var col:int = selectedX;
				if(bigBlockViews[row][col].roomId == bigBlockViews[row][col + 1].roomId ||
					bigBlockViews[row][col].roomId == -1 || bigBlockViews[row][col + 1].roomId == -1)
				{
					return;
					
				}
				var x1:uint =3* col + 2;
				var y1:uint = 3*row + 1;
				var x2:uint = 3*(col + 1);
				var y2:uint = 3*row + 1;
				if((!bigBlockViews[row][col].isEmpytSpace) || (!bigBlockViews[row][col+1].isEmpytSpace))
					return;
				var cmdAddDoor:AddDoorCmd = new AddDoorCmd(x1, y1, x2, y2, bigBlockViews[row][col], bigBlockViews[row][col + 1]);
				UndoRedo.getInstance().execute(cmdAddDoor);
            }
            else if(tool == Tools.DOOR_V)
            {

				var row:int = selectedY;
				var col:int = selectedX;
				if(((bigBlockViews[row][col].roomId) == (bigBlockViews[row+1][col].roomId)) ||
					(bigBlockViews[row][col].roomId == -1) || (bigBlockViews[row+1][col].roomId == -1))
				{
					return;
					
				}

				var x1:uint = 3*col + 1;
				var y1:uint = 3*row + 2;
				var x2:uint = 3*col + 1;
				var y2:uint = (row + 1)*3;
				if((!bigBlockViews[row][col].isEmpytSpace) || (!bigBlockViews[row+1][col].isEmpytSpace))
					return;
				var cmdAddDoor:AddDoorCmd = new AddDoorCmd(x1, y1, x2, y2, bigBlockViews[row][col], bigBlockViews[row + 1][col]);
				UndoRedo.getInstance().execute(cmdAddDoor);
            }
		}
		public function colorRoomPoints(roomId:int, color:uint, col:int, row:int):void
		{
			(bigBlockViews[row][col] as BigBlockView).drawRoomPoint(color, roomId);
		}
		public function drawDoor(x:int, y:int):void
		{
			(bigBlockViews[(y - (y%3))/3][(x - (x%3))/3] as BigBlockView).drawDoor(x, y, true);
		}
		public function drawItem(x:int, y:int):void
		{
			(bigBlockViews[(y - (y%3))/3][(x - (x%3))/3] as BigBlockView).drawObject(x, y, true);
		}
		public function setCurrentRoomColor(color:uint):void
        {
            this.currentRoomColor = color;
        }
		
		public function setUrl(url:String):void
		{
			this.url = url;
		}
        
        public function getGridWidth():uint
        {
            if ( isRoomModeOn )
            {
                return blockViews[0].length * blockLength;
            }
            else
            {
                return bigBlockViews[0].length * blockLength;
            }
            
        }
        public function getGridHeight():uint
        {
            if ( isRoomModeOn )
            {
                return blockViews.length * blockLength;
            }
            else
            {
                return bigBlockViews.length * blockLength;
            }
        }
		
        public function setCurrentRoomId(roomId:int):void
        {
            this.roomId = roomId;
            
        }
    }
}
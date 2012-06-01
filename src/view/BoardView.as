package view
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import logic.Tools;
	import logic.UndoRedo;
	import logic.commands.ChangeBlockColor;
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
        public var isRoomModeOn:Boolean = false;
        
        public function BoardView(x:uint, y:uint, boardViewModel:BoardViewModel, defaultBlockLength:uint = 20)
        {
            super();
            this.boardViewModel = boardViewModel;
            this.blockLength = defaultBlockLength;
            this.x = x;
            this.y = y;
            
           /* blockViews = new Array(boardViewModel.board.length);
            for(var row:int = 0 ; row < boardViewModel.board.length ; ++row)
                blockViews[row] = new Array(boardViewModel.board[row].length);
            
            
            
            for(var row:int = 0 ; row < boardViewModel.board.length ; ++row)
            {
                for(var col:int = 0 ; col < boardViewModel.board[row].length ; ++col)
                {
                    var  blockView:BlockView = new BlockView(boardViewModel.board[row][col], blockLength);
                    this.addChild(blockView);
                    blockView.addEventListener(MouseEvent.CLICK, blockClicked);
                    blockView.addEventListener(MouseEvent.DOUBLE_CLICK, blockDoubleClicked); 
                    blockViews[row][col] = blockView;
                }
            }*/
            
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
                    //bigbBockView.addEventListener(MouseEvent.DOUBLE_CLICK, blockDoubleClicked); 
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
        
        protected function blockDoubleClicked(event:MouseEvent):void
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
                cmd.newColor = currentRoomColor;
                cmd.bigBlockView = bigBlockViews[row][col];
                UndoRedo.getInstance().execute(cmd);
                var eventObject:Event = new Event("roomChanged");
                dispatchEvent(eventObject);
                return;
	            /*for(row = selectedX ; row < selectedX + 3; ++row)
	            {
	                if( row >= 0 && row < blockViews.length){      
	                    for(col = selectedY ; col < selectedY + 3; ++col)
	                    {
	                        if( col >= 0 && col < blockViews[row].length)
	                        {
	                            //(blockViews[row][col] as BlockView).changeColor(currentRoomColor);
	                            cmd.addBlock(blockViews[row][col]);
	                        }
	                    }
	                }
	            }
	            cmd.newColor = currentRoomColor;
				if(row >= blockViews.length)
					row = blockViews.length - 1;
				if(col >= (blockViews[row] as Array).length)
					col = (blockViews[row] as Array).length - 1;
	            cmd.oldColor = (blockViews[row][col] as BlockView).blockViewModel.roomColor;
	            UndoRedo.getInstance().execute(cmd);
                var eventObject:Event = new Event("roomChanged");
                dispatchEvent(eventObject);
				return;*/
			}
            else if( tool == Tools.ERASE)
            {
                // TODO handle erase here
            }
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
                return boardViewModel.board.length * blockLength;
            }
            else
            {
                return (boardViewModel.board.length / 3) * blockLength;
            }
            
        }
        public function getGridHeight():uint
        {
            if ( isRoomModeOn )
            {
                return boardViewModel.board[0].length * blockLength;
            }
            else
            {
                return (boardViewModel.board[0].length /3) * blockLength;
            }
        }
		
	}
}
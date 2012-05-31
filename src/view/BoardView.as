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
        
        public function BoardView(x:uint, y:uint, boardViewModel:BoardViewModel, defaultBlockLength:uint = 20)
        {
            super();
            this.boardViewModel = boardViewModel;
            this.blockLength = defaultBlockLength;
            this.x = x;
            this.y = y;
            
            blockViews = new Array(boardViewModel.board.length);
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
            }
        }
        
        protected function blockDoubleClicked(event:MouseEvent):void
        {
            dispatchEvent(event);
        }
        
		// Set color to block model and update view to reflect changes.
		protected function blockClicked(event:MouseEvent):void
		{
			var selectedX:int;
			var selectedY:int 
			if(event.target is Loader)
			{
	            selectedX = ((event.target as Loader).parent as BlockView).x;
	            selectedY = ((event.target as Loader).parent as BlockView).y;
				
			}
			else
			{
				selectedX = (event.target as BlockView).x;
				selectedY = (event.target as BlockView).y;
			}
            selectedX = (selectedX / blockLength);
            selectedY = (selectedY / blockLength);
            
            if(tool == Tools.PAINT)	
			{
	            --selectedX;
	            --selectedY;
            // Cmd design pattern
	            var cmd:ChangeBlockColor = new ChangeBlockColor();
	            var row:int;    // outside of for because I want to access last block added to check for the old color
	            var col:int;
	            for(row = selectedX ; row < selectedX + 3; ++row)
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
				return;
			}
            else if( tool == Tools.ERASE)
            {
                // TODO handle erase here
            }
            
			/*if(operationType == 1)
			{
//				(blockViews[selectedX][selectedY] as BlockView).setUrl(this.url);
				var cmd1:SetItem = new SetItem();
				cmd1.addBlock((blockViews[selectedX][selectedY] as BlockView));
				cmd1.url = this.url;
				UndoRedo.getInstance().execute(cmd1);
			}*/
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
            return boardViewModel.board.length * blockLength;
        }
        public function getGridHeight():uint
        {
            return boardViewModel.board[0].length * blockLength;
        }
		
	}
}
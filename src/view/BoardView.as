package view
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import logic.commands.ChangeBlockColor;
	
	import model.BlockViewModel;
	import model.BoardViewModel;
	
	public class BoardView extends Sprite
	{
		public var boardViewModel:BoardViewModel;
		public var blockLength:uint;
        private var currentRoomColor:uint;
        
        public var blockViews:Array; //I wouldn't need that if I could dispatch event from BLockViewModel after color change.
                                    // but it is easier to expiclitly keep references to views.
        
        public function BoardView(boardViewModel:BoardViewModel, defaultBlockLength:uint = 20)
        {
            super();
            this.boardViewModel = boardViewModel;
            this.blockLength = defaultBlockLength;
            
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
                    
                    blockViews[row][col] = blockView;
                }
            }
        }
        
		// Set color to block model and update view to reflect changes.
		protected function blockClicked(event:MouseEvent):void
		{
            var selectedX:int = (event.target as BlockView).x;
            var selectedY:int = (event.target as BlockView).y;
            selectedX = (selectedX / blockLength);
            selectedY = (selectedY / blockLength);
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
            cmd.oldColor = (blockViews[row][col] as BlockView).blockViewModel.roomColor;
            UndoRedo::getInstance().execute(cmd);
		}
		
		public function setCurrentRoomColor(color:uint)
        {
            this.currentRoomColor = color;
        }
		
	}
}
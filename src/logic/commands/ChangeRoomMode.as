package logic.commands
{
	import flash.events.MouseEvent;
	
	import view.BlockView;
	import view.BoardView;

	public class ChangeRoomMode implements Command
	{
		private var isRoomModeOn:Boolean;
		private var boardView:BoardView;
		public function ChangeRoomMode(value:Boolean, boardView:BoardView)
		{
			this.isRoomModeOn = value;
			this.boardView = boardView;
		}
		public function execute():void
		{
			//boardView.isRoomModeOn = this.isRoomModeOn;
			removeOldView(isRoomModeOn);
		}
		public function rollback():void
		{
			//boardView.isRoomModeOn = !(this.isRoomModeOn)
			//execute();
			removeOldView(!isRoomModeOn);
		}
		private function removeOldView(value:Boolean)
		{
			boardView.isRoomModeOn = value;
			if (value) // go to room mode
			{
				// remove BigBlocks 
				for(var row:int = 0 ; row < boardView.bigBlockViews.length ; ++row)
				{
					for(var col:int = 0 ; col < boardView.bigBlockViews[row].length ; ++col)
					{
						boardView.removeChild(boardView.bigBlockViews[row][col]); 
					}
				}
			}
			else
			{
				// remove blocks
				for(var row:int = 0 ; row < boardView.boardViewModel.board.length ; ++row)
				{
					for(var col:int = 0 ; col < boardView.boardViewModel.board[row].length ; ++col)
					{
						boardView.removeChild(boardView.blockViews[row][col]);
					}
				}
			}
			doChangeMode(value);
		}
		public function removeBlock()
		{
			for(var row:int = 0 ; row < boardView.boardViewModel.board.length ; ++row)
			{
				for(var col:int = 0 ; col < boardView.boardViewModel.board[row].length ; ++col)
				{
					boardView.removeChild(boardView.blockViews[row][col]);
				}
			}
		}
		public function doChangeMode(value:Boolean)
		{
	
			if (value) // go to room mode
			{
				
				// create Block view
				boardView.blockViews = new Array(boardView.boardViewModel.board.length);
				for(var row:int = 0 ; row < boardView.boardViewModel.board.length ; ++row)
					boardView.blockViews[row] = new Array(boardView.boardViewModel.board[row].length);
				
				for(var row:int = 0 ; row < boardView.boardViewModel.board.length ; ++row)
				{
					for(var col:int = 0 ; col < boardView.boardViewModel.board[row].length ; ++col)
					{
						
						var  blockView:BlockView = new BlockView(boardView.boardViewModel.board[row][col], boardView.blockLength);
						boardView.addChild(blockView);
						blockView.addEventListener(MouseEvent.CLICK, boardView.blockClicked);
						blockView.addEventListener(MouseEvent.DOUBLE_CLICK, boardView.blockDoubleClicked); 
						boardView.blockViews[row][col] = blockView;
					}
				}
			}
			else // go back to big block mode
			{
				
				// add bigblocks
				for(var row:int = 0 ; row < boardView.bigBlockViews.length ; ++row)
				{
					for(var col:int = 0 ; col < boardView.bigBlockViews[row].length ; ++col)
					{
						boardView.addChild(boardView.bigBlockViews[row][col]); 
					}
				}
			}
		}
	}
}
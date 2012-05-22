package model
{
    public class BoardViewModel
    {
        public var board:Array;
        public var defaultColorOfEmptyBlock:uint;
        
        public function BoardViewModel(initialRows:uint = 10, initialCols:uint = 10, defaultColorOfEmptyBlock:uint = 0xE3E3E3)
        {
            this.defaultColorOfEmptyBlock = defaultColorOfEmptyBlock;
            board = new Array(initialRows);
            
            // Set up board to 2D array
            for(var row:int = 0 ; row < board.length ; ++row)
                board[row] = new Array(initialCols);
            
            for(var row:int = 0 ; row < board.length ; ++row)
                for(var col:int = 0 ; col < board[row].length ; ++col)
                {
                    board[row][col] = new BlockViewModel(row, col, defaultColorOfEmptyBlock);
                }
            
        }
    }
}
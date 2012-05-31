package model
{
    public class BoardViewModel
    {
        public var board:Array;
        public var defaultColorOfEmptyBlock:uint;
        
        public static const FIRST:String = "first";
        public static const LAST:String = "last";
        
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
        
        private function updatePos():void
        {
            for(var row:int = 0 ; row < board.length ; ++row)
                for(var col:int = 0 ; col < board[row].length ; ++col)
                {
                    (board[row][col] as BlockViewModel).col = col;
                    (board[row][col] as BlockViewModel).row = row;
                }
        }
        
        public function insertColumn(position:String):void 
        {
            if(position == FIRST)
            {
                for(var row:int = board.length ; row > 0 ; --row)
                    board[row] = board[row-1];
                    
                board[0] = new Array((board[1] as Array).length);
                for(var col:int = 0 ; col < board[0].length ; ++col)
                {
                    board[0][col] = new BlockViewModel(0, col, defaultColorOfEmptyBlock);
                }
            }
            else
            {
                board[board.length] = new Array((board[1] as Array).length);
                for(var col:int = 0 ; col < board[0].length ; ++col)
                {
                    board[board.length - 1][col] = new BlockViewModel(board.length - 1, col, defaultColorOfEmptyBlock);
                }
            }
            updatePos();
        }
        
        public function insertRow(position:String):void
        {
            if(position == FIRST)
            {
                for(var row:int = 0 ; row < board.length ; ++row)
                {
                    for(var col:int = board[row].length ; col > 0 ; --col)
                        board[row][col] = board[row][col-1];
                    board[row][0] = new BlockViewModel(row, 0, defaultColorOfEmptyBlock);
                }
            }
            else
            {
                for(var row:int = 0 ; row < board.length ; ++row)
                {
                    board[row][board[row].length] = new BlockViewModel(row, board[row].length, defaultColorOfEmptyBlock);
                }
            }
            updatePos();
        }
    }
}
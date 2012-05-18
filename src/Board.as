package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class Board extends Sprite
	{
		var board:Array;
		
		public function Board(blockLength:Number)
		{
			super();
			x = 0;
			y = 0;
			// Setting up two dim array
			board = new Array(10);
			for (var k:int = 0; k < board.length; k++) 
			{
				board[k] = new Array(10);
			}
			
			
			graphics.lineStyle(1, 0xA3A3A3);
			graphics.beginFill(0xCCAA00); 
			graphics.drawRect(x,y,100, 100);
			graphics.endFill(); 
			
			var block:Block = new Block(x,y);
			block.drawBlock(blockLength);
			this.addChild(block);
			
			for (var i:int = 0; i < 10; ++i) 
			{ 
				for(var j:int = 0; j < 10; ++j)
				{
					var block:Block = new Block(i*blockLength, j*blockLength);	
					board[i][j] = block;
					this.addChild(block);
					block.drawBlock(blockLength);					
				}
			}			
		}
	}
}
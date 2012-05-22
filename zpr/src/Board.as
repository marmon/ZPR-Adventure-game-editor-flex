package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class Board extends Sprite
	{
		public var board:Array;
		public var blockColor:uint = 0xE3E3E3;
		public var blockLength:uint
		
		public function Board(blockLength:uint)
		{
			super();
			x = 0;
			y = 0;
			this.blockLength = blockLength;
			//buttonMode = true;
			// Setting up two dim array
			board = new Array(10);
			for (var k:int = 0; k < board.length; k++) 
			{
				board[k] = new Array(10);
			}
			
			
			/*graphics.lineStyle(1, 0xA3A3A3);
			graphics.beginFill(0xCCAA00); 
			graphics.drawRect(x,y,100, 100);
			graphics.endFill(); */
			
			/*var block:Block = new Block(x,y);
			block.drawBlock(blockLength);
			this.addChild(block);*/
			
			for (var i:int = 0; i < 10; ++i) 
			{ 
				for(var j:int = 0; j < 10; ++j)
				{
					var block:Block = new Block(i*blockLength, j*blockLength);	
					board[i][j] = block;
					this.addChild(block);
					block.drawBlock(blockLength, blockColor);
					block.addEventListener(MouseEvent.CLICK, blockClicked);
					block.addEventListener(MouseEvent.DOUBLE_CLICK, blockDoubleClicked);
				}
			}			
		}
		
		protected function blockClicked(event:MouseEvent):void
		{
			(event.target as Block).drawBlock(blockLength, blockColor);
		
		}
		protected function blockDoubleClicked(event:MouseEvent):void
		{
			
		}
		
	}
}
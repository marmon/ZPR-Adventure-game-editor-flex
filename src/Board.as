package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.adobe.serialization.json.JSON;
	
	public class Board extends Sprite
	{
		public var board:Array;
		public var blockColor:uint = 0xE3E3E3;
		public var blockLength:uint
		static private var tableSize:uint = 21; 
		public function Board(blockLength:uint)
		{
			super();
			x = 0;
			y = 0;
			this.blockLength = blockLength;
			// Setting up two dim array
			board = new Array(tableSize);
			for (var k:int = 0; k < board.length; k++) 
			{

				board[k] = new Array(tableSize);
			}
			
			
			/*graphics.lineStyle(1, 0xA3A3A3);
			graphics.beginFill(0xCCAA00); 
			
			graphics.drawRect(x,y,100, 100);
			graphics.endFill(); */
			
			/*var block:Block = new Block(x,y);
			block.drawBlock(blockLength);
			this.addChild(block);*/

			
			for (var i:int = 0; i < tableSize; ++i) 
			{ 
				for(var j:int = 0; j < tableSize; ++j)
				{
					var block:Block = new Block(i*blockLength, j*blockLength);	
					board[i][j] = block;
					this.addChild(block);
					block.drawBlock(blockLength, blockColor);
					block.addEventListener(MouseEvent.CLICK, blockClicked);
					
				}
			}			
		}
		
		protected function blockClicked(event:MouseEvent):void
		{
			//(event.target as Block).drawBlock(blockLength, blockColor);
			var selectedX:int = (event.target as Block).x;
			var selectedY:int = (event.target as Block).y;
			selectedX = (selectedX / blockLength);
			selectedY = (selectedY / blockLength);
			selectedX -= selectedX % 3;
			selectedY -= selectedY % 3;
			for(var i:int = 0; i < 3; i++)
			{
				for(var j:int = 0; j < 3; j++)
				{
					(board[selectedX + i][selectedY + j] as Block).drawBlock(blockLength, blockColor);
				}
			}
		
		}
	
		
		public function encode():String
		{
			return com.adobe.serialization.json.JSON.encode(this);
		}
		
	}
}
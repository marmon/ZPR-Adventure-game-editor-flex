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
		
		public function Board(blockLength:uint)
		{
			super();
			x = 0;
			y = 0;
			this.blockLength = blockLength;
			// Setting up two dim array
			board = new Array(10);
			for (var k:int = 0; k < board.length; k++) 
			{
				board[k] = new Array(10);
			}
			
			for (var i:int = 0; i < 10; ++i) 
			{ 
				for(var j:int = 0; j < 10; ++j)
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
			(event.target as Block).drawBlock(blockLength, blockColor);	
		}
		
		public function encode():String
		{
			return com.adobe.serialization.json.JSON.encode(this);
		}
		
	}
}
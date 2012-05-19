package
{
	import flash.display.Shape;
	
	public class Block extends Shape
	{
		
		public function Block(x:Number, y:Number)
		{
			super();
			this.x = x;
			this.y = y;
		}
		
		public function drawBlock(length:Number)
		{
			graphics.lineStyle(1, 0xB3B3B3);
			graphics.beginFill(0xFF0000); 
			graphics.drawRect(0,0,length, length);
			graphics.endFill();
		}
	}
}
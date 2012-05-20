package
{
	import flash.display.Sprite;
	
	public class Block extends Sprite
	{
		
		public function Block(x:uint, y:uint)
		{
			super();
			this.x = x;
			this.y = y;
			buttonMode = true;
		}
		
		public function drawBlock(length:uint, color:uint):void
		{
			graphics.lineStyle(1, 0xB3B3B3);
			graphics.beginFill(color); 
			graphics.drawRect(0,0,length, length);
			graphics.endFill();
		}
	}
}
package
{
	import flash.display.Sprite;
	
	public class Block extends Sprite
	{
//		public var elements:Array;
		public function Block(x:uint, y:uint)
		{
			super();
			this.x = x;
			this.y = y;
			buttonMode = true;
//			elements = new Array(3);
//			for(var i:int = 0; i < elements.length; i++)
//			{
//				elements[i] = new Array(3);
//				for(var j:int = 0; j < 3; j++)
//				{
//					var elem:Element = new Element(x + i*(20), y + j*20);
//					this.addChild(elem);
//					elements[i][j] = elem;
//				}
//			}
		}
		
		public function drawBlock(length:uint, color:uint):void
		{
			graphics.lineStyle(1, 0xB3B3B3);
			graphics.beginFill(color); 
			graphics.drawRect(0,0,length, length);
			graphics.endFill();
//			for(var i:int = 0; i< elements.length; i++)
//			{
//				for(var j:int = 0; j < 3; j++)
//				{
//					(elements[i][j] as Element).drawBlock(leng/3 , color);
//				}
				
			//}
		}
	}
}
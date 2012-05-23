package view
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import model.BlockViewModel;
	
	import mx.states.SetStyle;
	
	import spark.components.IconPlacement;
	import spark.primitives.Graphic;
	
	public class BlockView extends Sprite
	{
        public var blockViewModel:BlockViewModel;
        public var blockLenght:uint;
	//	private var txt:TextField;
        
        public function BlockView(blockViewModel:BlockViewModel, blockLength:uint)
        {
            this.blockViewModel = blockViewModel;
            this.blockLenght = blockLength;
            reposition();
            draw();
            buttonMode = true;
		//	txt = new TextField();
		//	addChild(txt);
//			icon="@Embed(source='images/entry.jpg')";
			
        }
        
        public function reposition():void
        {
            this.x = this.blockViewModel.row*blockLenght;
            this.y = this.blockViewModel.col*blockLenght;
        }
        
        public function changeColor(color:uint)
        {
            this.blockViewModel.roomColor = color;
            draw();
        }
        
        public function draw():void
        {
            graphics.lineStyle(1, 0xB3B3B3);
            graphics.beginFill(this.blockViewModel.roomColor); 
            graphics.drawRect(0,0,blockLenght, blockLenght);
            graphics.endFill();
		//	txt.text = "dziala";
        }
        
		/*public function BlockView(x:uint, y:uint)
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
		}*/
	}
}
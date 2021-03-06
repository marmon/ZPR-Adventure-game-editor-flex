package view
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import model.BlockViewModel;
	
	import mx.controls.Alert;
	import mx.states.SetStyle;
	
	import spark.components.IconPlacement;
	import spark.primitives.Graphic;
	
	public class BlockView extends Sprite
	{
        public var blockViewModel:BlockViewModel;
        public var blockLenght:uint;
		private var txt:TextField;
        private var url:String = "images/herb.png";
        private var loader:Loader = new Loader();
		public function BlockView(blockViewModel:BlockViewModel, blockLength:uint)
        {
            this.blockViewModel = blockViewModel;
            this.blockLenght = blockLength;
            reposition();
            draw();
			loadImg();
            buttonMode = true;
            doubleClickEnabled = true;
			
        }
        private function loadImg():void
		{
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadFailure);
			loader.alpha = 0;
			this.addChild(loader);
		}
		private function loadFailure(event:IOErrorEvent):void
		{
			Alert.show("Can't load :" + url);
		}
        public function reposition():void
        {
            this.x = this.blockViewModel.col*blockLenght;
            this.y = this.blockViewModel.row*blockLenght;
        }
        
        public function changeColor(color:uint):void
        {
            this.blockViewModel.roomColor = color;
        }
        
        public function draw():void
        {
            graphics.lineStyle(1, 0xB3B3B3);
            graphics.beginFill(this.blockViewModel.roomColor); 
            graphics.drawRect(0,0,blockLenght, blockLenght);
			if(this.blockViewModel.isDoor)
			{
				graphics.beginFill((this.blockViewModel.roomColor) + 100); 
				graphics.drawEllipse(0,0,blockLenght, blockLenght);
				graphics.endFill();
			}
			if(this.blockViewModel.isObject)
			{
				graphics.beginFill((this.blockViewModel.roomColor) + 500); 
				graphics.drawRect(2,2,blockLenght-4, blockLenght-4);
				graphics.endFill();
			}
            graphics.endFill();
        }
		public function setUrl(url:String):void
		{
			this.url = url;
			var request:URLRequest = new URLRequest(url);
			loader.load(request);
			loader.alpha = 1;
			
		}
		public function deleteUrl():void
		{
			loader.unload();
		}
	}
}
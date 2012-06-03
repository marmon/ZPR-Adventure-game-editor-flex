package view
{
    import flash.display.Sprite;
    
    import model.BlockViewModel;
    
    public class BigBlockView extends Sprite
    {
        public var blocksViewModel:Array = new Array();
        /* Blocks position in array
                0 1 2
                3 4 5
                6 7 9
        */
        public var blockLenght:uint;
		public var roomId:int;
        public function BigBlockView(blockLength:uint)
        {
            super();
            this.blockLenght = blockLength;
            buttonMode = true;
            doubleClickEnabled = true;
			this.roomId = -1;
        }
        
        public function addBlockViewModel(blockViewModel:BlockViewModel):void
        {
            blocksViewModel[blocksViewModel.length] = blockViewModel;
        }
        
        public function getCurrentColor():uint
        {
            return blocksViewModel[0].roomColor;
        }
        
        public function changeColor(color:uint, roomId:int):void
        {
			this.roomId = roomId;
            for each (var blockViewModel:BlockViewModel in blocksViewModel) 
            {
                blockViewModel.roomColor = color;   
            }
            draw();
        }
        public function drawRoomPoint(color:uint, roomId:int)
		{
			this.roomId = roomId;
			for each (var blockViewModel:BlockViewModel in blocksViewModel) 
			{
				blockViewModel.roomColor = color;   
			}
			draw();
		}
        public function draw():void
        {
            graphics.lineStyle(1, 0xB3B3B3);
            graphics.beginFill(this.blocksViewModel[0].roomColor); 
            graphics.drawRect(0,0,blockLenght, blockLenght);
            graphics.endFill();
        }
    }
}
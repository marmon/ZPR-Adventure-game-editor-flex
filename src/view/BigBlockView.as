package view
{
    import flash.display.Sprite;
    
    import mx.collections.ArrayCollection;
    import model.BlockViewModel;
    
    public class BigBlockView extends Sprite
    {
        private var blocksViewModel:ArrayCollection = new Array(9);
        public var blockLenght:uint;
        public function BigBlockView(blockLength:uint)
        {
            super();
            this.blockLenght = blockLength;
            buttonMode = true;
            doubleClickEnabled = true;
        }
        
        public function addBlockViewModel(blockViewModel:BlockViewModel):void
        {
            blocksViewModel.addItem(blockViewModel);
        }
        
        public function changeColor(color:uint):void
        {
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
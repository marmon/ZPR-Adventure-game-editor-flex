package model
{
    import flash.events.Event;
    
    public class BlockViewModel
    {
        public var col:uint;
        public var row:uint;
        public var roomColor:uint;
        
        public function BlockViewModel(row:uint, col:uint, roomColor:uint)
        {
            this.row = row;
            this.col = col;
            this.roomColor = roomColor;
        }
    }
}
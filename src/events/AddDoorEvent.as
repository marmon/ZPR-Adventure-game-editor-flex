package events
{
    import flash.events.Event;
    
    public class AddDoorEvent extends Event
    {
        public var isHorizontal:Boolean;
        public var row:uint;
        public var col:uint;
        
        public function AddDoorEvent(type:String, isHorizontal, row, col)
        {
            super(type);
            this.isHorizontal = isHorizontal;
            this.row = row;
            this.col = col;
        }
    }
}
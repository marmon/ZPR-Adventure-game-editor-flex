package logic.commands
{
    public class AddDoorCmd implements Command
    {
        private var room1X:uint;
        private var room1Y:uint;
        private var room2X:uint;
        private var room2Y:uint;
        
        public function AddDoorCmd(room1X:uint, room1Y:uint, room2X:uint, room2Y:uint)
        {
            this.room1X = room1X;
            this.room1Y = room1Y;
            this.room2X = room2X;
            this.room2Y = room2Y;
            
            // some remote object
        }
        
        public function execute():void
        {
        }
        
        public function rollback():void
        {
        }
    }
}
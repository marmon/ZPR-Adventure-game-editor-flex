package logic
{
    import utils.stack.Stack;

    public class UndoRedo
    {
        private var undo:Stack = new Stack();
        private var redo:Stack = new Stack();
        
        public function UndoRedo()
        {
            
        }
        
        public function execute(cmd:Command):void
        {
            cmd.execute();
            undo.push(cmd);
        }
        
        public function undo():void
        {
            if (canUndo())
            {    
                  var cmd:Command = (undo.pop() as Command);
                  cmd.rollback();
                  redo.push(cmd);
            }
        }
        
        public function redo():void
        {
            if (canRedo())
            {
                var cmd:Command = (redo.pop() as Command);
                cmd.execute();
                undo.push(cmd);
            }   
        }
        
        public function canUndo():Boolean
        {
            return !(undo.isEmpty());
        }
        public function canRedo():Boolean
        {
            return !(redo.isEmpty());
        }
        
    }
}
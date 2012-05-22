package logic
{
    import utils.stack.Stack;
    import logic.commands.Command;

    public class UndoRedo
    {
        private var undo:Stack = new Stack();
        private var redo:Stack = new Stack();
        
        public function UndoRedo()
        {
            
        }
        // every command must be executed only by this function
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
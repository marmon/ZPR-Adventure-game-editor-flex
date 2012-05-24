package logic
{
    import logic.commands.Command;
    
    import utils.stack.Stack;

    public class UndoRedo
    {
        private var _undo:Stack = new Stack();
        private var _redo:Stack = new Stack();
        
        private static var _instance:UndoRedo = null;
        public function UndoRedo(e:SingletonEnforcer) // there are only public constructors in AS3
        {
            
        }
        public static function getInstance():UndoRedo
        {
            if(_instance == null)
                _instance = new UndoRedo(new SingletonEnforcer());
            return _instance;
        }
        
        // every command must be executed only by this function
        public function execute(cmd:Command):void
        {
            cmd.execute();
            this._undo.push(cmd);
            
        }
        
        public function undo():void
        {
            if (canUndo())
            {    
                  var cmd:Command = (this._undo.pop() as Command);
                  cmd.rollback();
                  this._redo.push(cmd);
            }
        }
        
        public function redo():void
        {
            if (canRedo())
            {
                var cmd:Command = (this._redo.pop() as Command);
                cmd.execute();
                this._undo.push(cmd);
            }   
        }
        
        public function canUndo():Boolean
        {
            return !(this._undo.isEmpty());
        }
        public function canRedo():Boolean
        {
            return !(this._redo.isEmpty());
        }
        
    }
}

class SingletonEnforcer
{
    //nothing else required here
}
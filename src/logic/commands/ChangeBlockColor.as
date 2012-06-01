package logic.commands
{
    import view.BlockView;
    import view.BigBlockView;

    /*
    Example: var cmd:ChangeBlockColor = new ChangeBlockColor();
    cmd.bigBlockView = bigBlockView
    cmd.oldColor = oldColor
    cmd.newColor = newColor
    
    // then use RedoUndo object to execute cmd
    redoUndo.execute(cmd);
    */
    public class ChangeBlockColor implements Command
    {
        public var bigBlockView:BigBlockView;
        public var oldColor:uint;
        public var newColor:uint;
        
        public function ChangeBlockColor()
        {
        }
        
        public function execute():void
        {
            bigBlockView.changeColor(newColor);
            bigBlockView.draw();
        }
        
        public function rollback():void
        {
            bigBlockView.changeColor(oldColor);
            bigBlockView.draw();
        }
    }
}
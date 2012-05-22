package logic.commands
{
    import view.BlockView;

    /*
    Example: var cmd:ChangeBlockColor = new ChangeBlockColor(oldColor, newColor);
    cmd.addBlock(b1);
    cmd.addBlock(b2);
    
    // then use RedoUndo object to execute cmd
    redoUndo.execute(cmd);
    */
    public class ChangeBlockColor implements Command
    {
        private var blockViews:Array = new Array();
        private var oldColor:uint;
        private var newColor:uint;
        
        public function ChangeBlockColor(oldColor:uint, newColor:uint)
        {
            this.oldColor = oldColor;
            this.newColor = newColor;
        }
        
        public function addBlock(blockView:BlockView):void
        {
            blockViews[blockViews.length] = blockView;
        }
        
        public function execute():void
        {
            for each (var blockView:BlockView in blockViews) 
            {
                blockView.changeColor(newColor);   
            }
        }
        
        public function rollback():void
        {
            for each (var blockView:BlockView in blockViews) 
            {
                blockView.changeColor(oldColor);
            }
            
        }
    }
}
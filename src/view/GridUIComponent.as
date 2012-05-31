package view
{
    import mx.core.UIComponent;
    
    public class GridUIComponent extends UIComponent
    {
        private var boardView:BoardView;
        
        public function GridUIComponent(boardView:BoardView)
        {
            super();
            this.boardView = boardView;
        }
        
        override protected function measure():void
        {
            this.measuredWidth = boardView.getGridWidth();
            this.measuredHeight = boardView.getGridHeight();
        }
    }
}
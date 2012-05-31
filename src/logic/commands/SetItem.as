package logic.commands
{
	import valueObject.GameObject;
	
	import view.BlockView;

	public class SetItem implements Command
	{
		private var blockView:BlockView;
		public var url:String;
		public function addBlock(blockView:BlockView):void
		{
			this.blockView = blockView;
		}
		public function execute():void
		{
			this.blockView.setUrl(this.url);
		}
		public function rollback():void
		{
			this.blockView.deleteUrl();
		}
	}
}
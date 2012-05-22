package valueObject
{
    import com.adobe.serialization.json.JSON;

	public class Room
	{
		[Bindable]
		public var name:String;
		[Bindable]
		public var color:uint;
		
		public function Room()
		{
		}
        
        public function encode():String 
        {
            return com.adobe.serialization.json.JSON.encode(this);
        }
	}
}
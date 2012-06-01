// R. Nowak, 2009-10-19
package config {
	/* klasa dostarcza parametrow konfiguracyjnych */
	public class Config
	{
		/* ustawienia domyślne ustawiane po uruchomieniu przeglądarki internetowej */
		//"http://127.0.0.1:8000/demo/"
		private static const DEFAULT_PROTOCOL:String = "http";
		private static const DEFAULT_SERVER_NAME_WITH_PORT:String = "127.0.0.1:8000";
		private static const DEFAULT_ENDPOINT_SUFFIX:String = "demo/";
		private static const DEFAULT_DESTINATION:String = "demo";
		
		//instancja
		private static var instance : Config = null;
		
		private var protocol_ : String;
		private var serverNameWithPort_ : String;
		private var endpointSuffix_ : String;
		private var destination_ : String;
		private var endpoint_ : String;
		
		public static function getInstance() : Config
		{
			if ( instance == null )
				instance = new Config(arguments.callee);
			return instance;
		}
		
		public static function prepareURL(protocol:String, serverNameWithPort:String, suffix:String) : String {
			return protocol + "://" + serverNameWithPort + "/" + suffix;
		}
		
		public function Config(caller : Function = null )
		{
			if( caller != Config.getInstance ) {
				throw new Error ("Config is a singleton class, use getInstance() instead!");
			}
			
			//init private members
			protocol_  = DEFAULT_PROTOCOL;
			serverNameWithPort_  = DEFAULT_SERVER_NAME_WITH_PORT;
			endpointSuffix_  = DEFAULT_ENDPOINT_SUFFIX;
			destination_ = DEFAULT_DESTINATION;
			endpoint_ = prepareURL(protocol_, serverNameWithPort_, endpointSuffix_ );
		}
		
		/* Sets protocol and server name for all urls*/
		public function setURL(urlProtocol:String, urlServerNameWithPort:String) : void {
			protocol_ = urlProtocol;
			serverNameWithPort_ = urlServerNameWithPort;
			endpoint_=prepareURL(protocol_, serverNameWithPort_, endpointSuffix_);
		}
		
		/** accessor */
		public function getDestination() : String { return destination_; }
		
		/** accessor */
		public function getEndpoint() : String { return endpoint_; }
	}
	
}

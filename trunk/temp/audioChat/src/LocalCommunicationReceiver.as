package  
{
	import flash.net.LocalConnection;
	/**
	 * ...
	 * @author Physwf
	 */
	public class LocalCommunicationReceiver 
	{
		private var _cName:String;
		private var localConnection:LocalConnection;
		
		public function LocalCommunicationReceiver(cName:String) 
		{
			_cName = cName;
			localConnection = new LocalConnection();
			localConnection.connect(_cName);
		}
		
		public function setClient(client:Object)
		{
			localConnection.client = client;
		}
		
	}

}
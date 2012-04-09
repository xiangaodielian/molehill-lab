package  
{
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Physwf
	 */
	public class LocalCommunicationSender 
	{
		private var _cName:String;
		private var _mName:String;
		
		private var localConnection:LocalConnection;
		
		public function LocalCommunicationSender(cName:String,mName:String) 
		{
			_cName = cName;
			_mName = mName;
			localConnection = new LocalConnection();
			localConnection.addEventListener(StatusEvent.STATUS, onStatus);
		}
		
		private function onStatus(e:StatusEvent):void 
		{
			switch(e.level)
			{
				case "status":
					break;
				case "warning":
					break;
				case "error":
					break;
			}
		}
		
		public function send(data:ByteArray):void
		{
			localConnection.send(_name, _mName, data);
		}
		
	}

}
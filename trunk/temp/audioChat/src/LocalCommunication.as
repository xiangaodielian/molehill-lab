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
	public class LocalCommunication 
	{
		private var receiveChanel:String;
		private var sendChanel:String;
		private var mName:String;
		
		private var sender:LocalConnection;
		private var receiver:LocalConnection;
		
		
		public function LocalCommunication() 
		{
			sender = new LocalConnection();
			receiver = new LocalConnection();
			sendChanel = "chanelSend";
			receiveChanel = "chanelReceive";
		}
		
		public function connect():void
		{
			receiver.addEventListener(StatusEvent.STATUS,onStatus);
			receiver.connect(receiveChanel);
		}
		
		public function send(data:ByteArray):void
		{
			sender.send(sendChanel, mName, data);
		}
		
		public function setClient(client:Object):void
		{
			receiver.client = client;
		}	
		
		public function setSendChanel(name:String):void
		{
			sendChanel = name;
		}
		
		public function setReceiveChanel(name:String):void
		{
			receiveChanel = name;
		}
		
		public function setMethodName(name:String):void
		{
			mName = name;
		}
		
		private function onStatus(e:StatusEvent):void 
		{
			switch(e.level)
			{
				case "status":
					trace("status");
					break;
				case "warning":
					trace("warning");
					break;
				case "error":
					trace("error");
					break;
			}
		}
		

		
	}

}
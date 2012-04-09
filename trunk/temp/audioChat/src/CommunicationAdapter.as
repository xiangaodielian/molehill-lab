package  
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Physwf
	 */
	public class CommunicationAdapter 
	{
		private var _adaptee:*;
		
		public function CommunicationAdapter(adaptee:*) 
		{
			_adaptee = adaptee;
		}
		
		public function send(data:ByteArray):void
		{
			
		}
		
	}

}
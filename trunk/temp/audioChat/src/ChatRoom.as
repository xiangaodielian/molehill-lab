package   
{ 
	import flash.display.Sprite;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	
	/**
	 * 聊天室
	 * @author Physwf
	 */
	public class ChatRoom extends Sprite 
	{
		private var remoteComm:RemoteCommunication;//远程socket通信
		private var recorder:AudioRecorder;
		private var player:AudioPlayer;
		
		public function ChatRoom() 
		{
			recorder = new AudioRecorder();
			player = new AudioPlayer();
			
			remoteComm = new RemoteCommunication(player);
			recorder.setCommunication(remoteComm);
			player.addEventListener(getAudio);
		}
		/**
		 * 
		 * @param	e
		 */
		private function getAudio(e:SampleDataEvent):void
		{
			var soundbuffer:ByteArray = remoteComm.getBuffer();
			while (soundbuffer.bytesAvailable)
			{
				var f:Number = e.data.readFloat();
				e.data.writeFloat(f);
				e.data.writeFloat(f);
			}
		}
		
	}

}
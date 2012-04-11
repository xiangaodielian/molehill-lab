package  
{
	import flash.events.ActivityEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.system.Security;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Physwf
	 */
	public class AudioRecorder
	{
		private var commAdapter:CommunicationAdapter;
		private var microPhone:Microphone;
		private var buffer:ByteArray;

		public function AudioRecorder() 
		{
			microPhone =  Microphone.getMicrophone();
			Security.showSettings("microphone");
			if (!microPhone) throw new Error("获取麦克风失败！");
			microPhone.setSilenceLevel(0, 4000);
			microPhone.gain = 100;
			microPhone.rate = 44;
			buffer = new ByteArray();
		}
		
		public function setCommunication(comm:CommunicationAdapter):void
		{
			commAdapter = comm;
		}
		
		public function startRecord():void
		{
			microPhone.addEventListener(SampleDataEvent.SAMPLE_DATA, onData);
		}
		
		public function stopRecord():void
		{
			microPhone.removeEventListener(SampleDataEvent.SAMPLE_DATA, onData);
		}
		
		private function onData(e:SampleDataEvent):void 
		{
			while (e.data.bytesAvailable)
			{
				buffer.writeFloat(e.data.readFloat());
			}
		}
		
		public function getBuffer():ByteArray
		{
			return buffer;
		}
		
		
		
	}

}
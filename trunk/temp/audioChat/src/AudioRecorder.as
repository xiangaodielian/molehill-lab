package  
{
	import flash.events.ActivityEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Microphone;
	import flash.sampler.getSize;
	import flash.system.Security;
	import flash.utils.ByteArray;
	/**
	 * 音频抓取，并通过远程连接发送出去
	 * @author Physwf
	 */
	public class AudioRecorder
	{
		private var microPhone:Microphone;
		private var buffer:ByteArray;
		private var bufferQueue:Array=[];
		
		private var sender:RemoteCommunication;
		
		public function AudioRecorder() 
		{
			//获取麦克风并设置相关参数
			microPhone =  Microphone.getMicrophone();
			Security.showSettings("microphone");
			if (!microPhone) throw new Error("获取麦克风失败！");
			microPhone.setSilenceLevel(0, 4000);
			microPhone.gain = 100;
			microPhone.rate = 44;
			buffer = new ByteArray();
		}
		/**
		 * 注入远程socket通信对象
		 * @param	comm
		 */
		public function setCommunication(comm:RemoteCommunication):void
		{
			sender = comm;
		}
		/**
		 * 开始录制，
		 */
		public function startRecord():void
		{
			microPhone.addEventListener(SampleDataEvent.SAMPLE_DATA, onData);
		}
		/**
		 * 停止录制
		 */
		public function stopRecord():void
		{
			microPhone.removeEventListener(SampleDataEvent.SAMPLE_DATA, onData);
		}
		/**
		 * 将麦克风获取到得声音发送到远程服务端
		 * @param	e
		 */
		private function onData(e:SampleDataEvent):void 
		{
			while (e.data.bytesAvailable)
			{
				buffer.writeFloat(e.data.readFloat());
				//sender.sendAudioData(e.data.readFloat());
			}	
			bufferQueue.push(buffer);
			trace(bufferQueue.length)
			buffer = new ByteArray();
		}
		
		public function getBuffer():ByteArray
		{
			return bufferQueue.shift();
		}
		
		
		
	}

}
package  
{
	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	/**
	 * 声音播放器
	 * @author Physwf
	 */
	public class AudioPlayer 
	{
		private var sound:Sound;

		
		public function AudioPlayer() 
		{
			sound = new Sound();
		}
		/**
		 * 添加listener,在listener中实现获取音频流的方法
		 * @param	listener
		 */
		public function addEventListener(listener:Function):void 
		{
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, listener);
		}
		/**
		 * 调用请求音频数据
		 */
		public function play():void
		{
			sound.play();
		}
		
	}

}
package  
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Physwf
	 */
	public class AudioPlayer 
	{
		private var sound:Sound;
		
		public function AudioPlayer() 
		{
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE,onComplete)
		}
	
		public function loadAndPlay(stream:ByteArray):void
		{
			sound.loadCompressedDataFromByteArray(stream,stream.length);
		}
		
		private function onComplete(e:Event):void
		{
			sound.play();
		}
		
	}

}
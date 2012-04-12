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
		private var isLoading:Boolean = false;
		
		public function AudioPlayer() 
		{
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE,onComplete)
		}
	
		public function loadAndPlay(stream:ByteArray):void
		{
			if (isLoading) return;
			if (!stream.length) return;
			trace(stream.length,"stream.length");
			sound.loadPCMFromByteArray(stream,stream.length/4);
			isLoading = true;
		}
		
		private function onComplete(e:Event):void
		{
			sound.play();
			isLoading = false;
		}
		
	}

}
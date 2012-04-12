package  
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Physwf
	 */
	public class AudioMediator 
	{
		private var recorder:AudioRecorder;
		private var player:AudioPlayer;
		private static var instance:AudioMediator;
		
		public function AudioMediator(rec:AudioRecorder,pla:AudioPlayer) 
		{
			recorder = rec; player = pla;
			instance = this;
		}
		
		public static function getInstance():AudioMediator
		{
			return instance;
		}
		
		public function play():void
		{
			var tempbuffer:ByteArray = recorder.getBuffer();
			//tempbuffer.compress();
			player.loadAndPlay(tempbuffer);
		}
		
	}

}
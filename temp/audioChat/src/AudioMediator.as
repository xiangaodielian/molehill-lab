package  
{
	/**
	 * ...
	 * @author Physwf
	 */
	public class AudioMediator 
	{
		private var recorder:AudioRecorder;
		private var player:AudioPlayer;
		
		public function AudioMediator(rec:AudioRecorder,pla:AudioPlayer) 
		{
			recorder = rec; player = pla;
		}
		
		public function play():void
		{
			player.loadAndPlay(recorder.getBuffer());
		}
		
	}

}
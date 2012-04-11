package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Physwf
	 */
	public class Main extends Sprite 
	{
		private var recorder:AudioRecorder;
		private var player:AudioPlayer;
		private var localComm:LocalCommunication;
		private var commAdapter:CommunicationAdapter;
		private var mediator:AudioMediator;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			player = new AudioPlayer();
			recorder = new AudioRecorder();
			mediator = new AudioMediator(recorder,player);
			recorder.startRecord();
			
		}
		
		
		
	}
	
}
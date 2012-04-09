package  
{
	import flash.events.ActivityEvent;
	import flash.media.Microphone;
	/**
	 * ...
	 * @author Physwf
	 */
	public class AudioDetector 
	{
		private var commAdapter:CommunicationAdapter;
		private var microPhone:Microphone;
		
		public function AudioDetector() 
		{
			//commAdapter = new CommunicationAdapter()
			
		}
		
		public function establish():Boolean
		{
			microPhone =  Microphone.getMicrophone();
			if (!microPhone) return false;
			return true;
		}
		
		public function startDetectAudio():void
		{
			microPhone.addEventListener(ActivityEvent.ACTIVITY, onActivity);
		}
		
		private function onActivity(e:ActivityEvent):void 
		{
			
		}
		
		
		
	}

}
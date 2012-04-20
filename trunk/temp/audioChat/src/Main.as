package 
{
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SampleDataEvent;
	import flash.utils.ByteArray;
	
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
		private var btnRecord:SimpleButton ;
		private var btnPlay:SimpleButton;
		
		public function Main():void 
		{
			//if (stage) init();
			init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			player = new AudioPlayer();
			recorder = new AudioRecorder();
			mediator = new AudioMediator(recorder, player);
			btnRecord = new SimpleButton(getShape(0xFF0000), getShape(0x00FF00), getShape(0x0000FF),getShape(0x00F0FF));
			btnPlay = new SimpleButton(getShape(0xFF0000), getShape(0x00FF00), getShape(0x0000FF),getShape(0x00F0FF));
			btnPlay.x = 200;
			addChild(btnRecord);
			addChild(btnPlay);
			
			player.addEventListener(getSound);
			
			btnRecord.addEventListener(MouseEvent.MOUSE_DOWN, onRecord);
			btnRecord.addEventListener(MouseEvent.MOUSE_UP,onRecord);
			btnPlay.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onPlay(e:MouseEvent):void 
		{
			//mediator.play();
			player.play();
		}
		
		private function getSound(e:SampleDataEvent):void
		{
			var temp:ByteArray = recorder.getBuffer();
			if (!temp) return;
			trace(temp.length,"temp.length")
			temp.position = 0;
			while (temp.bytesAvailable)
			{
				//temp.readFloat()
				var m:Number = temp.readFloat();
				//var n:Number = Math.sin((Number(temp.position + e.position) / Math.PI / 2)) * 0.25
				e.data.writeFloat(m);
				e.data.writeFloat(m);
			}
		}
		
		private function onRecord(e:MouseEvent):void 
		{
			trace(e.type);
			switch(e.type)
			{
				case MouseEvent.MOUSE_DOWN:
					recorder.startRecord();
					break;
				case MouseEvent.MOUSE_UP:
					//recorder.stopRecord();
					break;
			}
		}
		
		private function getShape(color:uint):Shape
		{
			var s:Shape = new Shape();
			s.graphics.beginFill(color);
			s.graphics.drawRect(0, 0, 100, 30);
			s.graphics.endFill();
			return s;
		}
		
		
		
	}
	
}
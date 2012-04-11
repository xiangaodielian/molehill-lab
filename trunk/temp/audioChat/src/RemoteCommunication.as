package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class RemoteCommunication extends Sprite {
		
		// Socket类
		private var socket:Socket = null;
		
		// 2字节(16bits)的消息类型
		private var funcname:int = 0;
		
		// 4字节的协议包长度
		private var packet_len:int = -1;
		
		// 读message协议包的临时变量,flash的socket具有粘包的说法,所以需要一个临时的地方存放读到的包
		private var packet_buf:ByteArray;
		
		private var localComm:LocalCommunication;
		
		public function RemoteCommunication() {
			// 添加js可以调用的方法
			if (ExternalInterface.available) 
			{
				ExternalInterface.addCallback("send", send);
				ExternalInterface.addCallback("connect", connect);
				ExternalInterface.addCallback("disconnect", disconnect);
				flashSay('flash init success');
			}
			
			
			localComm = new LocalCommunication();
			localComm.connect();
			localComm.setClient(this);
			localComm.setMethodName("loadAndPlay");

		}
		
		private function flashSay(me:String):void
		{
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("hwg_Flash_call_js" , me);
			}
		}
		
		private function connect(host:String, port:int, policyPort:int = 0):void {
			flashSay("param host: " + host + " , param port:" + port);
			try {
				if (socket != null) {
					call("Error", "CONNECT");
					return;
				}
				if (policyPort > 0) {
					Security.loadPolicyFile("xmlsocket://" + host + ":" + policyPort);
				}
				socket = new Socket();
				socket.endian = Endian.BIG_ENDIAN;
				socket.addEventListener(Event.CONNECT, onConnect);
				socket.addEventListener(Event.CLOSE, onClose);
				socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
				socket.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
				socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				flashSay("start connect, timeout is 10sec...");
				socket.connect(host, port);
			}
			catch (Ex:Error) {
				
				call("Error", Ex.message);
				trace(Ex.message);
				
			}
		}
		
		private function call(name:String, param:Object = null):void 
		{
			if (ExternalInterface.available) 
			{
				ExternalInterface.call("hwg_" + name, param);
			}
		}
		
		private function onConnect(e:Event):void {
			trace("onConnect");
			call("onConnect");
			//send("1" , "{\"username\":\"test-user2\",\"password\":\"123456\",\"room\":\"12\",\"plat\":\"weibo\"}");
		}
		
		private function onClose(event:Event):void {
			trace("onClose");
			disconnect();
			call("onClose");
		}
		
		private function onIoError(e:IOErrorEvent):void {
			trace("onIoError");
			disconnect();
			call("Error", "IO");
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void {
			trace("onSecurityError");
			disconnect();
			call("Error", "SECURITY");
		}
		
		/**
		 * 处理接受到的数据
		 * @param	ByteArray
		 */
		private function onRecvPacket(packet:ByteArray):void 
		{
			//var s:String = packet.readUTFBytes(packet_len);
			localComm.send(packet);
			call("Recv", [funcname, s]);
			trace("Recv")
			trace(funcname)
			trace(s)
		}
		
		
		private function onSocketData(e:ProgressEvent):void 
		{

			trace('onSocketData');
			var pjf:int = 100;
			while (socket.bytesAvailable > 0)
			{
				if (packet_len == -1)
				{
					if (socket.bytesAvailable < 6) {
						break;
					}
					funcname = socket.readShort();// 读取一个带符号的2Byte(16bits)整数
					packet_len = socket.readInt();// 读取一个带符号的4Byte(32bits)整数
					packet_buf = new ByteArray();
				}
				// 从socket里面读取字节,写入到packet_buf里面去,一直到粘包的大小和packet_len一致了,然后做我们要做的处理
				socket.readBytes(packet_buf, 0, packet_len - packet_buf.length);
				if (packet_buf.length == packet_len)
				{
					onRecvPacket(packet_buf);
					packet_len = -1;
					funcname = 0;
				}
			}
		}

		private function send(f:String , s:String, ba:ByteArray):void 
		{
			if (socket == null) 
			{
				call("Error", "SOCKET IS CLOSE");
				return;
			}
			var fncname:int = parseInt(f);
			if (isNaN(fncname)) {
				call("Error", "FNAME");
				return;
			}
			ba ||= new ByteArray();
			ba.endian = Endian.BIG_ENDIAN;
			//ba.writeUTFBytes(s);
			ba.compress();
			socket.writeShort(fncname);
			socket.writeInt(ba.length);
			socket.writeBytes(ba);
			socket.flush();
			trace("flushed");
		}
		
		private function sendAudioData(data:ByteArray):void
		{
			send(null,null,data);
		}
		
		private function disconnect():void 
		{
			if (socket == null) 
			{
				call("Error", "SOCKET IS CLOSE");
				return;
			}
			socket.removeEventListener(Event.CONNECT, onConnect);
			socket.removeEventListener(Event.CLOSE, onClose);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			socket.close();
			socket = null;
		}
	}
}
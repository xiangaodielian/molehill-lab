package  
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.CubeTexture;
	import flash.display3D.textures.Texture;
	import flash.display3D.textures.TextureBase;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Physwf
	 */
	public class TestBase extends MovieClip 
	{
		protected var _context3D:Context3D;
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexBuffer:IndexBuffer3D;
		protected var _texture:Texture;
		protected var _cubeTexture:CubeTexture;
		protected var _program:Program3D;
		
		protected var _numVertex:int;
		protected var _data32PerVertex:int;
		protected var _numIndex:int;
		protected var _textureW:Number;
		protected var _textureH:Number;
		protected var _cubeSize:int;
		protected var _callBack:Function;
		
		public function TestBase() 
		{
			
		}
		
		protected function createContex():void 
		{
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onCreated);
			stage.stage3Ds[0].requestContext3D();
		}
		
		private function onCreated(e:Event):void 
		{
			_context3D = stage.stage3Ds[0].context3D;
			_context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, true);
			_context3D.enableErrorChecking = true;
			
			_vertexBuffer = _context3D.createVertexBuffer(_numVertex, _data32PerVertex);
			_indexBuffer = _context3D.createIndexBuffer(_numIndex);
			
			//_texture = _context3D.createTexture(_textureW, _textureH,Context3DTextureFormat.BGRA,true);
			//_cubeTexture = _context3D.createCubeTexture(_cubeSize, Context3DTextureFormat.BGRA,true);
			_program = _context3D.createProgram();
			load();
		}
		protected function load():void
		{
			trace(1111)
		}
		protected function loadVertexBuffer(data:Vector.<Number>):void
		{
			trace(data.length/_data32PerVertex,"data.lenth")
			_vertexBuffer.uploadFromVector(data,0,_numVertex);
		}
		
		protected function setVertexBufferAt(index:int,bufferOffset:int,format:String):void
		{
			_context3D.setVertexBufferAt(index, _vertexBuffer, bufferOffset, format);
		}
		
		protected function loadIndexBuffer(data:Vector.<uint>):void
		{
			trace(data.length,"Index.lenth")
			_indexBuffer.uploadFromVector(data, 0, _numIndex);
		}
		
		protected function loadCubeTexture(data:BitmapData,side:uint,mipLevel:uint=0):void
		{
	
			_cubeTexture.uploadFromBitmapData(data, side, mipLevel);

		}
		
		protected function setTextureAt(sampler:uint):void
		{
			_context3D.setTextureAt(sampler, _texture);
		}
		
		protected function setCubeTextureAt(sampler:uint):void
		{
			_context3D.setTextureAt(sampler, _cubeTexture);
		}
		
		protected function loadTexture(data:BitmapData,mipLevel:uint=0):void
		{
			_texture.uploadFromBitmapData(data, mipLevel);
		}

		protected function loadShaders(vertexShader:String,fragmentShader:String):void
		{
			_program.upload
			(
				new AGALMiniAssembler().assemble(Context3DProgramType.VERTEX, vertexShader, false),
				new AGALMiniAssembler().assemble(Context3DProgramType.FRAGMENT,fragmentShader,false)
			);
		}
		
		protected function setProgram():void
		{
			_context3D.setProgram(_program);
		}
	}

}
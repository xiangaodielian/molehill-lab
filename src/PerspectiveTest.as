package  
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display3D.textures.CubeTexture;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import geom.RawConst;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.sampler.getSize;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PerspectiveTest extends MovieClip 
	{
		private var context3D:Context3D;
		private var program:Program3D;
		private var unitMatrix:Matrix3D;
		private var vertexBuffer:VertexBuffer3D;
		private var texture:Texture;
		private var cubeTexture:CubeTexture;
		private var indexBuffer:IndexBuffer3D;
		[Embed(source="texture/flower.png")]
		private var Flower:Class;
		private var _translateM:Matrix3D;
		private var _rotateM:Matrix3D;
		
		public function PerspectiveTest() 
		{
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE,init);
			stage.stage3Ds[0].requestContext3D();
			super();
		}
		
		private function init(e:Event):void
		{
			var stage3D:Stage3D=e.target as Stage3D;
			//stage3D.viewPort=new Rectangle(0,0,800,600);
			context3D=stage3D.context3D;
			context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, true);
			vertexBuffer=context3D.createVertexBuffer(4,6);
			//vertexBuffer=context3D.createVertexBuffer(32,6);
			indexBuffer=context3D.createIndexBuffer(6);
			
			var vertexData:Vector.<Number> = RawConst.rectVertex;
			
			var indexData:Vector.<uint> = RawConst.rectIndex;
			
			
			vertexBuffer.uploadFromVector(vertexData,0,4);
			
			
			indexBuffer.uploadFromVector(indexData,0,6);
			
			program=context3D.createProgram();
			var vertexAssembler:AGALMiniAssembler=new AGALMiniAssembler();
			var fragmAssembler:AGALMiniAssembler=new AGALMiniAssembler();
			var vertexSrc:String=
				"m44 vt0, va0, vc0\n" +
				"m44 vt1, vt0, vc4\n" +
				"m44 vt2, vt1, vc8\n" +
				"mov op vt2"+
				"mov v0 ,va1";
			var fragmSrc:String="mov oc ,v0 \n";
			//"tex ft0,v0,fs0<cube,linear,clamp,mipnearest>\n" +
			//"mov oc ,ft0\n";
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmAssembler.assemble(Context3DProgramType.FRAGMENT,fragmSrc);

			program.upload(vertexAssembler.agalcode,fragmAssembler.agalcode);
			
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_3);	
			context3D.setTextureAt(0,cubeTexture);
			_translateM = new Matrix3D();
			_rotateM = new Matrix3D();
			var pm:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			_translateM.prependTranslation(0, 0,10);
			pm.perspectiveFieldOfViewLH(1.5, 4 / 3, 0.1, 1000);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,_rotateM,true);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,4,_translateM,true);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,8,pm,true);
			
			unitMatrix=new Matrix3D();
			
			//unitMatrix.appendScale(0.5,0.5,0.5);
			context3D.setCulling(Context3DTriangleFace.NONE);
			
			context3D.setProgram(program);
			addEventListener(Event.ENTER_FRAME, render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case Keyboard.W: 
					_translateM.appendTranslation(0, 0, 1);
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					trace(_translateM.rawData);
					break;
				case Keyboard.S: 
					_translateM.appendTranslation(0, 0, -1);
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					trace(_translateM.rawData);
					break;
				case Keyboard.A: 
					_translateM.appendTranslation(-1, 0, 0);
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					break;
				case Keyboard.D: 
					_translateM.appendTranslation(1, 0, 0);
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					break;
				case Keyboard.UP: 
					_rotateM.appendRotation(2, new Vector3D(1, 0, 0));
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.DOWN: 
					_rotateM.appendRotation(-2, new Vector3D(1, 0, 0));
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.LEFT: 
					_rotateM.appendRotation(2, new Vector3D(0, 1, 0));
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.RIGHT: 
					_rotateM.appendRotation(-2, new Vector3D(0, 1, 0));
					context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
			
			}
		}
		/**
		 * 
		 * @param e
		 * 
		 */
		private function render(e:Event):void
		{
			
			
			context3D.clear(0,0,0,1);
			//unitMatrix.appendRotation(3,new Vector3D(0,1,0),new Vector3D(0,0,17));
			
			//context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,124,unitMatrix,true);
			
			context3D.drawTriangles(indexBuffer,0,-1);
			context3D.present();
		}
	}

}
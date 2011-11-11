package 
{
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix3D;
	import flash.ui.Keyboard;
	import geom.RawConst;
	/**
	 * ...
	 * @author Physwf
	 */
	public class CubeTextureTest extends TestBase 
	{
		[Embed(source="texture/flower.png")]
		private var Flower:Class;
		
		private var modelMatrix:Matrix3D;
		private var textureData:BitmapData;
		
		public function CubeTextureTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
			
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			
			_numVertex = 24;
			_data32PerVertex = 6;
			_numIndex = 36;
			textureData = (new Flower() as Bitmap).bitmapData;
			//addChild(new Bitmap(textureData));
			trace(textureData)
			_cubeSize = textureData.width;
			_callBack = callBack;
			createContex();
		}
		
		private function callBack():void
		{

			loadVertexBuffer(RawConst.cubeVertex);
			setVertexBufferAt(0, 0, "float3");
			setVertexBufferAt(1, 3, "float3");
			
			loadIndexBuffer(RawConst.cubeIndex);
			loadCubeTextureOnce();
			//loadCubeTexture(textureData, 0);
			//loadCubeTexture(textureData, 1);
			//loadCubeTexture(textureData, 2);
			//loadCubeTexture(textureData, 3);
			//loadCubeTexture(textureData, 4);
			//loadCubeTexture(textureData, 5);
			setCubeTextureAt(0);
			
			_context3D.setCulling(Context3DTriangleFace.FRONT);
			var perspMatrix:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspMatrix.perspectiveFieldOfViewLH(0.7, stage.stageWidth / stage.stageHeight, -5, 5);
			
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, perspMatrix, true);
			
			modelMatrix = new Matrix3D();
			//modelMatrix.appendTranslation(0, 0, 5);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, modelMatrix, true);
			
			var vertexShader:String =
			"m44 vt0,va0,vc4\n" +
			"m44 op,vt0,vc0\n" +
			//"mov op, vt1\n" +
			"mov v0 ,va1";
			
			var fragmentShader:String =
			"tex ft4,v0,fs0 <cube,nearest,clamp>\n" +
			"mov oc ,ft4\n";
			
			loadShaders(vertexShader, fragmentShader);
			
			setProgram();
			
			addEventListener(Event.ENTER_FRAME, render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp)
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{

		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.UP:
					modelMatrix.appendTranslation(0, 0, 1);
					break;
				case Keyboard.DOWN :
					modelMatrix.appendTranslation(0, 0, -1);
					break;
				case Keyboard.RIGHT :
					modelMatrix.appendTranslation(-1, 0, 0);
					break;
				case Keyboard.LEFT:
					modelMatrix.appendTranslation(1, 0, 0);
					break;
			}
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, modelMatrix, true);
			trace(e.keyCode);
		}
		
		private function render(e:Event):void 
		{
			_context3D.clear(0, 0, 0, 1);
			_context3D.drawTriangles(_indexBuffer, 0, 12);
			_context3D.present();
		}
	}

}
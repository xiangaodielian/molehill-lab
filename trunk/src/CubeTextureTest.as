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
	import flash.geom.Vector3D;
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
		[Embed(source="texture/flower1.png")]
		private var Flower1:Class;
		[Embed(source="texture/flower2.png")]
		private var Flower2:Class;
		[Embed(source="texture/flower3.png")]
		private var Flower3:Class;
		[Embed(source="texture/flower4.png")]
		private var Flower4:Class;
		[Embed(source="texture/flower5.png")]
		private var Flower5:Class;
		[Embed(source="texture/flower6.png")]
		private var Flower6:Class;
		[Embed(source="texture/flower7.png")]
		private var Flower7:Class;
		[Embed(source="texture/flower8.png")]
		private var Flower8:Class;
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
			setVertexBufferAt(1, 0, "float3");
			
			loadIndexBuffer(RawConst.cubeIndex);
			
			var flower:Bitmap = new Flower() as Bitmap;
			var flower1:Bitmap = new Flower1() as Bitmap;
			var flower2:Bitmap = new Flower2() as Bitmap;
			var flower3:Bitmap = new Flower3() as Bitmap;
			var flower4:Bitmap = new Flower4() as Bitmap;
			var flower5:Bitmap = new Flower5() as Bitmap;
			var flower6:Bitmap = new Flower6() as Bitmap;
			var flower7:Bitmap = new Flower7() as Bitmap;
			var flower8:Bitmap = new Flower8() as Bitmap;
			
			loadCubeTexture(flower.bitmapData, 0, 0);
			loadCubeTexture(flower.bitmapData, 1, 0);
			loadCubeTexture(flower.bitmapData, 2, 0);
			loadCubeTexture(flower.bitmapData, 3, 0);
			loadCubeTexture(flower.bitmapData, 4, 0);
			loadCubeTexture(flower.bitmapData, 5, 0);
			
			loadCubeTexture(flower1.bitmapData, 0, 1);
			loadCubeTexture(flower1.bitmapData, 1, 1);
			loadCubeTexture(flower1.bitmapData, 2, 1);
			loadCubeTexture(flower1.bitmapData, 3, 1);
			loadCubeTexture(flower1.bitmapData, 4, 1);
			loadCubeTexture(flower1.bitmapData, 5, 1);
			
			loadCubeTexture(flower2.bitmapData, 0, 2);
			loadCubeTexture(flower2.bitmapData, 1, 2);
			loadCubeTexture(flower2.bitmapData, 2, 2);
			loadCubeTexture(flower2.bitmapData, 3, 2);
			loadCubeTexture(flower2.bitmapData, 4, 2);
			loadCubeTexture(flower2.bitmapData, 5, 2);
			
			loadCubeTexture(flower3.bitmapData, 0, 3);
			loadCubeTexture(flower3.bitmapData, 1, 3);
			loadCubeTexture(flower3.bitmapData, 2, 3);
			loadCubeTexture(flower3.bitmapData, 3, 3);
			loadCubeTexture(flower3.bitmapData, 4, 3);
			loadCubeTexture(flower3.bitmapData, 5, 3);
			
			loadCubeTexture(flower4.bitmapData, 0, 4);
			loadCubeTexture(flower4.bitmapData, 1, 4);
			loadCubeTexture(flower4.bitmapData, 2, 4);
			loadCubeTexture(flower4.bitmapData, 3, 4);
			loadCubeTexture(flower4.bitmapData, 4, 4);
			loadCubeTexture(flower4.bitmapData, 5, 4);
			
			loadCubeTexture(flower5.bitmapData, 0, 5);
			loadCubeTexture(flower5.bitmapData, 1, 5);
			loadCubeTexture(flower5.bitmapData, 2, 5);
			loadCubeTexture(flower5.bitmapData, 3, 5);
			loadCubeTexture(flower5.bitmapData, 4, 5);
			loadCubeTexture(flower5.bitmapData, 5, 5);
			
			loadCubeTexture(flower6.bitmapData, 0, 6);
			loadCubeTexture(flower6.bitmapData, 1, 6);
			loadCubeTexture(flower6.bitmapData, 2, 6);
			loadCubeTexture(flower6.bitmapData, 3, 6);
			loadCubeTexture(flower6.bitmapData, 4, 6);
			loadCubeTexture(flower6.bitmapData, 5, 6);
			
			loadCubeTexture(flower7.bitmapData, 0, 7);
			loadCubeTexture(flower7.bitmapData, 1, 7);
			loadCubeTexture(flower7.bitmapData, 2, 7);
			loadCubeTexture(flower7.bitmapData, 3, 7);
			loadCubeTexture(flower7.bitmapData, 4, 7);
			loadCubeTexture(flower7.bitmapData, 5, 7);
			
			loadCubeTexture(flower8.bitmapData, 0, 8);
			loadCubeTexture(flower8.bitmapData, 1, 8);
			loadCubeTexture(flower8.bitmapData, 2, 8);
			loadCubeTexture(flower8.bitmapData, 3, 8);
			loadCubeTexture(flower8.bitmapData, 4, 8);
			loadCubeTexture(flower8.bitmapData, 5, 8);
			
			
			setCubeTextureAt(0);
			
			_context3D.setCulling(Context3DTriangleFace.BACK);
			var perspMatrix:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspMatrix.perspectiveFieldOfViewLH(0.7, stage.stageWidth / stage.stageHeight, -5, 5);
			
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, perspMatrix, true);
			
			modelMatrix = new Matrix3D();
			modelMatrix.appendTranslation(0, 0, 15);
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
				case Keyboard.W:
					modelMatrix.appendRotation(1, new Vector3D(1,0,0), null);
					break;
				case Keyboard.A:
					modelMatrix.appendRotation(1, new Vector3D(0,1,0), null);
					break;
				case Keyboard.D:
					modelMatrix.appendRotation(1, new Vector3D(0,0,1), null);
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
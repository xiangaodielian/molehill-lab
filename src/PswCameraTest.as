package  
{
	import camera.lens.PerspectiveLens;
	import camera.PswCamera;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import geom.RawConst;
	import utils.math.PswMatrix3D;
	import utils.math.PswVector3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswCameraTest extends TestBase 
	{
		private var _camera:PswCamera;
		private var _cPos:PswVector3D;
		private var _rotateM:PswMatrix3D;
		private var _translateM:PswMatrix3D;
		
		public function PswCameraTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			//var test:PswMatrix3D = new PswMatrix3D
			//(
				//1, 0, 0, 1,
				//0, 1, 0, 2,
				//0, 0, 1, 2,
				//0, 0, 0, 1
			//);
			//var test2:PswMatrix3D = new PswMatrix3D
			//(
				//1, 0, 0, 1,
				//0, 1, 0, 1,
				//0, 0, 1, 1,
				//0, 0, 0, 1
			//);
			//test.matrixMultiply(test2);
			//trace(test.toString());
			//return;
			var lens:PerspectiveLens = new PerspectiveLens();
			lens.fov = 1.0;
			lens.zNear = 0.1;
			lens.zFar = 1000;
			lens.xyRatio = 5 / 4;
			_camera = new PswCamera(lens);
			_cPos = new PswVector3D(0, 0, -30,1);
			_camera.position = _cPos;
			
			//trace(_camera.viewProjectioin.toMatrix3D().rawData);
			_numVertex = RawConst.cubeVertex.length / 6;
			_numIndex = RawConst.cubeIndex.length;
			_data32PerVertex = 6;
			
			
			createContex();
		}
		
		override protected function load():void
		{
			loadVertexBuffer(RawConst.cubeVertexColor);
			setVertexBufferAt(0, 0, "float3");
			setVertexBufferAt(1, 3, "float3");
			loadIndexBuffer(RawConst.cubeIndex);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _camera.viewProjectioin.toMatrix3D(), false);
			_rotateM = new PswMatrix3D();
			_translateM = new PswMatrix3D();
			//_translateM.prependTranslation(0, 0, 10);
			//_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _rotateM.toMatrix3D(), true);
			//_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, _translateM.toMatrix3D(), true);
			_context3D.setCulling(Context3DTriangleFace.FRONT);
			var vertexShaderSrc:String = 
			//"m44 vt0,va0,vc4\n" +
			//"m44 vt2 ,vt0,vc8\n"+
			"m44 vt1 ,va0,vc0\n" +
			"mov op,vt1\n" +
			"mov v0,va1\n";
			var fragmentShaderSrc:String =
			"mov oc, v0\n";
			loadShaders(vertexShaderSrc, fragmentShaderSrc);
			setProgram();
			addEventListener(Event.ENTER_FRAME, render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.A:
					_rotateM.appendRotation(1, new PswVector3D(1, 0, 0));
					break;
				case Keyboard.W:
					_rotateM.appendRotation(1, new PswVector3D(0, 0, 1));
					break;
				case Keyboard.D:
					_rotateM.appendRotation(-1, new PswVector3D(1, 0, 0));
					break;
				case Keyboard.S:
					_rotateM.appendRotation(-1, new PswVector3D(0, 0, 1));
					break;
				case Keyboard.Z:
					_rotateM.appendRotation(1, new PswVector3D(0, 1, 0));
					break;
				case Keyboard.X:
					_rotateM.appendRotation(-1, new PswVector3D(0, 1, 0));
					break;
			}
			
			trace(_rotateM)
			
			_camera.position = _rotateM.vectorMultiply(_camera.position);
			//trace(_camera.position,_camera.position.length)
			_camera.lookAt(new PswVector3D(0, 0, 0, 1))
			//trace(_camera.viewProjectioin)
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _camera.viewProjectioin.toMatrix3D(), false);
		}
		
		private function render(e:Event):void 
		{
			_context3D.clear(0, 0, 0, 1);
			_context3D.drawTriangles(_indexBuffer);
			_context3D.present();
		}
	}

}
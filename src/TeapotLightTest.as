package  
{
	import camera.lens.PerspectiveLens;
	import camera.PswCamera;
	import flash.display.MovieClip;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import geom.RawConst;
	import light.PswLight;
	import utils.math.PswMatrix3D;
	import utils.math.PswVector3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class TeapotLightTest extends TestBase 
	{
		private var _light:PswLight = new PswLight();
		private var _camera:PswCamera;
		private var _cPos:PswVector3D;
		private var _rotateM:PswMatrix3D;
		private var _translateM:PswMatrix3D;
		
		public function TeapotLightTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);

			var lens:PerspectiveLens = new PerspectiveLens();
			lens.fov = 1.0;
			lens.zNear = 1;
			lens.zFar = 1000;
			lens.xyRatio = stage.stageWidth / stage.stageHeight;
			_camera = new PswCamera(lens);
			_cPos = new PswVector3D(40, 40, 40,1);
			_camera.position = _cPos;
			_camera.lookAt(new PswVector3D(0, 0, 0, 1))
			
			_numVertex = RawConst.teapotVertex.length / 6;
			_numIndex = RawConst.teapotIndex.length;
			_data32PerVertex = 6;
			_light.pos = new PswVector3D(0, 0, 50)
			

			createContex();
		}
		
		override protected function load():void
		{
			loadVertexBuffer(RawConst.teapotVertex);
			loadIndexBuffer(RawConst.teapotIndex);
			setVertexBufferAt(0, 0, "float3");
			setVertexBufferAt(1, 3, "float3");//normal
			//setVertexBufferAt(2, 9, "float3");//material
			//setVertexBufferAt(2, 9, "float3");
			//return;
			
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _camera.viewProjectioin.toMatrix3D(), false);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 4, _light.ambient);
			//return;
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 5, _light.diffuse);
			
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 6, _light.specular);
			
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 7, _light.pos.toVector());
			
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 8, Vector.<Number>([0, 0, 0, 0]));
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 9, _camera.position.toVector());
			
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 10, Vector.<Number>([0.1, 0.2, 0.6, 1]));
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 11, Vector.<Number>([1, 1, -1, 1]));
			
			//return;
			_rotateM = new PswMatrix3D();
			_translateM = new PswMatrix3D();
			
			_context3D.setCulling(Context3DTriangleFace.FRONT);
			var vertexShaderSrc:String = 
			//"m44 vt0,va0,vc4\n" +
			//"m44 vt2 ,vt0,vc8\n"+
			"m44 vt0 ,va0,vc0\n" +//rotate vertex
			"mov op,vt0\n" +//+//output 
			"mov v0,vt0\n" +// +
			"m44 v1, va1,vc0\n";//rotate normal
			//"mul vt0,vt7,vc4\n" +//ambient
			//"sub vt2,vc7,vt1\n" +//从顶点指向光源的矢量L
			//"nrm vt2.xyz,vt2.xyz\n" +
			//"mov vt5,vt2\n"+
			//"dp3 vt2.z,vt2,vt3\n" +// L·M
			//"max vt2.z,vt2.z,vc8.z\n" +
			//"mul vt2,vt2.z,vc5\n" +
			//"mul vt4,vt3,vt2.z\n" +
			//"add vt0,vt0,vt2\n" +//diffuse
			//"add vt4,vt4,vt4\n" +
			//"sub vt4,vt4,vt5\n" +
			//"sub vt1,vc9,vt1\n" +
			//"nrm vt1.xyz,vt1.xyz\n"+
			//"dp3 vt1.w,vc6,vt1\n" +
			//"max vt1.w,vt1.w,vc8.z\n"+
			//"mul vt1,vt1.w,vt7\n"+
			//"mul vt1,vt1,vc6\n" +
			//"add vt0,vt1,vt0\n"+
			//"dp3 vt2,vt2,vc5\n" +//diffuse
			//"add vt0,vt0,vt2\n" + //ambient + diffuse
			//""+
			//"mov v0,vt0\n";
			var fragmentShaderSrc:String =
			"mov ft1,fc10\n"+//color
			"mul ft1,ft1,fc4\n" +//ambient
			"sub ft2,fc7,v0\n" + //L   
			"nrm ft2.xyz,ft2\n" + //L nrm
			"mul ft4,v1,fc11\n"+ // inverse z of normal
			"dp3 ft3,ft2,ft4\n" + //L · N
			//specular
			//"mul ft5,ft3,ft4\n" + //(L · N)N
			//"add ft5,ft5,ft5\n" + //2(L · N)N
			//"sub ft5,ft5,ft2\n" + //R=2(L · N)N-L
			//"sub ft6,fc9,v0\n" + // V
			//"nrm ft6.xyz,ft6\n"+ // V
			//"dp3 ft5,ft5,ft6\n" +//R · V
			//"max ft5,ft5,fc8\n"+
			//"mul ft5,ft5,fc6\n" + //k （R · V）
			//"mul ft5,ft5,fc10\n" +
			//"add ft1,ft1,ft5\n" +
			
			"max ft3,ft3,fc8\n"+
			"mul ft3,ft4,ft2\n" +
			"mul ft3,ft3,fc5\n" +
			"mul ft3,ft3,fc10\n"+
			"add ft1,ft1,ft3\n" +
			
			//"mov ft1,ft5\n"+
			"mov oc, ft1\n";
			loadShaders(vertexShaderSrc, fragmentShaderSrc);
			setProgram();
			addEventListener(Event.ENTER_FRAME, render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			 _rotateM.identity();
			//trace(Keyboard.W,e.keyCode)
			switch(e.keyCode)
			{
				
				case Keyboard.A:
					_rotateM.appendRotation(.1, new PswVector3D(1, 0, 0));
					break;
				case Keyboard.W:
					_rotateM.appendRotation(.1, new PswVector3D(0, 0, 1));
					break;
				case Keyboard.D:
					_rotateM.appendRotation(-.1, new PswVector3D(1, 0, 0));
					break;
				case Keyboard.S:
					_rotateM.appendRotation(-.1, new PswVector3D(0, 0, 1));
					break;
				case Keyboard.Z:
					_rotateM.appendRotation(.1, new PswVector3D(0, 1, 0));
					break;
				case Keyboard.X:
					_rotateM.appendRotation(-0.1, new PswVector3D(0, 1, 0));
					break;
				case Keyboard.UP:
					_light.pos.z+=6;
					break;
				case Keyboard.DOWN:
					_light.pos.z-=6;
					break;
				case Keyboard.LEFT:
					_light.pos.x-=6;
					break;
				case Keyboard.RIGHT:
					_light.pos.x+=6;
					break;
				case Keyboard.C:
					_light.pos.y-=6;
					break;
				case Keyboard.V:
					_light.pos.y+=6;
					break;
			}
			//trace(_camera.viewProjectioin.toMatrix3D().rawData);
			//trace(_rotateM)
			_camera.position = _rotateM.vectorMultiply(_camera.position);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 9, _camera.position.toVector());
			//trace(_camera.position, _camera.position.length,"_camera.position")
			//trace(_rotateM)
			_camera.lookAt(new PswVector3D(0, 0, 0, 1))
			//trace(_camera.viewProjectioin)
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _camera.viewProjectioin.toMatrix3D(), false);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 7, _light.pos.toVector());
		}
		
		private function render(e:Event):void 
		{
			_rotateM.identity();
			_rotateM.appendRotation(0.05, new PswVector3D(0, 1, 0));
			_camera.position = _rotateM.vectorMultiply(_camera.position);
			_camera.lookAt(new PswVector3D(0, 0, 0, 1))
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _camera.viewProjectioin.toMatrix3D(), false);
			//trace(_camera.position,_camera.position.length)
			
			_context3D.clear(0, 0, 0, 1);
			_context3D.drawTriangles(_indexBuffer);
			_context3D.present();
		}
	}

}
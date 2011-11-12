package  
{
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import geom.RawConst;
	/**
	 * ...
	 * @author Physwf
	 */
	public class ModelTransformationTest extends TestBase 
	{
		private var rotaionM:Matrix3D;
		private var translateM:Matrix3D;
		private var perspectiveM:PerspectiveMatrix3D;
		
		public function ModelTransformationTest() 
		{
			_numVertex = 24; _numIndex = 42; _data32PerVertex = 6;
			rotaionM = new Matrix3D();
			translateM = new Matrix3D();
			translateM.prependTranslation(0, 0, 15);
			perspectiveM = new PerspectiveMatrix3D();
			perspectiveM.perspectiveFieldOfViewLH(0.7,4/3,-5,100);
			_callBack = callBack;
			createContex();
		}
		
		private function callBack():void
		{
			loadVertexBuffer(RawConst.cubeVertexColor);
			loadIndexBuffer(RawConst.cubeIndex);
			
			setVertexBufferAt(0, 3, "float3");
			setVertexBufferAt(1, 3, "float3");
			
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, rotaionM, true);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, translateM, true);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, perspectiveM, true);
			
			_context3D.setCulling(Context3DTriangleFace.FRONT);
			var vertexShaderSrc:String =
			"m44 vt0,va0,vc0\n" +//ratation
			"m44 vt1,vt0,vc4\n" +//translation
			"m44 vt2,vt1,vc8\n" +//projection
			"mov op,vt2\n" +
			"mov v0,va1\n";
			var fragmentShaderSrc:String =
			"mov oc,v0\n";
			
			loadShaders(vertexShaderSrc, fragmentShaderSrc);
			
			setProgram();
			addEventListener(Event.ENTER_FRAME, render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch(e.keyCode)
			{
				case Keyboard.W:
					translateM.appendTranslation(0, 0, 1);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, translateM, true);
					break;
				case Keyboard.S:
					translateM.appendTranslation(0, 0, -1);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, translateM, true);
					break;
				case Keyboard.A:
					translateM.appendTranslation(1, 0, 0);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, translateM, true);
					break;
				case Keyboard.D:
					translateM.appendTranslation( -1, 0, 0);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, translateM, true);
					break;
				case Keyboard.UP:
					rotaionM.appendRotation(1, new Vector3D(1, 0, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, rotaionM, true);
					break;
				case Keyboard.DOWN:
					rotaionM.appendRotation( -1, new Vector3D(1, 0, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, rotaionM, true);
					break;
				case Keyboard.LEFT:
					rotaionM.appendRotation(1, new Vector3D(0, 1, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, rotaionM, true);
					break;
				case Keyboard.RIGHT:
					rotaionM.appendRotation( -1, new Vector3D(0, 1, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, rotaionM, true);
					break;
				
					
			}
			trace(e.keyCode);
		}
		
		private function render(e:Event):void 
		{
			_context3D.clear(0, 0, 0, 1);
			_context3D.drawTriangles(_indexBuffer,0, -1);
			_context3D.present();
			trace(1)
		}
		
	}

}
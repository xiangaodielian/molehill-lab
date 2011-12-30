package  
{
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display.Bitmap;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import geom.RawConst;
	/**
	 * ...
	 * @author Physwf
	 */
	public class EnviorementTeapotTextureTest extends TestBase 
	{
		private var _rotateM:Matrix3D;
		private var _translateM:Matrix3D;
		private var _perspectiveM:PerspectiveMatrix3D;
		
		[Embed(source = "texture/patio/cm_back0.jpg")]
		private var Back0:Class;
		[Embed(source = "texture/patio/cm_back1.jpg")]
		private var Back1:Class;
		[Embed(source = "texture/patio/cm_back2.jpg")]
		private var Back2:Class;
		[Embed(source = "texture/patio/cm_back3.jpg")]
		private var Back3:Class;
		[Embed(source = "texture/patio/cm_back4.jpg")] 
		private var Back4:Class;
		[Embed(source = "texture/patio/cm_back5.jpg")]
		private var Back5:Class;
		[Embed(source = "texture/patio/cm_back6.jpg")]
		private var Back6:Class;
		[Embed(source = "texture/patio/cm_back7.jpg")]
		private var Back7:Class;
		
		[Embed(source = "texture/patio/cm_bottom0.jpg")]
		private var Bottom0:Class;
		[Embed(source = "texture/patio/cm_bottom1.jpg")]
		private var Bottom1:Class;
		[Embed(source = "texture/patio/cm_bottom2.jpg")]
		private var Bottom2:Class;
		[Embed(source = "texture/patio/cm_bottom3.jpg")]
		private var Bottom3:Class;
		[Embed(source = "texture/patio/cm_bottom4.jpg")]
		private var Bottom4:Class;
		[Embed(source = "texture/patio/cm_bottom5.jpg")]
		private var Bottom5:Class;
		[Embed(source = "texture/patio/cm_bottom6.jpg")]
		private var Bottom6:Class;
		[Embed(source = "texture/patio/cm_bottom7.jpg")]
		private var Bottom7:Class;
		
		[Embed(source = "texture/patio/cm_front0.jpg")]
		private var Front0:Class;
		[Embed(source = "texture/patio/cm_front1.jpg")]
		private var Front1:Class;
		[Embed(source = "texture/patio/cm_front2.jpg")]
		private var Front2:Class;
		[Embed(source = "texture/patio/cm_front3.jpg")]
		private var Front3:Class;
		[Embed(source = "texture/patio/cm_front4.jpg")]
		private var Front4:Class;
		[Embed(source = "texture/patio/cm_front5.jpg")]
		private var Front5:Class;
		[Embed(source = "texture/patio/cm_front6.jpg")]
		private var Front6:Class;
		[Embed(source = "texture/patio/cm_front7.jpg")]
		private var Front7:Class;
		
		[Embed(source = "texture/patio/cm_left0.jpg")]
		private var Left0:Class;
		[Embed(source = "texture/patio/cm_left1.jpg")]
		private var Left1:Class;
		[Embed(source = "texture/patio/cm_left2.jpg")]
		private var Left2:Class;
		[Embed(source = "texture/patio/cm_left3.jpg")]
		private var Left3:Class;
		[Embed(source = "texture/patio/cm_left4.jpg")]
		private var Left4:Class;
		[Embed(source = "texture/patio/cm_left5.jpg")]
		private var Left5:Class;
		[Embed(source = "texture/patio/cm_left6.jpg")]
		private var Left6:Class;
		[Embed(source = "texture/patio/cm_left7.jpg")]
		private var Left7:Class;
		
		[Embed(source = "texture/patio/cm_right0.jpg")]
		private var Right0:Class;
		[Embed(source = "texture/patio/cm_right1.jpg")]
		private var Right1:Class;
		[Embed(source = "texture/patio/cm_right2.jpg")]
		private var Right2:Class;
		[Embed(source = "texture/patio/cm_right3.jpg")]
		private var Right3:Class;
		[Embed(source = "texture/patio/cm_right4.jpg")]
		private var Right4:Class;
		[Embed(source = "texture/patio/cm_right5.jpg")]
		private var Right5:Class;
		[Embed(source = "texture/patio/cm_right6.jpg")]
		private var Right6:Class;
		[Embed(source = "texture/patio/cm_right7.jpg")]
		private var Right7:Class;
		
		[Embed(source = "texture/patio/cm_top0.jpg")]
		private var Top0:Class;
		[Embed(source = "texture/patio/cm_top1.jpg")]
		private var Top1:Class;
		[Embed(source = "texture/patio/cm_top2.jpg")]
		private var Top2:Class;
		[Embed(source = "texture/patio/cm_top3.jpg")]
		private var Top3:Class;
		[Embed(source = "texture/patio/cm_top4.jpg")]
		private var Top4:Class;
		[Embed(source = "texture/patio/cm_top5.jpg")]
		private var Top5:Class;
		[Embed(source = "texture/patio/cm_top6.jpg")]
		private var Top6:Class;
		[Embed(source = "texture/patio/cm_top7.jpg")]
		private var Top7:Class;
		
		
		public function EnviorementTeapotTextureTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, addStage);
		}
		
		private function addStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addStage);
			_numVertex = RawConst.teapotVertex.length / 6;
			_numIndex = RawConst.teapotIndex.length;
			_cubeSize = 128;
			_data32PerVertex = 6;
			createContex();
		}
		
		override protected function load():void
		{
			loadVertexBuffer(RawConst.teapotVertex);
			setVertexBufferAt(0, 0, "float3");
			setVertexBufferAt(1, 3, "float3");
			loadIndexBuffer(RawConst.teapotIndex);
			
			_rotateM = new Matrix3D();
			_translateM = new Matrix3D();
			_perspectiveM = new PerspectiveMatrix3D();
			_perspectiveM.perspectiveFieldOfViewLH(Math.PI * .5, 4 / 3, -100, 1);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,_rotateM,true);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,4,_translateM,true);
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 8, _perspectiveM, true);
			
			_context3D.setCulling(Context3DTriangleFace.FRONT);
				
			loadCubeTexture((new Right0 as Bitmap).bitmapData, 1, 0); //+X
			loadCubeTexture((new Right1 as Bitmap).bitmapData, 1, 1);
			loadCubeTexture((new Right2 as Bitmap).bitmapData, 1, 2);
			loadCubeTexture((new Right3 as Bitmap).bitmapData, 1, 3);
			loadCubeTexture((new Right4 as Bitmap).bitmapData, 1, 4);
			loadCubeTexture((new Right5 as Bitmap).bitmapData, 1, 5);
			loadCubeTexture((new Right6 as Bitmap).bitmapData, 1, 6);
			loadCubeTexture((new Right7 as Bitmap).bitmapData, 1, 7);	
			
			loadCubeTexture((new Left0 as Bitmap).bitmapData, 0, 0); //-X
			loadCubeTexture((new Left1 as Bitmap).bitmapData, 0, 1);
			loadCubeTexture((new Left2 as Bitmap).bitmapData, 0, 2);
			loadCubeTexture((new Left3 as Bitmap).bitmapData, 0, 3);
			loadCubeTexture((new Left4 as Bitmap).bitmapData, 0, 4);
			loadCubeTexture((new Left5 as Bitmap).bitmapData, 0, 5);
			loadCubeTexture((new Left6 as Bitmap).bitmapData, 0, 6);
			loadCubeTexture((new Left7 as Bitmap).bitmapData, 0, 7);	
			
			loadCubeTexture((new Top0 as Bitmap).bitmapData, 2, 0); //+Y
			loadCubeTexture((new Top1 as Bitmap).bitmapData, 2, 1);
			loadCubeTexture((new Top2 as Bitmap).bitmapData, 2, 2);
			loadCubeTexture((new Top3 as Bitmap).bitmapData, 2, 3);
			loadCubeTexture((new Top4 as Bitmap).bitmapData, 2, 4);
			loadCubeTexture((new Top5 as Bitmap).bitmapData, 2, 5);
			loadCubeTexture((new Top6 as Bitmap).bitmapData, 2, 6);
			loadCubeTexture((new Top7 as Bitmap).bitmapData, 2, 7);	
			
			
			loadCubeTexture((new Bottom0 as Bitmap).bitmapData, 3, 0); //-Y
			loadCubeTexture((new Bottom1 as Bitmap).bitmapData, 3, 1);
			loadCubeTexture((new Bottom2 as Bitmap).bitmapData, 3, 2);
			loadCubeTexture((new Bottom3 as Bitmap).bitmapData, 3, 3);
			loadCubeTexture((new Bottom4 as Bitmap).bitmapData, 3, 4);
			loadCubeTexture((new Bottom5 as Bitmap).bitmapData, 3, 5);
			loadCubeTexture((new Bottom6 as Bitmap).bitmapData, 3, 6);
			loadCubeTexture((new Bottom7 as Bitmap).bitmapData, 3, 7);
			
			loadCubeTexture((new Back0 as Bitmap).bitmapData, 4, 0);  //+Z
			loadCubeTexture((new Back1 as Bitmap).bitmapData, 4, 1);
			loadCubeTexture((new Back2 as Bitmap).bitmapData, 4, 2);
			loadCubeTexture((new Back3 as Bitmap).bitmapData, 4, 3);
			loadCubeTexture((new Back4 as Bitmap).bitmapData, 4, 4);
			loadCubeTexture((new Back5 as Bitmap).bitmapData, 4, 5);
			loadCubeTexture((new Back6 as Bitmap).bitmapData, 4, 6);
			loadCubeTexture((new Back7 as Bitmap).bitmapData, 4, 7);
			
						
			loadCubeTexture((new Front0 as Bitmap).bitmapData, 5, 0); //-Z
			loadCubeTexture((new Front1 as Bitmap).bitmapData, 5, 1);
			loadCubeTexture((new Front2 as Bitmap).bitmapData, 5, 2);
			loadCubeTexture((new Front3 as Bitmap).bitmapData, 5, 3);
			loadCubeTexture((new Front4 as Bitmap).bitmapData, 5, 4);
			loadCubeTexture((new Front5 as Bitmap).bitmapData, 5, 5);
			loadCubeTexture((new Front6 as Bitmap).bitmapData, 5, 6);
			loadCubeTexture((new Front7 as Bitmap).bitmapData, 5, 7);	
			
			setCubeTextureAt(0);
			
			var vertexShaderSrc:String = 
			"m44 vt0,		va0,		vc0		\n" 	+
			"m44 vt1,		vt0,		vc4		\n" 	+
			"m44 vt2,		vt1,		vc8		\n" 	+
			"mov op,		vt2					\n"		+
			"m44 vt0,		va1,		vc0		\n" 	+	//旋转法向量
			//"nrm vt0.xyz,	vt0.xyz				\n" 	+	//归一化法向量
			//"neg vt1.xyz,	vt1.xyz				\n" 	+	//view向量取反
			//"nrm vt1.xyz,	vt1.xyz				\n" 	+	//view向量归一化
			//"dp3 vt6.z,		vt0,		vt1		\n" 	+	//法向量方向的分量大小
			//"mul vt7,		vt1,		vt6.z	\n"		+	//法向量方向的分量
			//"sub vt2,		vt1,		vt7		\n" 	+	//垂直于法向量方向的分量
			//"neg vt2,		vt2					\n" 	+	//垂直方向分量取反
			//"add vt0,		vt7,		vt2		\n"		+	//反射方向向量
			"nrm vt0.xyz,	vt0.xyz				\n" 	+	//归一化法向量
			"nrm vt1.xyz,	vt1.xyz				\n" 	+	//view向量归一化
			"dp3 vt2.x,		vt1,vt0				\n" +
			"mul vt3,		vt0,		vt2.x	\n" +
			"add vt4,		vt3,		vt3		\n" +
			"sub vt0,		vt1,		vt4		\n" +
			"mov v0,		vt0";
			var fragmentShaderSrc:String =
			"tex ft0,v0,fs0<cube,linear,mipnearest,clamp>\n" +
			"mov oc,ft0";
			
			loadShaders(vertexShaderSrc, fragmentShaderSrc);
			setProgram();
			addEventListener(Event.ENTER_FRAME,render);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.W: 
					_translateM.appendTranslation(0, 0, 1);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					trace(_translateM.rawData);
					break;
				case Keyboard.S: 
					_translateM.appendTranslation(0, 0, -1);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					trace(_translateM.rawData);
					break;
				case Keyboard.A: 
					_translateM.appendTranslation(-1, 0, 0);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					break;
				case Keyboard.D: 
					_translateM.appendTranslation(1, 0, 0);
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 4, _translateM, true);
					break;
				case Keyboard.UP: 
					_rotateM.appendRotation(2, new Vector3D(1, 0, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.DOWN: 
					_rotateM.appendRotation(-2, new Vector3D(1, 0, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.LEFT: 
					_rotateM.appendRotation(2, new Vector3D(0, 1, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
				case Keyboard.RIGHT: 
					_rotateM.appendRotation(-2, new Vector3D(0, 1, 0));
					_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, _rotateM, true);
					break;
			
			}
			trace(e.keyCode);
		}
		
		private function render(e:Event):void 
		{
			_context3D.clear(0, 0, 0, 1);
			_context3D.drawTriangles(_indexBuffer, 0, -1);
			_context3D.present();
		}
		
	}

}
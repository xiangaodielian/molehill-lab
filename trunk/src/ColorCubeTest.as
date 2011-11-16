package  
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	import flash.display3D.textures.CubeTexture;
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
	public class ColorCubeTest extends MovieClip 
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
		
		public function ColorCubeTest() 
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
			vertexBuffer=context3D.createVertexBuffer(24,6);
			//vertexBuffer=context3D.createVertexBuffer(32,6);
			indexBuffer=context3D.createIndexBuffer(36);
			
			var vertexData:Vector.<Number> = RawConst.cubeVertexColor;
			
			var indexData:Vector.<uint> = RawConst.cubeIndex;
			
			
			vertexBuffer.uploadFromVector(vertexData,0,24);
			
			
			indexBuffer.uploadFromVector(indexData,0,36);
			
			program=context3D.createProgram();
			var vertexAssembler:AGALMiniAssembler=new AGALMiniAssembler();
			var fragmAssembler:AGALMiniAssembler=new AGALMiniAssembler();
			var vertexSrc:String=
				"m44 vt0, va0, vc124\n" +
				"m44 op, vt0, vc4\n"+
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
			
			var pm:PerspectiveMatrix3D=new PerspectiveMatrix3D();
			pm.perspectiveFieldOfViewLH(0.7, 4/3,1, 100);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,4,pm,true);
			unitMatrix=new Matrix3D();
			unitMatrix.prependTranslation(0, 0,15);
			//unitMatrix.appendScale(0.5,0.5,0.5);
			context3D.setCulling(Context3DTriangleFace.BACK);
			
			context3D.setProgram(program);
			addEventListener(Event.ENTER_FRAME,render);
		}
		/**
		 * 
		 * @param e
		 * 
		 */
		private function render(e:Event):void
		{
			
			context3D.clear(0,0,0,1);
			unitMatrix.appendRotation(3,new Vector3D(0,1,0),new Vector3D(0,0,17));
			
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,124,unitMatrix,true);
			
			context3D.drawTriangles(indexBuffer,0,-1);
			context3D.present();
		}
	}

}
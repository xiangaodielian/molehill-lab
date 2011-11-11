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
			context3D.configureBackBuffer(800,600,8,true);
			
			vertexBuffer=context3D.createVertexBuffer(24,6);
			//vertexBuffer=context3D.createVertexBuffer(32,6);
			indexBuffer=context3D.createIndexBuffer(36);
			
			var vertexData:Vector.<Number> = RawConst.cubeVertex;
			
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
			var fragmSrc:String=
			"tex ft0,v0,fs0<cube,linear,clamp,mipnearest>\n" +
			"mov oc ,ft0\n";//"mov oc ,v0 \n";
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmAssembler.assemble(Context3DProgramType.FRAGMENT,fragmSrc);
			var flower:Bitmap = new Flower() as Bitmap;
			var flower1:Bitmap = new Flower1() as Bitmap;
			var flower2:Bitmap = new Flower2() as Bitmap;
			var flower3:Bitmap = new Flower3() as Bitmap;
			var flower4:Bitmap = new Flower4() as Bitmap;
			var flower5:Bitmap = new Flower5() as Bitmap;
			var flower6:Bitmap = new Flower6() as Bitmap;
			var flower7:Bitmap = new Flower7() as Bitmap;
			var flower8:Bitmap = new Flower8() as Bitmap;
			
			trace(getSize(texture))
			
			cubeTexture = context3D.createCubeTexture(256, Context3DTextureFormat.BGRA,true);
			//texture=context3D.createTexture(256,256,Context3DTextureFormat.BGRA,false);
			trace(getSize(texture))
			//texture.uploadFromBitmapData(flower.bitmapData,0);
			
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 0, 0);
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 1, 0);
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 2, 0);
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 3, 0);
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 4, 0);
			cubeTexture.uploadFromBitmapData(flower.bitmapData, 5, 0);
			
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 0, 1);
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 1, 1);
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 2, 1);
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 3, 1);
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 4, 1);
			cubeTexture.uploadFromBitmapData(flower1.bitmapData, 5, 1);
			
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 0, 2);
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 1, 2);
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 2, 2);
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 3, 2);
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 4, 2);
			cubeTexture.uploadFromBitmapData(flower2.bitmapData, 5, 2);
			
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 0, 3);
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 1, 3);
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 2, 3);
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 3, 3);
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 4, 3);
			cubeTexture.uploadFromBitmapData(flower3.bitmapData, 5, 3);
			
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 0, 4);
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 1, 4);
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 2, 4);
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 3, 4);
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 4, 4);
			cubeTexture.uploadFromBitmapData(flower4.bitmapData, 5, 4);
			
			
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 0, 5);
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 1, 5);
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 2, 5);
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 3, 5);
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 4, 5);
			cubeTexture.uploadFromBitmapData(flower5.bitmapData, 5, 5);
			
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 0, 6);
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 1, 6);
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 2, 6);
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 3, 6);
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 4, 6);
			cubeTexture.uploadFromBitmapData(flower6.bitmapData, 5, 6);			
			
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 0, 7);
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 1, 7);
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 2, 7);
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 3, 7);
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 4, 7);
			cubeTexture.uploadFromBitmapData(flower7.bitmapData, 5, 7);
			
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 0, 8);
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 1, 8);
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 2, 8);
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 3, 8);
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 4, 8);
			cubeTexture.uploadFromBitmapData(flower8.bitmapData, 5, 8);
			
			
			program.upload(vertexAssembler.agalcode,fragmAssembler.agalcode);
			
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_3);	
			context3D.setTextureAt(0,cubeTexture);
			
			var pm:PerspectiveMatrix3D=new PerspectiveMatrix3D();
			pm.perspectiveFieldOfViewLH(0.7, 4/3,0.1, 100);
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
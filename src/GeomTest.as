package  
{
	import flash.display.MovieClip;
	import flash.geom.Matrix3D;
	import utils.math.PswMatrix3D;
	import utils.math.PswVector3D;
	
	/**
	 * ...
	 * @author Physwf
	 */
	public class GeomTest extends MovieClip 
	{
		
		public function GeomTest() 
		{
			var Vx:PswVector3D=new PswVector3D(1, 0, 0);
			var Vy:PswVector3D=new PswVector3D(0, 1, 0);
			var Vz:PswVector3D = new PswVector3D(0, 0, 1);
			//trace(Vx.crossProduct(Vy));
			//trace(Vy.crossProduct(Vz));
			//trace(Vz.crossProduct(Vx));
			var a0:Number = 0;
			var a1:Number = 1;
			var a2:Number = 1;
			var a3:Number = 2;
			var a4:Number = 2;
			var a5:Number = 3;
			var a6:Number = 4;
			var a7:Number = 5;
			var a8:Number = 0;
			var a9:Number = 0;
			var a10:Number = 5;
			var a11:Number = 0;
			var a12:Number = 6;
			var a13:Number = 9;
			var a14:Number = 7;
			var a15:Number = 0;
			var m1:Matrix3D = new Matrix3D(Vector.<Number>([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15]));
			var m2:Matrix3D = new Matrix3D(Vector.<Number>([a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15]));
			var pm1:PswMatrix3D = new PswMatrix3D(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15);
			var pm2:PswMatrix3D = new PswMatrix3D(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15);
			m1.append(m2);
			pm1.preMultiply(pm2)
			trace(m1.rawData)
			trace(pm1)
		}
		
	}

}
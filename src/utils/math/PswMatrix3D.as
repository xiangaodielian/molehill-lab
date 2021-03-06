package utils.math 
{
	import flash.geom.Matrix3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswMatrix3D 
	{
		private var _rawData:Vector.<Number>;
		
		public var a0:Number;
		public var a1:Number;
		public var a2:Number;
		public var a3:Number;
		public var a4:Number;
		public var a5:Number;
		public var a6:Number;
		public var a7:Number;
		public var a8:Number;
		public var a9:Number;
		public var a10:Number;
		public var a11:Number;
		public var a12:Number;
		public var a13:Number;
		public var a14:Number;
		public var a15:Number;
		
		public function PswMatrix3D
		(
			a0:Number=1, a1:Number=0, a2:Number=0, a3:Number=0, a4:Number=0, a5:Number=1, a6:Number=0, a7:Number=0, 
			a8:Number=0,a9:Number=0, a10:Number=1, a11:Number=0, a12:Number=0,a13:Number=0,a14:Number=0,a15:Number=1
		) 
		{
			this.a0 = a0; this.a1 = a1; this.a2 = a2; this.a3 = a3; 
			this.a4 = a4; this.a5 = a5; this.a6 = a6;this.a7 = a7;
			this.a8 = a8; this.a9 = a9; this.a10 = a10; this.a11 = a11; 
			this.a12 = a12;this.a13 = a13; this.a14 = a14; this.a15 = a15;
		}
		
		public function get rawData():Vector.<Number>
		{
			return Vector.<Number>
			(
				[a0, a1, a2, a3,a4, a5, a6, a7,a8, a9, a10, a11,a12, a13, a14, a15]
			);
		}
		
		public function copyFromRawData(a0:Number, a1:Number, a2:Number, a3:Number,a4:Number, a5:Number, a6:Number, a7:Number,a8:Number, a9:Number, a10:Number, a11:Number,a12:Number, a13:Number, a14:Number, a15:Number):void
		{
			this.a0 = a0; 	this.a1 = a1; 	this.a2 = a2; 	this.a3 = a3; 
			this.a4 = a4; 	this.a5 = a5; 	this.a6 = a6;	this.a7 = a7;
			this.a8 = a8; 	this.a9 = a9; 	this.a10 = a10; this.a11 = a11; 
			this.a12 = a12;	this.a13 = a13; this.a14 = a14; this.a15 = a15;
		}
		
		public function get determinant():Number
		{
			return (a0 * a5 * a10 * a15) + (a1 * a6 * a11 * a12) + (a2 * a7 * a8 * a13) + (a3 * a4 * a9 * a14) - (a3 * a6 * a9 * a12) + (a2 * a5 * a8 * a15) + (a1 * a4 * a11 * a14) + (a0 * a13 * a10 * a7);
		}
		
		public function preMultiply(m:PswMatrix3D):void
		{
			copyFromRawData
			(
				a0 *  m.a0 + a1 *  m.a4 + a2 *  m.a8 + a3 *  m.a12, 	a0 *  m.a1 + a1 *  m.a5 + a2 *  m.a9 + a3 *  m.a13, 	a0 *  m.a2 + a1 *  m.a6 + a2 *  m.a10 + a3 *  m.a14, 	a0 *  m.a3 + a1 *  m.a7 + a2 *  m.a11 + a3 *  m.a15,
				a4 *  m.a0 + a5 *  m.a4 + a6 *  m.a8 + a7 *  m.a12, 	a4 *  m.a1 + a5 *  m.a5 + a6 *  m.a9 + a7 *  m.a13, 	a4 *  m.a2 + a5 *  m.a6 + a6 *  m.a10 + a7 *  m.a14, 	a4 *  m.a3 + a5 *  m.a7 + a6 *  m.a11 + a7 *  m.a15,
				a8 *  m.a0 + a9 *  m.a4 + a10 * m.a8 + a11 * m.a12,		a8 *  m.a1 + a9 *  m.a5 + a10 * m.a9 + a11 * m.a13,		a8 *  m.a2 + a9 *  m.a6 + a10 * m.a10 + a11 * m.a14,	a8 *  m.a3 + a9 *  m.a7 + a10 * m.a11 + a11 * m.a15,
				a12 * m.a0 + a13 * m.a4 + a14 * m.a8 + a15 * m.a12,		a12 * m.a1 + a13 * m.a5 + a14 * m.a9 + a15 * m.a13,		a12 * m.a2 + a13 * m.a6 + a14 * m.a10 + a15 * m.a14, 	a12 * m.a3 + a13 * m.a7 + a14 * m.a11 + a15 * m.a15
			);
		}
		
		public function backMultiply(m:PswMatrix3D):void
		{
			
		}
		
		public function vectorMultiply(m:PswVector3D):PswVector3D
		{
			return new PswVector3D
			(
			a0 * m.x + a1 * m.y + a2 * m.z + a3 * m.w ,
			a4 * m.x + a5 * m.y + a6 * m.z + a7 * m.w ,
			a8 * m.x + a9 * m.y + a10 * m.z + a11 * m.w ,
			a12 * m.x + a13 * m.y + a14 * m.z + a15 * m.w 
			);
		}
		
		public function appendRotation(digree:Number,axis:PswVector3D,pivotPoint:PswVector3D=null):void
		{
			pivotPoint ||= new PswVector3D();
			var cos:Number = Math.cos(digree);
			var sin:Number = Math.sin(digree);
			var x:Number = axis.x;
			var y:Number = axis.y;
			var z:Number = axis.z;
			var tempM:PswMatrix3D = new PswMatrix3D();
			
			tempM.a0 = cos +(1 - cos) * x * x;
			tempM.a1 = (1 - cos) * x * y -z * sin;
			tempM.a2 = (1 - cos) * x * z + y * sin;
			tempM.a3 = pivotPoint.x;
			tempM.a4 = (1 - cos) * x * y + z * sin;
			tempM.a5 = cos +(1 - cos) * y * y;
			tempM.a6 = (1 - cos) * y * z -x * sin;
			tempM.a7 = pivotPoint.y;
			tempM.a8 = (1 - cos) * x * z - y * sin;
			tempM.a9 = (1 - cos) * y * z + x * sin;
			tempM.a10 = cos + (1 - cos) * z * z;
			tempM.a11 = pivotPoint.z;
			tempM.a12 = 0;
			tempM.a13 = 0;
			tempM.a14 = 0;
			tempM.a15 = 1;
			preMultiply(tempM);
		}
		
		public function scale(xScale:Number, yScale:Number, zScale:Number):void
		{
			
		}
		
		public function translate(x:Number, y:Number, z:Number):void
		{
			
		}
		
		public function clone():PswMatrix3D
		{
			return new PswMatrix3D(a0, a1, a2, a3,a4, a5, a6, a7,a8, a9, a10, a11,a12, a13, a14, a15);
		}
		
		public function identity():void
		{
			a0 = 1; 	a1 = 0; 	a2 = 0; 	a3 = 0; 
			a4 = 0; 	a5 = 1; 	a6 = 0;		a7 = 0;
			a8 = 0; 	a9 = 0; 	a10 = 1; 	a11 = 0; 
			a12 = 0;	a13 = 0; 	a14 = 0; 	a15 = 1;
		}
		
		public function invert():void
		{
			
		}
		
		public function transpose():void
		{
			
		}
		
		public function toMatrix3D():Matrix3D
		{
			return new Matrix3D(Vector.<Number>([a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15]));
		}
		
		public function toString():String
		{
			return "[\n"+
			a0 + "," + a1 + "," + a2 + "," + a3 + ",\n" +
			a4 + "," + a5 + "," + a6 + "," + a7 + ",\n" +
			a8 + "," + a9 + "," + a10 + "," + a11 + ",\n" +
			a12 + "," + a13 + "," + a14 + "," + a15 + ",\n" +
			"]";
		}
		
	}

}
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
			(a0 * a5 * a10 * a15) + (a1 * a6 * a11 * a12) + (a2 * a7 * a8 * a13) + (a3 * a4 * a9 * a14) -
			(a3 * a6 * a9 * a12) + (a2 * a5 * a8 * a15) + (a1 * a4 * a11 * a14) + (a0 * a13 * a10 * a7);
		}
		
		public function matrixMultiply(m:PswMatrix3D):void
		{
			
		}
		
		public function vectorMultiply(m:PswVector3D):PswVector3D
		{
			
		}
		
		public function rotate():void
		{
			
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
		
	}

}
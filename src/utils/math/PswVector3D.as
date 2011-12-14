package utils.math 
{
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswVector3D 
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var w:Number;
		
		public function PswVector3D(x:Number = 0., y:Number = 0., z:Number = 0., w:Number = 0.) 
		{
			this.x = x; this.y = y; this.z = z; this.w = w;
		}
		
		public function get length():Number
		{
			return Math.sqrt(x * x + y * y +z * z);
		}
		
		public function get lengthSquared():Number
		{
			return x * x + y * y +z * z;
		}
		
		public function add(v:PswVector3D):PswVector3D
		{
			return new PswVector3D(x + v.x, y + v.y, z + v.z);
		}
		
		public static function angleBetween(v1:PswVector3D,v2:PswVector3D):Number
		{
			return Math.acos(v1.x * v2.x+ v1.y * v2.y+v1.z * v2.z);
		}
		
		public function copyFrom(source:PswVector3D):void
		{
			x = source.x; y = source.y; z = source.z;
		}
		
		public function crossProduct(a:PswVector3D):PswVector3D 
		{
			return new PswVector3D
			(
			y * a.z -z * a.y, 
			z * a.x - x * a.z,
			x * a.y - y * a.z
			);
		}
		
		public function decrementBy(a:PswVector3D):void
		{
			x -= a.x; y -= a.y; z -= a.z;
		}
		
		public static function distance(a:PswVector3D, b:PswVector3D):Number
		{
			return a.subtract(b).length;
		}
		
		public function dotProduct(a:PswVector3D):Number
		{
			return x * a.x + y * a.y + z * a.z;
		}
		
		public function equals(toCompare:PswVector3D,allFour:Boolean=false):Boolean
		{
			return allFour
				? (x == toCompare.x) && (y == toCompare.y) && (z == toCompare.z) && (w == toCompare.w)
				: (x == toCompare.x) && (y == toCompare.y) && (z == toCompare.z);
		}
		
		public function incrementBy(a:PswVector3D):void
		{
			x += a.x; y += a.y; z += a.z;
		}
		
		public function nearEquarls(toCompare:PswVector3D, tolerance:Number, allFour:Boolean = false):Boolean
		{
			return false;
		}
		
		public function negate():void
		{
			x = -x; y = -y; z = -z;
		}
		
		public function normalize():void
		{
			var len:Number = length;
			x = x / len;
			y = y / len;
			z = z / len;
		}
		
		public function project():void
		{
			
		}
		
		public  function scaleBy(s:Number):void
		{
			
		}
		
		public function setTo(xa:Number, ya:Number, za:Number):void
		{
			x = xa; y = ya; z = za;
		}
		
		public function subtract(a:PswVector3D):PswVector3D
		{
			return new PswVector3D(x - a.x, y - a.y, z - a.z);
		}
		
		public function toString():String 
		{
			return "[x=" + x + ",y=" + y + ",z=" + z + ",w=" + w + "]";
		}
	}

}
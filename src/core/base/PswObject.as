package core.base 
{
	import flash.events.EventDispatcher;
	import utils.math.*;
	
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswObject extends EventDispatcher 
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _z:Number = 0;
		protected var _pos:PswVector3D = new PswVector3D();
		
		private var _transform:PswMatrix3D = new PswMatrix3D();
		private var _transformDirty:Boolean = false;
		
		public function PswObject() 
		{
			
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			if (_x == value) return;
			_x = value;
			_transformDirty = true;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
			if (_y == value) return;
			_transformDirty = true;
		}
		
		public function get z():Number 
		{
			return _z;
		}
		
		public function set z(value:Number):void 
		{
			if (_z == value) return;
			_z = value;
			_transformDirty = true;
		}
		
		public function get transform():PswMatrix3D 
		{
			if (_transformDirty) updateTransform();
			return _transform;
		}
		
		
		public function set transform(value:PswMatrix3D):void 
		{
			_transform = value;
		}
		
		public function get position():PswVector3D
		{
			_pos.x = _transform.a3;
			_pos.y = _transform.a7;
			_pos.y = _transform.a11;
			return _pos;
		}
		
		public function lookAt(target:PswVector3D,upAxis:PswVector3D):void
		{
			var xAxis:PswVector3D, yAxis:PswVector3D, zAxis:PswVector3D;
			
			zAxis = target.subtract(position);
			zAxis.normalize();
			
			upAxis ||= new PswVector3D(0, 1, 0);
			upAxis.normalize();
			
			xAxis = upAxis.crossProduct(zAxis);
			yAxis = zAxis.crossProduct(xAxis);
			_transform.copyFromRawData
			(
				xAxis.x, xAxis.y, xAxis.z, 0,
				yAxis.x, yAxis.y, yAxis.z, 0,
				zAxis.x, zAxis.y, zAxis.z, 0,
				0,0,0,1
			);
		}
		
		private function updateTransform():void 
		{
			
		}
			
		
	}

}
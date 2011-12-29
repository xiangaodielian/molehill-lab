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
		
		private var _rotationX:Number = 0;
		private var _rotationY:Number = 0;
		private var _rotationZ:Number = 0;
		private var _rotatationValueDirty:Boolean = false;//当transform改变时，标记为true
		
		private var _pivotPoint:PswVector3D = new PswVector3D();
		private var _pivotZero:Boolean = true;//当pivotPoint分量都为0时标记为true
		
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
		
		public function get rotationX():Number 
		{
			return _rotationX;
		}
		
		public function set rotationX(value:Number):void 
		{
			_rotationX = value;
		}
		
		public function get rotationY():Number 
		{
			return _rotationY;
		}
		
		public function set rotationY(value:Number):void 
		{
			_rotationY = value;
		}
		
		public function get rotationZ():Number 
		{
			return _rotationZ;
		}
		
		public function set rotationZ(value:Number):void 
		{
			_rotationZ = value;
		}
		
		public function get pivotPoint():PswVector3D 
		{
			return _pivotPoint;
		}
		
		public function set pivotPoint(value:PswVector3D):void 
		{
			_pivotPoint = value;
			_pivotZero = (_pivotPoint.x == 0 && _pivotPoint.y == 0 && _pivotPoint.z == 0);
			_transformDirty = true;
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
			if (_rotatationValueDirty) updateTransformValue();
		}
			
		private function updateTransformValue():void
		{
			
		}
	}

}
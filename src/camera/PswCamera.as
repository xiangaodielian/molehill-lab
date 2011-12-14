package camera 
{
	import camera.lens.LensBase;
	import camera.lens.PerspectiveLens;
	import utils.math.PswMatrix3D;
	import utils.math.PswVector3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswCamera 
	{
		private var _pos:PswVector3D;
		private var _direction:PswVector3D;
		private var _lens:LensBase;
		private var _viewProjection:PswMatrix3D;
		private var _isDirty:Boolean = true;
		private var _rotationMatrix:PswMatrix3D;
		private var _translateMatrix:PswMatrix3D;
		
		public function PswCamera(lens:LensBase=null) 
		{
			_pos = new PswVector3D(0,0,0,1);
			_direction = new PswVector3D(0, 0, 1);
			_lens = lens || new PerspectiveLens();
			_rotationMatrix = new PswMatrix3D();
			_translateMatrix = new PswMatrix3D();
			_viewProjection = lens.pswMatrix.clone();
		}

		public function get position():PswVector3D
		{
			return _pos;
		}
		
		public function set position(v:PswVector3D):void
		{
			_pos = v;
			_isDirty = true;
		}
		
		public function get x():Number
		{
			return _pos.x;
		}
		
		public function set x(v:Number):void
		{
			_pos.x = v;
			_isDirty = true;
		}
		
		public function set y(v:Number):void
		{
			_pos.y = v;
			_isDirty = true;
		}
		
		public function set z(v:Number):void
		{
			_pos.z = v;
			_isDirty = true;
		}
		
		public function get y():Number
		{
			return _pos.y;
		}
		
		public function get z():Number
		{
			return _pos.z;
		}
		
		public function get direction():PswVector3D
		{
			return _direction;
		}
		
		public function set direction(v:PswVector3D):void
		{
			_direction = v;
			_isDirty = true;
		}
		
		public function get lens():LensBase
		{
			return _lens;
		}
		
		public function set lens(v:LensBase):void
		{
			_lens = v;
			_viewProjection = _lens.pswMatrix.clone();
			_isDirty = true;
		}
		
		public function lookAt(p:PswVector3D,upAxis:PswVector3D=null):void
		{
			var direc:PswVector3D = p.subtract(_pos);
			direc.normalize();
			_direction = direc;
			
			upAxis ||= new  PswVector3D(0, 1, 0);
			var xAxis:PswVector3D = _direction.crossProduct(upAxis);
			var yAxis:PswVector3D = xAxis.crossProduct(_direction);
			var zAxis:PswVector3D = _direction;
			_rotationMatrix.copyFromRawData
			(
				xAxis.x, xAxis.y, xAxis.z, 0,
				yAxis.x, yAxis.y, yAxis.z, 0,
				zAxis.x, zAxis.y, zAxis.z, 0,
				0,0,0,1
			);
			_isDirty = true;
		}
		
		public function get viewProjectioin():PswMatrix3D
		{

			if (_isDirty)
			{
				_translateMatrix.copyFromRawData
				(
					1, 0, 0, -_pos.x,
					0, 1, 0, -_pos.y,
					0, 0, 1, -_pos.z,
					0, 0, 0, 1
				);
				_rotationMatrix.matrixMultiply(_translateMatrix);
				_viewProjection = _lens.pswMatrix.clone();
				_viewProjection.matrixMultiply(_rotationMatrix);
				_isDirty = false;
			}
			return _viewProjection;
		}
		
	}

}
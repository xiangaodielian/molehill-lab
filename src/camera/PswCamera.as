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
		private var _isDirty:Boolean = false;
		private var _rotationMatrix:PswMatrix3D;
		private var _translateMatrix:PswMatrix3D;
		
		public function PswCamera(lens:LensBase=null) 
		{
			_pos = new PswVector3D();
			_direction = new PswVector3D(0, 0, 1);
			_lens = lens || new PerspectiveLens();
			_rotationMatrix = new PswMatrix3D();
			_translateMatrix = new PswMatrix3D();
		}

		public function get position():PswMatrix3D
		{
			return _pos;
		}
		
		public function set position(v:PswVector3D):void
		{
			_pos = v;
		}
		
		public function get direction():PswVector3D
		{
			return _direction;
		}
		
		public function set direction(v:PswVector3D):void
		{
			_direction = v;
		}
		
		public function get lens():LensBase
		{
			return _lens;
		}
		
		public function set lens(v:LensBase):void
		{
			_lens = v;
		}
		
		public function get viewProjectioin():PswMatrix3D
		{
			var diX:Number,
				diY:Number,
				diZ:Number;
			var cos1:Number,
				sin1:Number,
				cos2:Number,
				sin2:Number;
			if (_isDirty)
			{
				diX = _direction.x; diY = _direction.y; diY = _direction.y;
				cos1 = diX / Math.sqrt(diX * diX +diZ * diZ);
				sin1 = diZ / Math.sqrt(diX * diX +diZ * diZ);
				cos2 = diZ / Math.sqrt(diY * diY +diZ * diZ);
				sin2 = diY / Math.sqrt(diY * diY +diZ * diZ);
				_rotationMatrix.copyFromRawData
				(
					cos1, 			0, 		sin1, 			0,
					- sin1 * sin2, 	cos2, 	sin2 * cos1, 	0,
					-cos2 * sin1, 	-sin2, 	cos2 * cos1, 	0,
					0,				0,		0,				1
				);
				_translateMatrix = new PswMatrix3D
				(
					1, 0, 0, -_pos.x,
					0, 1, 0, -_pos.y,
					0, 0, 1, -_pos.z,
					0, 0, 0, 1
				);
				_rotationMatrix.matrixMultiply(_translateMatrix);
				_viewProjection = _rotationMatrix;
			}
			return _viewProjection;
		}
		
		
		
		
	}

}
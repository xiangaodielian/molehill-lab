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
		
		public function lookAt(p:PswVector3D):void
		{
			var direc:PswVector3D = p.subtract(_pos);
			direc.normalize();
			_direction = direc;
			trace(_direction);
			_isDirty = true;
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
				diX = _direction.x; diY = _direction.y; diZ = _direction.z;
				cos1 = diZ / Math.sqrt(diX * diX +diZ * diZ);
				sin1 = diX / Math.sqrt(diX * diX +diZ * diZ);
				cos2 = diZ / Math.sqrt(diY * diY +diZ * diZ);
				sin2 = diY / Math.sqrt(diY * diY +diZ * diZ);
				_rotationMatrix.copyFromRawData
				(
					cos1 , 	-sin1 * sin2 , 	-sin1 * cos2,	0,
					0, 		cos2, 			-sin2, 			0,
					sin1, 	cos1 * sin2, 	cos1 * cos2, 	0,
					0,0,0,1
				);
				//trace("_rotationMatrix\n",_rotationMatrix.toString(),"\n_rotationMatrix");
		/*		(
					cos1, 			0, 		sin1, 			0,
					- sin1 * sin2, 	cos2, 	sin2 * cos1, 	0,
					-cos2 * sin1, 	-sin2, 	cos2 * cos1, 	0,
					0,				0,		0,				1
				);*/
				_translateMatrix.copyFromRawData
				(
					1, 0, 0, -_pos.x,
					0, 1, 0, -_pos.y,
					0, 0, 1, -_pos.z,
					0, 0, 0, 1
				);
				//trace("---------\n",_translateMatrix.toMatrix3D().rawData,"\n---------")
				_rotationMatrix.matrixMultiply(_translateMatrix);
				//trace("_translateMatrix\n",_translateMatrix,"_translateMatrix\n")
				_viewProjection = _lens.pswMatrix.clone();
				//trace("_lens.pswMatrix",_viewProjection,"_lens.pswMatrix")
				_viewProjection.matrixMultiply(_rotationMatrix);
				//trace("_viewProjection\n",_viewProjection,"_viewProjection\n")
				_isDirty = false;
			}
			return _viewProjection;
		}
		
	}

}
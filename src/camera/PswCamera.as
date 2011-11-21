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
		
		public function PswCamera(lens:LensBase=null) 
		{
			_pos = new PswVector3D();
			_direction = new PswVector3D(0, 0, 1);
			_lens = lens || new PerspectiveLens();
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
			if (_isDirty)
			{
				
			}
		}
		
		
		
		
	}

}
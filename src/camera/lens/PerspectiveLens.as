package camera.lens 
{
	import utils.math.PswMatrix3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PerspectiveLens extends LensBase 
	{
		private var _fov:Number;
		private var _Zp:Number;
		
		public function PerspectiveLens() 
		{
			_pswMatrix = new PswMatrix3D();
		}
		
		public function get fov():Number
		{
			return _fov;
		}
		
		public function set fov(v:Number):void
		{
			_fov = v;
			_Zp = 1 / Math.tan(_fov * .5);
			_isDirty = true;
		}
		
		override protected function updatePswMatrix():void
		{
			var temp:Number = 1 / (_zFar - _zNear);
			_pswMatrix.copyFromRawData
			(
				_Zp/_xyRatio, 	0, 		0, 				0,
				0, 				_Zp, 	0, 				0,
				0, 				0, 		_zFar * temp, 	-_zNear * _zFar *  temp,
				0, 				0, 		1, 				0
			);
		}
		
	}

}
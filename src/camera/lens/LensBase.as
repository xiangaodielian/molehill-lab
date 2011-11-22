package camera.lens 
{
	import utils.math.PswMatrix3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class LensBase 
	{
		protected var _zNear:Number=20;
		protected var _zFar:Number=3000;
		protected var _xyRatio:Number=1.0;
		
		protected var _pswMatrix:PswMatrix3D;
		protected var _isDirty:Boolean = false;
		
		public function LensBase() 
		{
			
		}
		
		public function get zNear():Number 
		{
			return _zNear;
		}
		public function set zNear(v:Number):void
		{
			_zNear = v;
			_isDirty = true;
		}
		
		public function get zFar():Number
		{
			return _zFar;
		}
		
		public function set zFar(v:Number):void
		{
			_zFar = v;
			_isDirty = true;
		}
		
		public function get xyRatio():Number
		{
			return _xyRatio;
		}
		
		public function set xyRatio(v:Number):void
		{
			_xyRatio = v;
			_isDirty = true;
		}
		
		public function get pswMatrix():PswMatrix3D
		{
			if (_isDirty) updatePswMatrix();
			_isDirty = false;
			trace(_pswMatrix.toMatrix3D().rawData,"_pswMatrix")
			return _pswMatrix;
			
		}
		
		protected function updatePswMatrix():void
		{
			throw new Error("Abstract method!!!");
		}
		
	}

}
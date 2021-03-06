package light
{
	import utils.math.PswVector3D;
	/**
	 * ...
	 * @author Physwf
	 */
	public class PswLight 
	{
		public var ambient:Vector.<Number>;
		public var diffuse:Vector.<Number>;
		public var specular:Vector.<Number>;
		
		public var pos:PswVector3D = new PswVector3D();;
		
		public function PswLight() 
		{
			ambient = Vector.<Number>([0.5,0.5,0.5,1.0]);
			diffuse = Vector.<Number>([0.5,0.5,0.5,1.0]);
			specular =Vector.<Number>([0.5,0.5,0.5,1.0]);
		}
		
	}

}
package  
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
			ambient = new Vector.<Number>([0.5,0.6,0.7,1]);
			diffuse = new Vector.<Number>([0.5,0.6,0.7,1]);
			specular = new Vector.<Number>([0.5,0.6,0.7,1]);
		}
		
	}

}
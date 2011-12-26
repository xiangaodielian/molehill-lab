package utils.math 
{
	/**
	 * 		
	 * 先介绍一下代数的概念,域F 上的一个矢量空间V 叫做域F 上的代数,如果除数乘、加法外还定
		义乘法,则运算满足以下关系:
		1) a ( b + c) = ab + bc , ( b + c) a = ba + ca ,
		Pa , b , c ∈V ;
		2) λ( ab) = (λa) b = a (λb) , Pa , b ∈V , Pλ∈
		F.
		　　如果V 是F 上的有限维空间,称V 为F 上的有限(维) 代数;如果乘法满足结合律, 即( ab) c = a
		( bc) ,称V 为结合代数;如果e ∈V ,使得ea = ae = a , Pa ∈V , 且对任意0 ≠a ∈V , 存在唯一的b ∈ V ,
		使得ab = ba = e ,称V 为可除代数.
			实数是一维结合代数, 复数是二维结合代数, 四元数是四维结合代数, 3 者都是可除代数.
	 * @author Physwf
	 */
	public class PswQuaternion 
	{
		public var a:Number = 1;
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		public function PswQuaternion(a:Number=1,x:Number=0,y:Number=0,z:Number=0) 
		{
			
		}
		/**
		 * 直乘：两个四元数的乘法按多项式乘法进行
		 * AB=
		 * @param	q
		 */
		public function directMultiply(q1:PswQuaternion, q2:PswQuaternion):void
		{
			var a1:Number = q1.a; var a2:Number = q2.a;
			var x1:Number = q1.x; var x2:Number = q2.x;
			var y1:Number = q1.y; var y2:Number = q2.y;
			var z1:Number = q1.z; var z2:Number = q2.z;
			
			a = a1 * a2 - x1 * x2 - y1 * y2 - z1 * z2;
			x = a2 * x1 + a1 * x2 + y1 * z1 - z1 * y2;
			y = a1 * y2 + a2 * y1 + z1 * x2 - x1 * z2;
			z = a1 * z2 + a2 * z1 + x1 * y2 - x2 * z1;
		}
		
		public function multiplyVector(vector : PswVector3D, target : PswQuaternion = null):PswQuaternion
		{
			target ||= new PswQuaternion();
			
			var x1:Number = vector.x;
			var y1:Number = vector.y;
			var z1:Number = vector.z;
			
			target.a = -x1 * x - y1 * y - z1 * z;
			target.x = a * x1 + y * z1 - z * y1;
			target.y = a * y1 + z * x1 - x * z1;
			target.z = a * z1 + x * y1 - y * x1;
			
			return target;
		}
	}

}
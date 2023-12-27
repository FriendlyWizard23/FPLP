class Rational(n: Int, d: Int) extends AnyRef {
	val num = n
	val den = d
	def this(n: Int) = this(n,1)
	def + (that: Rational):Rational = {
		new Rational(num*that.den + that.num*den, den*that.den)
	}

	def + (i:Int):Rational = {
		new Rational(num+i*den,den)
	}
	override def toString = ""+num+"/"+den
}

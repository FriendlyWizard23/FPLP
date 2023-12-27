class Functions{
	val is_palindrome = (s:String) => {
		val cleaned=s.filterNot(x=>List(',','.',';','?','!',' ').contains(x)).toLowerCase
		cleaned.equals(cleaned.reverse)
	} 
	val is_anagram = (s:String, dict:List[String]) => {
		dict
			.map(x=>x.toSeq.sorted.unwrap)
			.filter(x=>x.equals(s.toSeq.sorted.unwrap))
			.lengthIs > 1	
	}

	def factors(number:BigInt, start:BigInt=2, list:List[BigInt]=Nil):List[BigInt] = {
	LazyList
		.iterate(start)(i => i+1)
		.takeWhile(n => n<=number)
		.find(n=> number%n==0)
		.map(n=>factors(number/n,n , list :+ n))
		.getOrElse(list)

	}

	val is_perfect = (n:Int) =>{
		((2 until n).collect{
			case x if n%x==0 => x
		}).sum == (n-1)

	}
}


object Functions{
	def main(args: Array[String]):Unit={
		val fs = new Functions()
		List("Do geese see God?","itopinonavevanonipoti","Avanti Savoia")
			.map(x=>f"[is_palindrome] $x :- ${fs.is_palindrome(x)}\n")
			.foreach(print(_))
		val dict = List("ttoo","otot","oott","savoia","voiasa","asavoi","iovasa")
		List("otto","savoia","neverloseyoursmile")
			.map(x=>f"[is_anagram] $x :- ${fs.is_anagram(x,dict)}\n")
			.foreach(print(_))

		List(25,400,37,232)
			.map(x=>f"[factors] $x :- ${fs.factors(x)}\n")
			.foreach(print(_))

		List(25,6,7,10)
			.map(x=>f"[perfect] $x :- ${fs.is_perfect(x)}\n")
			.foreach(print(_))			
	}	
}

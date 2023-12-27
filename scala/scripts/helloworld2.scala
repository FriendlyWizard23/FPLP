object Upper{
	def upper(strings: String*) = strings.map(_.toUpperCase())
	def lower(strings: String*) = strings.map(_.toLowerCase())
}

println(Upper.upper("A","First","Scala","Problem"))
println(Upper.lower("A","FIRST","SCALA","PROBLEM"))

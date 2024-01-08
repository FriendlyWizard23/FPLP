import scala.util.parsing.combinator._
class Arithops(var longest:Int) extends JavaTokenParsers{
    def dottedLine="""[-]+\n""".r^^(_.toString)
    def finalLine=""".*""".r^^(_.toString)
    def numbers:Parser[Int] = """[0-9]+""".r^^{
        case n =>{
            if((n.length+1)>longest){
                longest=n.length+1
            }
            n.toInt
        }
    } 
    def inlineop:Parser[Int] = numbers~rep("+"~numbers|"-"~numbers)^^{
        case x ~ rest =>rest.foldLeft(x){
            case (left,"+"~right) => left+right
            case (left,"-"~right) => left-right
            case _ => throw new IllegalArgumentException("Error")
        }
    } 

    def main = (inlineop<~"=\n")~(dottedLine~>finalLine)^^{
        case e ~ line => {
            val ex=e
            val num = line.toInt
            if(num!=ex){
                println(s"Result is not valid. current result is $num but should be: $ex")
            }else{
                println("Ok")
            }   
        }
    }
}
object tester extends App{
    val a = new Arithops(0)
    val input = """
              1-
              2+
              3-
              4=
       ---------
            -2"""
    val res = a.parseAll(a.main,input)
    println(res)
}
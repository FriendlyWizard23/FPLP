import scala.util.parsing.combinator._
class Arithops(var longest:Int) extends JavaTokenParsers{
    def dottedLine="""[-]+\n""".r^^(_.toString)
    def finalLine=""".*""".r^^(_.toString)
    def numbers:Parser[()=>Int] = """[0-9]+""".r^^{
        case n => ()=>{
            if((n.length+1)>longest){
                longest=n.length+1
            }
            n.toInt
        }
    } 
    def inlineop:Parser[()=>Int] = numbers~("+"|"-")~inlineop^^{
        case e~"+"~o =>()=> e()+o()
        case e~"-"~o =>()=> e()-o()
        case _ => () => 0
    } | numbers
    /*def main = (inlineop<~"=")~dottedLine~numbers^^{
        case e ~ line ~ r => {
            if(r()!=e()){
                println("Result is not valid. Result should be: "+(e().toString))
            }else{
                if(line.length!=longest){
                    println(s"Result is Ok but dotted line should be long $longest yet is long "+line.length.toString)
                }else{
                    println("Ok")
                }
            }    
        }
    } */

    def main = (inlineop<~"=\n")~(dottedLine~>finalLine)^^{
        case e ~ line => {
            val ex=e()
            val num = line.toInt
            if(num!=e()){
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
            234=
       ---------
            -233"""
    val res = a.parseAll(a.main,input)
    println(res)
}
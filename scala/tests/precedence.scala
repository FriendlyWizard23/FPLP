import scala.util.parsing.combinator._

class Precedence() extends JavaTokenParsers{
    def sumsub = "+" | "-"
    def expression:Parser[Int] = term ~ rep("+"~term | "-"~term)^^{
        case t ~ rest => 
            print("EXPR: ");
            println(t)
            println(rest);
            rest.foldLeft(t){
                case(left,"+" ~right)=>left+right
                case(left,"-"~right)=>left-right
                case _ => 0
            }
    }
    def term:Parser[Int] = factor ~ rep("*"~factor | "/"~factor)^^{
        case t ~ rest => 
            rest.foldLeft(t){
                case(left, "*"~ right) => left*right
                case(left, "/"~ right) => left/right
                case _ => 0
            }
    }
    def factor:Parser[Int] = wholeNumber^^(_.toInt)
}

object test extends App{
    val p=new Precedence()
    val in="2+3*4*2*3+5"
    val r=p.parseAll(p.expression,in)
    println(r)
}
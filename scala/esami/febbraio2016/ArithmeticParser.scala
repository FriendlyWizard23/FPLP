
import scala.util.parsing.combinator._
import scala.collection.mutable._

class ArithmeticParser extends JavaTokenParsers{
    def program = leafExpression
    def term = """\d+""".r^^(_.toInt)
    def leafExpression = "("~>term~operation~term<~")" ^^ {
        case o1~"+"~o2 => o1+o2
        case o1~"-"~o2 => o1-o2
        case o1~"*"~o2 => o1*o2
        case o1~"/"~o2 => o1/o2
        case _ => 0
    }
    def operation= "+"|"-"|"*"|"/"
}

object Evaluator extends App{
    val ap = new ArithmeticParser()
    val test = "(3+4)"
    val res = ap.parseAll(ap.leafExpression,test)
    println(res)
}
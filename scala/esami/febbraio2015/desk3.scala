import scala.util.parsing.combinator._
import scala.collection.mutable._

class Desk3(var map:HashMap[Char,Int])extends JavaTokenParsers{

    def variable="""[a-z]""".r^^(_.charAt(0))
    def intValue = """\d""".r^^(_.toInt)
    def assignment = variable~("="~>intValue)^^{
        case k~v => map+=(k->v)
    }
    def expression:Parser[()=>Int] = (term|term2) ~ ("+"|"-") ~ expression ^^{
        case t ~ "+" ~ e => () => t()+e()
        case t ~ "-" ~ e => () => t()-e()
        case _ => () => 0.toInt
    } | term | term2
    def term:Parser[()=>Int]=variable^^{
        case v => () => map(v)
    } 
    def term2:Parser[()=>Int]=intValue^^{
        case v => () => v.toInt
    }
    def main="print"~>expression ~ ("where"~> repsep(assignment,","))^^{
        case e ~ a => println(e())
    }
}

object DeskTester extends App{
    val d = new Desk3(new HashMap())
    val input1="print x+y+z+4 where x=4,y=3,z=6"
    val test=d.parseAll(d.main,input1)
    println(test)
}
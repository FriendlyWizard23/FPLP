import scala.util.parsing.combinator._ 
import scala.collection.mutable._ 

class Desk (var map:HashMap[Char,Int])extends JavaTokenParsers{
    def value =  wholeNumber ^^ { _.toInt }
    def variable = ("""[a-z]""".r)^^{_.charAt(0)}
    
    def assignment = variable ~ ("=" ~> value) ^^ {
        case k ~ v => println(k);map+=(k->v)
    }
    def main = ("PRINT "~>expression<~"WHERE")~repsep(assignment,",") ^^ {
        case o ~ a => println(o())
    }

    def expression: Parser[()=>Int] = term ~ rep(("+"|"-") ~ term) ^^ {
    case t ~ lst => () => {
        lst.foldLeft(t()) {
            case (acc, "+" ~ next) => acc + next()
            case (acc, "-" ~ next) => acc - next()
        }
    }
    }| factor
    def factor:Parser[()=>Int] = (term ~ ("*"|"/") ~ factor) ^^ {
        _ match {
            case t~"*"~f => () => t()*f()
            case t~"/"~f => () => t()/f()
            case _ => () => 1
        }
    } | term | term2 

    def term: Parser[()=>Int] = variable ^^{
        case x => () => map(x)
    }

    def term2: Parser[()=>Int] = value ^^{
        case x => () => x.toInt
    }

}

object DeskTester extends App {

    val desk = new Desk(HashMap())
    val input3 = "PRINT x-y*y*z+2 WHERE x=2, y=1, z=3"
    val res = desk.parseAll(desk.main, input3)
    println(res)
  // Aggiungi altri test se necessario

}
import scala.util.parsing.combinator._
import scala.math._

class Arith extends JavaTokenParsers {
  def expr: Parser[Double] =
    term ~ rep("+" ~ term | "-" ~ term) ^^ {
      case x ~ rest => rest.foldLeft(x) {
        case (left, "+" ~ right) => left + right
        case (left, "-" ~ right) => left - right
        case _ => throw new IllegalArgumentException("Invalid syntax")
      }
    }

  def term: Parser[Double] =
    factor ~ rep("*" ~ factor | "/" ~ factor) ^^ {
      case x ~ rest => rest.foldLeft(x) {
        case (left, "*" ~ right) => left * right
        case (left, "/" ~ right) => left / right
        case _ => throw new IllegalArgumentException("Invalid syntax")
      }
    }

  def factor: Parser[Double] =
    floatingPointNumber ^^ (_.toDouble) |
      "pi" ^^ (_=>Pi) |
      "(" ~ expr ~ ")" ^^ { case "(" ~ e ~ ")" => e } |
      "cos(" ~ expr ~ ")" ^^ { 
        case "cos(" ~ e ~ ")" => math.cos(math.toRadians(e))
        case _ => throw new IllegalArgumentException("Invalid syntax for cos()")
        } |
      "sin(" ~ expr ~ ")" ^^ { 
        case "sin(" ~ e ~ ")" => math.sin(math.toRadians(e))
        case _ => throw new IllegalArgumentException("Invalid syntax for sin()")
        } |
      "tan(" ~ expr ~ ")" ^^ { 
        case "tan(" ~ e ~ ")" => math.tan(math.toRadians(e)) 
        case _ => throw new IllegalArgumentException("Invalid syntax for tan()")
        }
}

object ParseExpr extends Arith {
  def main(args: Array[String]): Unit = {
    println("input : " + args(0))
    val result = parseAll(expr, args(0))
    result match {
      case Success(value, _)  => println(s"parsed: $value")
      case _                  => println("parsing failed")
    }
  }
}

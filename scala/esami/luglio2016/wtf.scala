import scala.util.parsing.combinator._
import scala.collection.mutable._

  /*
        number ::= "[0-9]+"
        fun_name ::= "[A-Z]"
        args =:= number
        zero ::= "0"
        print ::= "!"
        arithops ::= "[+]+"|"[-]+"
        variable ::= "$" number

        stmt ::= zero | arithops | print | term_if
        stmts ::= (stmt)+

        fun ::= "def" fun_name args "=" fun_body
        fun_body =:= stmts
        fun_call ::= (variable) + fun_name

        term_if ::= "?" "[" body "]" ":" "[" body "]"
        funs ::= (fun)*
  */
trait Expr{}

case class Num(num:Int) extends Expr{}
case class Variable(variable:Int) extends Expr{}
case class Function(name:Character,args:Num,body:List[Expr]) extends Expr{}
case class Body(body:List[Any])extends Expr{}
case class Character(c:Char) extends Expr{}


class Wtf(var stack:Stack[Int], var functs:HashMap[Character,Function]) extends JavaTokenParsers{
  // MAIN SHIT
  def program = rep(sub | sum | function)

  // GENERAL PARSER
  def number = "[0-9]+".r^^{
    case v => Num(v.toInt)
  }
  def letter = "[A-Z]".r^^{
    case c => Character(c.charAt(0))
  }
  def zero = "[0]".r^^(_.toInt)
  def print = "!"
  def variable = "$"~>number ^^ {
    case v => v
  }

  // ARITH SHIT
  def arithops = sum | sub
  def plus = "[\\+]+".r
  def minus = "[\\-]+".r

  //STATEMENTS
  def stmt = arithops 
  def stmts = rep(stmt)
  
  // FUNCTIONS SHIT
  def args = number
  def fun_name = letter
  def fun_body = stmts
  def function = "def" ~> fun_name ~ args ~ ("="~>fun_body) ^^ {
    case fname ~ args ~ fbody => functs+=(fname->new Function(fname,args,fbody)); println(functs)
  }
  def sum = zero ~> plus ^^ {
    case p => Num(p.length)
  }
  def sub = zero ~> minus ^^ {
    case p => Num((p.length)*(-1))
  }

}

object ParserTester extends App {
  val input1 = 
    """
    0+++
    def A 5 = 0++ 0----- 0++ 0- 0++++
    def B 6 = 0++ 0++++
    """
  val parser = new Wtf(new Stack(),new HashMap())
  val res=parser.parseAll(parser.program, input1)
  println(res)
}
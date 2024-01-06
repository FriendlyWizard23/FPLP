file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
### java.lang.AssertionError: assertion failed

occurred in the presentation compiler.

action parameters:
uri: file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
text:
```scala
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
case class Variable(variable")
case class Function(name:Char,args:Int,body:Expr) extends Expr{}
class Wtf(var stack:Stack[Int], var functs:HashMap[Char,Function]) extends JavaTokenParsers{
  // MAIN SHIT
  def program = rep(sub | sum | function)

  // GENERAL PARSER
  def number = "[0-9]+".r^^(Num(_.toInt))
  def letter = "[A-Z]".r^^(_.charAt(0))
  def zero = "[0]".r^^(_.toInt)
  def print = "!"
  def variable = "$"~>number ^^ (_.toInt)

  // ARITH SHIT
  def arithops = arithops
  def plus = "[\\+]+".r
  def minus = "[\\-]+".r

  //STATEMENTS
  def stmt = sub | sum 
  def stmts = rep(stmt)
  
  // FUNCTIONS SHIT
  def args = number
  def fun_name = letter
  def fun_body = stmts
  def function = "def" ~> fun_name ~ args ~ ("="~>fun_body) ^^ {
    case fname ~ args ~ fbody => functs+=(fname->new Function(fname,args,fbody)); println(functs)
  }
  def sum = zero ~> plus ^^ {
    case p => p.length
  }
  def sub = zero ~> minus ^^ {
    case p => (p.length)*(-1)
  }

}

object ParserTester extends App {
  val input1 = 
    """
    def A 4 = 0++ 0-----
    """
  val parser = new Wtf(new Stack(),new HashMap())
  val res=parser.parseAll(parser.program, input1)
  println(res)
}
```



#### Error stacktrace:

```
scala.runtime.Scala3RunTime$.assertFailed(Scala3RunTime.scala:11)
	dotty.tools.dotc.parsing.Scanners$Scanner.lookahead(Scanners.scala:1083)
	dotty.tools.dotc.parsing.Parsers$Parser.termParamClause$$anonfun$1(Parsers.scala:3328)
	dotty.tools.dotc.parsing.Parsers$Parser.enclosed(Parsers.scala:556)
	dotty.tools.dotc.parsing.Parsers$Parser.inParens(Parsers.scala:558)
	dotty.tools.dotc.parsing.Parsers$Parser.termParamClause(Parsers.scala:3344)
	dotty.tools.dotc.parsing.Parsers$Parser.recur$6(Parsers.scala:3368)
	dotty.tools.dotc.parsing.Parsers$Parser.termParamClauses(Parsers.scala:3376)
	dotty.tools.dotc.parsing.Parsers$Parser.classConstr(Parsers.scala:3815)
	dotty.tools.dotc.parsing.Parsers$Parser.classDefRest(Parsers.scala:3806)
	dotty.tools.dotc.parsing.Parsers$Parser.classDef(Parsers.scala:3802)
	dotty.tools.dotc.parsing.Parsers$Parser.tmplDef(Parsers.scala:3780)
	dotty.tools.dotc.parsing.Parsers$Parser.defOrDcl(Parsers.scala:3561)
	dotty.tools.dotc.parsing.Parsers$Parser.topStatSeq(Parsers.scala:4163)
	dotty.tools.dotc.parsing.Parsers$Parser.topstats$1(Parsers.scala:4348)
	dotty.tools.dotc.parsing.Parsers$Parser.compilationUnit$$anonfun$1(Parsers.scala:4353)
	dotty.tools.dotc.parsing.Parsers$Parser.checkNoEscapingPlaceholders(Parsers.scala:500)
	dotty.tools.dotc.parsing.Parsers$Parser.compilationUnit(Parsers.scala:4358)
	dotty.tools.dotc.parsing.Parsers$Parser.parse(Parsers.scala:181)
	dotty.tools.dotc.parsing.Parser.parse$$anonfun$1(ParserPhase.scala:32)
	dotty.tools.dotc.parsing.Parser.parse$$anonfun$adapted$1(ParserPhase.scala:39)
	scala.Function0.apply$mcV$sp(Function0.scala:42)
	dotty.tools.dotc.core.Phases$Phase.monitor(Phases.scala:440)
	dotty.tools.dotc.parsing.Parser.parse(ParserPhase.scala:39)
	dotty.tools.dotc.parsing.Parser.runOn$$anonfun$1(ParserPhase.scala:48)
	scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
	scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
	scala.collection.immutable.List.foreach(List.scala:333)
	dotty.tools.dotc.parsing.Parser.runOn(ParserPhase.scala:48)
	dotty.tools.dotc.Run.runPhases$1$$anonfun$1(Run.scala:246)
	scala.runtime.function.JProcedure1.apply(JProcedure1.java:15)
	scala.runtime.function.JProcedure1.apply(JProcedure1.java:10)
	scala.collection.ArrayOps$.foreach$extension(ArrayOps.scala:1321)
	dotty.tools.dotc.Run.runPhases$1(Run.scala:262)
	dotty.tools.dotc.Run.compileUnits$$anonfun$1(Run.scala:270)
	dotty.tools.dotc.Run.compileUnits$$anonfun$adapted$1(Run.scala:279)
	dotty.tools.dotc.util.Stats$.maybeMonitored(Stats.scala:67)
	dotty.tools.dotc.Run.compileUnits(Run.scala:279)
	dotty.tools.dotc.Run.compileSources(Run.scala:194)
	dotty.tools.dotc.interactive.InteractiveDriver.run(InteractiveDriver.scala:165)
	scala.meta.internal.pc.MetalsDriver.run(MetalsDriver.scala:45)
	scala.meta.internal.pc.SemanticdbTextDocumentProvider.textDocument(SemanticdbTextDocumentProvider.scala:33)
	scala.meta.internal.pc.ScalaPresentationCompiler.semanticdbTextDocument$$anonfun$1(ScalaPresentationCompiler.scala:191)
```
#### Short summary: 

java.lang.AssertionError: assertion failed
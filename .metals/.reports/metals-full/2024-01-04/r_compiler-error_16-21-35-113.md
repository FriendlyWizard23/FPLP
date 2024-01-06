file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 265
uri: file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
text:
```scala
import scala.util.parsing.combinator._
import scala.collection.mutable._

class Wtf(var stack:Stack[Int]) extends JavaTokenParsers{

  def number = "[0-9]+".r^^(_.toInt)
  def args = number
  def zero = "[0]".r^^(_.toInt)
  def print = "!"
  def arithops = "[+]"|"[@@]"
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
}

object ParserTester extends App {
  val input1 = 
    """
    0---!
    def P 1 = $1 !
    """
  val parser = new Wtf(new Stack())
  val res=parser.parseAll(parser.program, input1)
  println(res)
}
```



#### Error stacktrace:

```
scala.collection.LinearSeqOps.apply(LinearSeq.scala:131)
	scala.collection.LinearSeqOps.apply$(LinearSeq.scala:128)
	scala.collection.immutable.List.apply(List.scala:79)
	dotty.tools.dotc.util.Signatures$.countParams(Signatures.scala:501)
	dotty.tools.dotc.util.Signatures$.applyCallInfo(Signatures.scala:186)
	dotty.tools.dotc.util.Signatures$.computeSignatureHelp(Signatures.scala:94)
	dotty.tools.dotc.util.Signatures$.signatureHelp(Signatures.scala:63)
	scala.meta.internal.pc.MetalsSignatures$.signatures(MetalsSignatures.scala:17)
	scala.meta.internal.pc.SignatureHelpProvider$.signatureHelp(SignatureHelpProvider.scala:51)
	scala.meta.internal.pc.ScalaPresentationCompiler.signatureHelp$$anonfun$1(ScalaPresentationCompiler.scala:388)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: 0
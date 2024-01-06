file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 387
uri: file://<WORKSPACE>/scala/esami/luglio2016/wtf.scala
text:
```scala
import scala.util.parsing.combinator._
import scala.collection.mutable._

class Wtf(var stack:Stack[Int]) extends JavaTokenParsers{
        def program = expression|number
        def expression = number ~ rep("+") ~ (print|eol) ^^{
            case n ~ o ~ e=> if (o.contains("+"))stack.push(n+o.length)else{stack.push(n-o.length)}
        } 
        def eol=""
        def print="!"^^(@@)
        def number=wholeNumber^^(_.toInt)
}

object ParserTester extends App {
  val input1 = "5+++"
  val input2 = "10---"

  val parser = new Wtf(new Stack())

  println(s"Testing with input: $input1")
  parser.parseAll(parser.program, input1)

  println(s"\nTesting with input: $input2")
  parser.parseAll(parser.program, input2)
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
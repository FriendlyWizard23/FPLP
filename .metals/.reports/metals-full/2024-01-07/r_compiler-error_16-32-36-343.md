file://<WORKSPACE>/scala/exercices/lab02/03/arithops.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 490
uri: file://<WORKSPACE>/scala/exercices/lab02/03/arithops.scala
text:
```scala
import scala.util.parsing.combinators._
class Arithops() extends JavaTokenParsers{
    
    def numbers:Parser[()=>Int] = """[0-9]+""".r^^{
        case n => ()=>n.toInt
    }
    def inlineop:Parser[()=>Int] = numbers~("+"|"-")~inlineop^^{
        case e~"+"~o => e()+o()
        case e~"-"~o => e()-o()
    }
    def main = inlineop<~"="^^{
        case e => println(e())
    }
}

object tester extends App{
    val a = new Arithops
    val input = "1423+4534-234="
    a.parseAll(a.main,@@)
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
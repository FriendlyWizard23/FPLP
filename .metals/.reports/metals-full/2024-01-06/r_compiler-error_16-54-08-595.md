file://<WORKSPACE>/scala/esami/parziale%20anno%20scorso/LogLang.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 1123
uri: file://<WORKSPACE>/scala/esami/parziale%20anno%20scorso/LogLang.scala
text:
```scala
import scala.util.parsing.combinator._
class LogLang()extends JavaTokenParsers{
    def taskName = ident
    def actions = remove | rename | merge | backup 
    def filename = stringLiteral^^{
        case s => s.substring(1,s.length-1)
    }
    def remove = "remove"~>filename^^{
        case f => true
    }
    def rename = "rename"~>filename~filename^^{
        case f~f2=> true
    }
    def merge = "merge"~>filename~filename~filename^^{
        case f~f2~f3=> true
    }
    def backup = "backup"~>filename~filename^^{
        case f~f2 => true
    }
    def main = "task"~>taskName ~("{"~>rep(actions)<~"}")
}

object parser extends App{
    val l = new LogLang()
    val input="""
    task TaskOne{
        remove "fuckingNigger"
        backup "fuckingNigger" "fuckoffNigger"
        remove "fuckingNigger" 
    }
    
    """
    l.parseAll(l.main,input) match {
        case l.Success(result,_) => result.foreach{
            _ match{
                case l.~(t,o) => {
                    println("task "+t.toString);
                    o.zipWithIndex.foreach{
                        case (o,i)=>println("[]@@")
                    }
                }
            }
        }
    }
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
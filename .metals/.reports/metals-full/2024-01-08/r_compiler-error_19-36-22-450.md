file://<WORKSPACE>/scala/esami/parziale%20anno%20scorso/LogLang2.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

action parameters:
offset: 2254
uri: file://<WORKSPACE>/scala/esami/parziale%20anno%20scorso/LogLang2.scala
text:
```scala
import scala.util.parsing.combinator._
import java.io._
import util.Try
import scala.io.Source
class LogLang()extends JavaTokenParsers{
    def taskName = ident
    def actions = remove | rename | merge | backup 
    def filename = stringLiteral^^{
        case s => s.substring(1,s.length-1)
    }
    def remove = "remove"~>filename^^{
        case f => removeFile(f)
    }
    def rename = "rename"~>filename~filename^^{
        case f~f2=> renameFile(f,f2)
    }
    def merge = "merge"~>filename~filename~filename^^{
        case f~f2~f3=> mergeFiles(f,f2,f3)
    }
    def backup = "backup"~>filename~filename^^{
        case f~f2 => backupFile(f,f2)
    }
    def main = "task"~>taskName ~("{"~>rep(actions)<~"}")
    def program = rep(main)
    
    def removeFile(filename:String):Boolean={
        Try(new File(filename).delete()).getOrElse(false)
    }
    def renameFile(f1:String,f2:String):Boolean={
        Try{
            var file1=new File(f1);
            var file2=new File(f2);
            file1.renameTo(file2);
            true
        }.getOrElse(false)
    }
    def backupFile(f1:String,f2:String):Boolean={
        Try{
            var file1=new File(f1);
            var file2=new File(f2);
            new FileOutputStream(file2).getChannel.transferFrom(
                new FileInputStream(file1).getChannel,0,Long.MaxValue
            );
            true
        }.getOrElse(false)
    }

    def mergeFiles(f1:String,f2:String,f3:String):Boolean={
        Try{
            var file1=new File(f1);
            var file2=new File(f2);
            var file3=new File(f3);
            new FileOutputStream(file3).getChannel.transferFrom(
                new FileInputStream(file1).getChannel,0,Long.MaxValue
            );
            new FileOutputStream(file3).getChannel.transferFrom(
                new FileInputStream(file2).getChannel,0,Long.MaxValue
            );
            true
        }.getOrElse(false)
    }

}

object parser extends App{
    val l = new LogLang()
    val fileContent = try{
        Source.fromFile("loglang.txt").mkString
    }catch{
            case e:Exception => println(e);sys.exit(1)
    }
    l.parseAll(l.program,fileContent) match {
        case l.Success(result,_) => result.foreach()@@)
        case _ => println("An error occurred")
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
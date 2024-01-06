import scala.util.parsing.combinator._
import scala.collection.mutable._
import java.io.{File,FileInputStream,FileOutputStream}
import scala.language.postfixOps
import util.Try
class LogLang extends JavaTokenParsers{
    def alltasks = rep(task)
    def command = remove | rename | backup | merge
    def merge = "merge" ~> text ~ text ~text^^ {
        case s1 ~ s2 ~ t => mergeFiles(s1,s2,t)
    } 
    def rename = "rename" ~> text ~ text ^^ {
        case s ~ t => renameFile(s,t)
    }
    def remove = "remove" ~> text ^^ {
        case s => removeFile(s)
    }
    def backup = "backup" ~> text~text ^^ {
        case s ~ t => backupFile(s,t)
    }
    def task = "task" ~> ident ~ ( "{" ~> rep(command) <~ "}" )

    def text = stringLiteral ^^ { case str => str.substring(1, str.length - 1) }

    def removeFile(filename:String): Boolean = {
        Try(new File(filename).delete()).getOrElse(false)
    }
    def renameFile(filename:String,newname:String): Boolean = {
        Try(new File(filename).renameTo(new File(newname))).getOrElse(false)
    }
    def backupFile(file:String,backup:String): Boolean ={
         Try((
            () => {
                new FileOutputStream(new File(backup)).getChannel() transferFrom(
                new FileInputStream(new File(file)) getChannel, 0, Long.MaxValue );
                true
                })()
            ).getOrElse(false)
    }
    def mergeFiles(s1:String,s2:String,t:String):Boolean = {
         Try((
            () => {
                new FileOutputStream(new File(t)).getChannel()transferFrom(
                new FileInputStream(new File(s1)).getChannel, 0, Long.MaxValue); 
                new FileOutputStream(new File(t), true).getChannel() transferFrom(
                new FileInputStream(new File(s2)) getChannel, 0, Long.MaxValue);
                true
                })()
        ).getOrElse(false)
    }
}


object LogLangTester extends App {
  val parser = new LogLang

  // Input con una struttura di task
  val input =
    """
      |task TaskOne {
      |  remove "application.debug.old"
      |  rename "application.debug" "application.debug.old"
      |  merge "file1.log" "file2.txt" "file3.log"
      |  backup "file1.txt" "backup/file1.txt"
      |}
      |task TaskTwo {
      |  backup "file2.txt" "backup/file2.txt"
      |  rename "file3.txt" "newfile3.txt"
      |  remove "file4.txt"
      |}
    """.stripMargin

  // Parse and print the result
  parser.parseAll(parser.alltasks, input) match {
    case parser.Success(result, _) => println(result);result.foreach{
        _ match {
            case parser.~(sl,l) => {
                println("Task " + sl)
                l.zipWithIndex.foreach{ case(x,i) => println("[Op"+(i+1).toString()+s"]$x") }
                println()
            }
        }
    }
    case parser.Failure(msg, _) => println(s"Failed to parse: $msg")
    case parser.Error(msg, _) => println(s"Error: $msg")
  }
}

import scala.util.parsing.combinator._
import scala.collection.mutable._
import scala.io.Source

class ArnoldC (var env: HashMap[String,Double]) extends JavaTokenParsers {
    def main = "IT'S SHOW TIME" ~> rep(codelines) <~ "YOU HAVE BEEN TERMINATED"
    def body:Parser[Any] = rep(codelines)
    def codelines = printing | printing_variable|assignment | declaration | assignmentbool | condition | condition_variable | loop | arithops | booleanops | assignment_variable
    def arithops = sum | sub | mul
    def booleanops = equals | and | or | bigger
    def block = """(?s)\[.*?\]""".r ^^ {s => s.substring(1,s.length-1)}
    def variable = ident
    def word = stringLiteral | floatingPointNumber
    def value = floatingPointNumber ^^ (_.toDouble) 
    // DECLARATION AND ASSIGNMENT
    def declaration = "HEY CHRISTMAS TREE" ~> variable ~("YOU SET US UP" ~> value) ^^ {
        case s ~ v => 
            env += (s->v)
    }

    // TODO: FARE IL CASO IN CUI NON PARTI DA UN VALORE INTERO MA DA UN VALORE IN VARIABILE
    def assignment = "GET TO THE CHOPPER" ~> variable ~("HERE IS MY INVITATION" ~> value) ~ (rep(arithops )<~ "ENOUGH TALK")^^{
        case k ~ v ~ commands => 
            val res:Double = commands.foldRight(v)((commands,res:Double) => commands(res:Double))
            env += (k->res)    
    }
    def assignment_variable = "GET TO THE CHOPPER" ~> variable ~("HERE IS MY INVITATION" ~> variable) ~ (rep(arithops )<~ "ENOUGH TALK")^^{
        case k ~ v ~ commands => 
            val res:Double = commands.foldRight(env(v))((commands,res:Double) => commands(res:Double))
            env += (k->res)   
    }
    def assignmentbool = "GET TO THE CHOPPER" ~> variable ~("HERE IS MY INVITATION" ~> value) ~ (rep(booleanops)<~ "ENOUGH TALK")^^{
        case k ~ v ~ commands => 
            val res:Double = commands.foldRight(v)((commands,res:Double) => commands(res:Double))
            env += (k->res)
            if (res==0)println(false)else println(true)      
      }

    // LOOP
    def loop=("STICK AROUND"~>variable) ~ (block <~"CHILL")^^{
      case v ~ lines => while(env(v)!=0.0) {parseAll(body,lines) }
    }

    // IF THEN ELSE
    def condition = ("BECAUSE I'M GOING TO SAY PLEASE"~>value)~block~("BULLSHIT"~>block<~"YOU HAVE NO RESPECT FOR LOGIC") ^^{
      case v~c1~c2 =>
        if (v!=0) parseAll(body,c1) else parseAll(body,c2)
    }
    def condition_variable = ("BECAUSE I'M GOING TO SAY PLEASE"~>variable)~block~("BULLSHIT"~>block<~"YOU HAVE NO RESPECT FOR LOGIC") ^^{
      case v~c1~c2 =>
        if (env(v)!=0) parseAll(body,c1) else parseAll(body,c2)
    }

    // ARITH OPERATIONS
    def sum = "GET UP" ~> value ^^ {
        op1 => (op2:Double) => op1+op2
    }
    def sub = "GET DOWN" ~> value ^^ {
        op1 => (op2:Double) => op1-op2
    }
    def mul = "YOU'RE FIRED" ~> value ^^ {
        op1 => (op2:Double) => op1*op2
    }

    // BOOLEAN OPERATIONS
    def equals = "YOU ARE NOT YOU YOU ARE ME" ~> value^^{
      op1 => (op2:Double) => if (op1==op2) 1.toDouble else 0.toDouble
    }
    def and = "KNOCK KNOCK"~> value ^^ {
      op1 => (op2:Double) => (op1*op2).toDouble 
    }
    def or = "CONSIDER THAT A DIVORCE" ~> value ^^ {
      op1 => (op2:Double) => if (op1==1 && op2==1) 1.toDouble else (op1+op2).toDouble
    }
    def bigger = "LET OFF SOME STEAM BENNET"~> value ^^ {
      op1 => (op2:Double) => if (op1>op2) 1.0 else 0.0
    }


    // PRINTING
    def printing = "TALK TO THE HAND" ~> word ^^ {
        case s => println(s)
    }
    def printing_variable = "TALK TO THE HAND" ~> variable ^^ {
        case s => println(env(s))
    }
}



object ArnoldCTesterFromFile extends App {
  val arnoldCParser = new ArnoldC(new HashMap[String,Double]())

  // Nome del file di input
  val fileName = "input_arnoldc.txt"

  // Leggi il contenuto del file
  val fileContent = try {
    Source.fromFile(fileName).mkString
  } catch {
    case e: Exception =>
      println(s"Errore nella lettura del file $fileName: ${e.getMessage}")
      sys.exit(1)
  }

  // Parse e stampa il risultato
  arnoldCParser.parseAll(arnoldCParser.main, fileContent) match {
    case arnoldCParser.Success(_, _) => println("Parsing successful")
    case arnoldCParser.Failure(msg, _) => println(s"Failed to parse: $msg")
    case arnoldCParser.Error(msg, _) => println(s"Error: $msg")
  }
}




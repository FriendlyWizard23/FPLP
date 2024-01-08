import scala.util.parsing.combinator._

class Brainfuck(var dataPointer:Int, val mem:Array[Int]) extends JavaTokenParsers{
    def incrementDP = ">"^^{
        case _ => dataPointer+=1
    }
    def decrementDP= "<"^^{
        case _ => dataPointer-=1
    }
    def incrementByteAtDP="+"^^{
        case _ => mem(dataPointer)=mem(dataPointer)+1
    }
    def decrementByteAtDP="-"^^{
        case _ => mem(dataPointer)=mem(dataPointer)-1
    }
    def printCharAtDP="."^^{
        case _ => println(mem(dataPointer))
    }
    def readUserInput=","^^{
        case _ => {
            var input = scala.io.StdIn.readChar()
            mem(dataPointer)=input.toInt
        }
    }
    def block = """(?s)\[.*?]""".r^^ {s => println(s.substring(1,s.length-1)); s.substring(1,s.length-1)}
    def statements = incrementByteAtDP|decrementByteAtDP|incrementDP|decrementDP|printCharAtDP|readUserInput
    def loop = block^^{
        case s => while(mem(dataPointer)!=0){parseAll(main,s)}
    }
    def main:Parser[Any]=rep(statements|loop)

}

object tester extends App{
    val bf=new Brainfuck(0,new Array(30000))
    val input= 
    """
    ++++++++               
    >++++ 
       
        >+++  
        [        
        [           
            -  
            .         
        ]
        ]
        <-
        .
    
    """
    bf.parseAll(bf.main,input) match {
        case bf.Success(result,_)=>{
            println(true)
        }
        case bf.Failure(result,_) => println(result)
        case _ => println("Unknown error")
    }
}
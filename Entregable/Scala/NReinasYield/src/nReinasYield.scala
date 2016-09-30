object nReinas {
  var cantReinas = 4;/*variable predefinida para la cantidad de reinas*/
  /*Main*/
  def main(args: Array[String]) {

  /*Para resolver solo una vez*/  
  tiempo(mostrar(nreinas(cantReinas)))
  /*Para comprobar unicamente el tiempo de varias soluciones*/
    /* for( a <- 4 to 11){
           println("Problema con " + a + " Reinas")
           tiempo(mostrar(nreinas(a)))
           println()
        }*/
  }
  
  /*Funcion para encontrar soluciones*/
  def nreinas(n: Int): Set[List[Int]] = {
    def lugar(k: Int): Set[List[Int]] =
      if (k == 0) Set(List())
      else
        for {
          reinas <- lugar(k - 1)
          col <- 0 until n
          if posSegura(col, reinas)
        } yield reinas :+ col

    def posSegura(col: Int, reinas: List[Int]): Boolean = {
      val fila = reinas.length
      val reinasConFila = (0 until fila) zip reinas
      reinasConFila forall {
        case (r, c) => col != c && math.abs(col - c) != fila - r
      }
    }
    lugar(n)
  }
  
 /*Funcion para imprimir tableros*/ 
  def mostrar(soluciones: Set[List[Int]]): Unit = {

  for (solucion <- soluciones) yield {
      println("\n+" + "-+" * solucion.length)
      (for { col <- solucion } yield {
        println(
        Vector.fill(solucion.length + 1)("| ").updated(col, "|X").mkString("")
        )
        println("+" + "-+" * solucion.length)
      }).mkString("| \n+" + "-+" * solucion.length + "\n")
    }

     println("Total de soluciones " + soluciones.size )
  }

/*Funcion para medir el tiempo transcurrido*/
  def tiempo[R](block: => R): R = {
      val t0 = System.nanoTime()
      val result = block 
      val t1 = System.nanoTime()
      println("Tiempo transcurrido: " + ((t1 - t0) / 1000000000.0) + " segundos")
      result
  }
}
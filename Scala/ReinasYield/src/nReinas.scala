object nReinas {
  def main(args: Array[String]) = mostrar(nreinas(4))

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
  def mostrar(solutions: Set[List[Int]]): Unit = {

for (solution <- solutions) yield {
      println("\n+" + "-+" * solution.length)
      (for { col <- solution } yield {
        println(
        Vector.fill(solution.length + 1)("| ").updated(col, "|X").mkString("")
        )
        println("+" + "-+" * solution.length)
      }).mkString("| \n+" + "-+" * solution.length + "\n")
    }

     
  }
}
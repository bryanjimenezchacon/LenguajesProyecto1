
import Base
#print("Problema N-Reinas")
function resolver(n::Int)#Genera la lista de posiciones para utilizar con 0, e inicia el proceso
  lugares = zeros(Int, n)
  buscaPosiciones(lugares, 1, n)
end

function buscaPosiciones(lugares, i , n)#Busca las posiciones posibles
  if i == n + 1
    dibuja(lugares, i , n)
    return 1
  end

  s = 0
  @inbounds for j in 1:n
    if posValida(lugares, i , j)
      lugares[i] = j
      s += buscaPosiciones(lugares, i + 1, n)
    end
  end
  s
end

function posValida(lugares, i , j)#Verifica la posicion como aceptable
  qi = 1
  @inbounds for qj in lugares
    if qi == i
      break
    elseif qj == j || abs(qi - i) == abs(qj - j)
      return false
    end
    qi +=1
  end
  true
end

function dibuja(lugares, i , n)#Muestra el tablero
  #println(lugares)
  extremosTablero = ("\n+" * "-+" ^ n)
  linea = ("+" * "-+" ^ n)
  println(extremosTablero )
  @inbounds for l in lugares

           println("|" * " |"  ^(l - 1) * "X|" * " |"  ^ (n - l))
           println(linea)
 end
end
#Para probar eficiencia comentar la funcion dibuja invocada en buscaPosiciones
n = 4
#@inbounds for n in range(4,11)
  println("Problema con " * string(n) * " Reinas");
  tic();
  print("Cantidad de soluciones: ")
  print(resolver(n));
  print(" ");
  toc();
  println();
#end

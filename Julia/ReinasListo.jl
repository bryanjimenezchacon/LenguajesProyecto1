
import Base
print("Problema N-Reinas")
function resolver(n::Int)
  lugares = zeros(Int, n)
  buscaPosiciones(lugares, 1, n)
end

function buscaPosiciones(lugares, i , n)
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

function posValida(lugares, i , j)
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

function dibuja(lugares, i , n)
  #println(lugares)
  extremosTablero = ("\n+" * "-+" ^ n)
  linea = ("+" * "-+" ^ n)
  println(extremosTablero )
  @inbounds for l in lugares

           println("|" * " |"  ^(l - 1) * "X|" * " |"  ^ (n - l))
           println(linea)
 end
end
print(resolver(4))

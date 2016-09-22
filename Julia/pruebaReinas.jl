
import Base
print("hola")
function solve(n::Int)
  places = zeros(Int, n)
  search(places, 1, n)
end

function search(places, i , n)
  if i == n + 1
    return 1
  end
  s = 0
  @inbounds for j in 1:n
    if isok(places, i , j)
      places[i] = j
      s += search(places, i + 1, n)
    end
  end
  s
end

function isok(places, i , j)
  qi = 1
  @inbounds for qj in places
    if qi == i
      break
    elseif qj == j || abs(qi - i) == abs(qj - j)
      return false
    end
    qi +=1
  end
  true

end

print(solve(4))

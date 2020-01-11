package algorithms

import kotlin.test.assertEquals

/*
    1
   1 1
  1 2 1
 1 3 3 1
1 4 6 4 1
*/
fun main() {
  assertEquals(getTriangle(3), listOf(1, 2, 1))
  assertEquals(getTriangle(5), listOf(1, 4, 6, 4, 1))
}

private fun getTriangle(n: Int): List<Int> {
  if(n == 1) return listOf(1)

  val prev = getTriangle(n - 1)
  val list = mutableListOf<Int>()
  list.add(1)
  for(i in 1 until n - 1) {
    list.add(prev[i - 1] + prev[i])
  }
  list.add(1)

  return list
}
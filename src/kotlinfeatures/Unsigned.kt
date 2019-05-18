@file:Suppress("EXPERIMENTAL_UNSIGNED_LITERALS")

package kotlinfeatures

fun main() {
  val u1 = 2_147_483_649u
  val u2 = 4_000_000_000u
  println(minOf(u1, u2))

  val array: UIntArray = uintArrayOf(u1, u2)
  println(array.max())
  println(array.all { it > Int.MAX_VALUE.toUInt() })
}
package algorithms.rpn

import java.util.*
import kotlin.test.assertEquals

object Rpn {
  @JvmStatic
  fun main(args: Array<String>) {
    assertEquals(executeRpn("2 3 +"), 5)
    assertEquals(executeRpn("2 3 + 5 *"), 25)
    assertEquals(executeRpn("12 2 3 4 * 10 5 / + * +"), 40)
    assertEquals(executeRpn("2 3 + DUP"), 10)
    assertEquals(executeRpn("2 3 + NOOP"), 5)
    assertEquals(executeRpn("1 2 3 3 MAX"), 3)
  }

  private fun executeRpn(input: String): Int {
    val stack = LinkedList<Int>()

    input.split(" ").forEach {
      val operator = Operator.fromSymbol(it)

      if (operator != null) {
        operator.execute(stack)
      } else {
        stack.push(Integer.parseInt(it))
      }
    }

    if (stack.size == 1) return stack.pop() else throw IllegalStateException()
  }

  enum class Operator(val symbol: String, val execute: (LinkedList<Int>) -> Unit) {
    PLUS("+", { stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left + right)
    }),
    MINUS("-", { stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left - right)
    }),
    MULTIPLY("*", { stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left * right)
    }),
    DIVIDE("/", { stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left / right)
    }),
    DUP("DUP", { stack ->
      val top = stack.pop()
      stack.push(top * 2)
    }),
    NOOP("NOOP", {}),
    MAX("MAX", { stack ->
      var count = stack.pop()
      var max = Int.MIN_VALUE
      while (count > 0) {
        max = Math.max(max, stack.pop())
        count--
      }
      if (max != Int.MIN_VALUE) {
        stack.push(max)
      }
    });

    companion object {
      fun fromSymbol(symbol: String) = values().find { it.symbol == symbol }
    }
  }
}

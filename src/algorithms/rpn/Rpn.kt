package algorithms.rpn

import algorithms.rpn.Token.IntToken
import algorithms.rpn.Token.Operator.*
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
    val tokens = input.split(" ").map { Parser.parse(it) }
    val stack = LinkedList<Int>()

    tokens.forEach {
      when (it) {
        is Token.Operator -> it.execute(stack)
        is Token.IntToken -> stack.push(it.value)
      }
    }

    if (stack.size == 1) return stack.pop() else throw IllegalStateException()
  }
}

sealed class Token {
  sealed class Operator(val execute: (LinkedList<Int>) -> Unit) : Token() {
    object Plus : Operator({ stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left + right)
    })

    object Minus : Operator({ stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left - right)
    })

    object Multiply : Operator({ stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left * right)
    })

    object Divide : Operator({ stack ->
      val right = stack.pop()
      val left = stack.pop()
      stack.push(left / right)
    })

    object Dup : Operator({ stack ->
      val top = stack.pop()
      stack.push(top * 2)
    })

    object Noop : Operator({})

    object Max : Operator({ stack ->
      var count = stack.pop()
      var max = Int.MIN_VALUE
      while (count > 0) {
        max = Math.max(max, stack.pop())
        count--
      }
      if (max != Int.MIN_VALUE) {
        stack.push(max)
      }
    })
  }

  class IntToken(val value: Int) : Token()
}

object Parser {
  fun parse(char: String): Token =
    when (char) {
      "+" -> Plus
      "-" -> Minus
      "*" -> Multiply
      "/" -> Divide
      "DUP" -> Dup
      "NOOP" -> Noop
      "MAX" -> Max
      else -> Integer.parseInt(char).let(::IntToken)
    }
}

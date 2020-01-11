package kotlinfeatures

fun main() {
  val list = mutableListOf<String>()
  doSth(list)
}

fun doSth(list: MutableList<String>) {
  list.add("hehe")
}

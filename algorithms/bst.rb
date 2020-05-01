class Bst
  Node = Struct.new(:key, :value, :left, :right) do
    def initialize(key, value, left = nil, right = nil)
      ; super
    end
  end

  def put(key, value)
    if root
      put_node(root, key, value)
    else
      @root = Node.new(key, value)
    end
  end

  def get(key)
    get_value(root, key)
  end

  private

  attr_reader :root

  def put_node(root, key, value)
    if key == root.key
      root.value = value
    elsif key < root.key
      if root.left
        put_node(root.left, key, value)
      else
        root.left = Node.new(key, value)
      end
    else
      if root.right
        put_node(root.right, key, value)
      else
        root.right = Node.new(key, value)
      end
    end
  end

  def get_value(root, key)
    return unless root

    if root.key == key
      root.value
    elsif key < root.key
      get_value(root.left, key)
    else
      get_value(root.right, key)
    end
  end
end

# Example: count words in text
text = 'In computer science, binary search trees (BST), sometimes called ordered or sorted binary trees, are a particular type of container: a data structure that stores "items" (such as numbers, names etc.) in memory. They allow fast lookup, addition and removal of items, and can be used to implement either dynamic sets of items, or lookup tables that allow finding an item by its key (e.g., finding the phone number of a person by name).
Binary search trees keep their keys in sorted order, so that lookup and other operations can use the principle of binary search: when looking for a key in a tree (or a place to insert a new key), they traverse the tree from root to leaf, making comparisons to keys stored in the nodes of the tree and deciding, on the basis of the comparison, to continue searching in the left or right subtrees. On average, this means that each comparison allows the operations to skip about half of the tree, so that each lookup, insertion or deletion takes time proportional to the logarithm of the number of items stored in the tree. This is much better than the linear time required to find items by key in an (unsorted) array, but slower than the corresponding operations on hash tables.
Several variants of the binary search tree have been studied in computer science; this article deals primarily with the basic type, making references to more advanced types when appropriate.'

words = text
  .gsub!(/[^0-9A-Za-z ]/, '')
  .split(' ')
  .map(&:downcase)

tree = Bst.new

words.each do |w|
  current = tree.get(w) || 0
  tree.put(w, current + 1)
end

puts words
  .map { |w| [w, tree.get(w)] }
  .sort_by { |i| -i[1] }
  .to_h
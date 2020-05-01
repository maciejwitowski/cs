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

Movie = Struct.new(:name, :rating)

movies = [
  Movie.new("Avatar", 9),
  Movie.new("Braveheart", 8),
  Movie.new("Zorro", 3),
  Movie.new("Bridget", 1),
]

tree = Bst.new
movies.each { |m| tree.put(m.name, m) }

puts tree.get("Avatar")
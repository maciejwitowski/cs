# https://en.wikipedia.org/wiki/Merkle_tree
# Merkle Tree is used in Blockchain to verify the presence of the transaction in a block

require 'digest'

# Double hash as it happens in blockchain
def hash(tx)
  Digest::SHA256.hexdigest(Digest::SHA256.hexdigest(tx))
end

class MerkleTree
  def initialize(tx_hashes)
    @tx_hashes = tx_hashes
  end

  def root
    @root ||= create_root
  end

  private

  attr_reader :tx_hashes

  def create_root
    return unless tx_hashes
    return if tx_hashes.empty?
    return tx_hashes[0] if tx_hashes.size == 1

    hashes = tx_hashes

    while hashes.size > 1
      # Duplicate last element if list has odd size
      if hashes.size.odd?
        hashes << hashes.last
      end

      temp_hashes = []

      (0..hashes.size - 1).step(2).each do |index|
        temp_hashes << hash(hash(hashes[index]) + hash(hashes[index + 1]))
      end

      hashes = temp_hashes
    end

    hashes[0]
  end
end

tx_a = "aaaaaaaaaaaa"
tx_b = "bbbbbbbbbbbb"
tx_c = "cccccccccccc"
tx_d = "dddddddddddd"

tx_hashes = [tx_a, tx_b, tx_c, tx_d]
#      H(ABCD)
#      /     \
#   H(AB)     H(CD)
#   /   \     /   \
#  H(A) H(B) H(C) H(D)

merkle = MerkleTree.new(tx_hashes)
puts "Root: #{merkle.root}"

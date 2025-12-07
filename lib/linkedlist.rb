# frozen_string_literal: true

require_relative 'node'

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    node = Node.new(value)
    self.head = node unless head
    tail.next_node = node if tail
    self.tail = node
    node
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = head
    self.head = node
    node
  end
  
  def size(head = self.head, size = 0)
    return size if head.nil?
    
    size(head.next_node, size + 1)
  end

  def at(index, head = self.head, node_index = 0)
    return nil if index > size || index < 0
    return head if index.eql? node_index
    
    at(index, head.next_node, node_index + 1)
  end

  def pop(head = self.head, tail = self.tail)
    return if head.nil?

    if head.next_node.nil?
      self.head = nil
      self.tail = nil
    elsif head.next_node.next_node.nil?
      head.next_node = nil
      self.tail = head
    end
    pop(head.next_node, tail)
  end

  def contains?(value, head = self.head)
    return false if head.nil?
    return true if head.value.eql? value

    contains?(value, head.next_node)
  end

  def find(value, head = self.head, index = 0)
    return nil if head.nil?
    return index if head.value.eql? value

    find(value, head.next_node, index + 1)
  end

  def insert_at(value, index)
    list_size = size
    return prepend(value) if index.eql? 0
    return append(value) if index.eql? list_size

    return unless index.between? 0, list_size

    current_node = at(index)
    previous_node = at(index - 1)
    inserted_node = Node.new(value)
    inserted_node.next_node = current_node
    previous_node.next_node = inserted_node
  end

  def remove_at(index)
    return unless at(index)

    previous_node = at(index - 1) if index.positive?
    current_node = at(index)
    self.tail = previous_node if current_node.eql? tail
    if current_node.eql? head
      self.head = current_node.next_node
    else
      previous_node.next_node = current_node.next_node
    end
  end

  def to_s(head = self.head, print_value = '')
    return "#{print_value}nil" if head.nil?

    print_value += "( #{head.value} ) -> "
    to_s(head.next_node, print_value)
  end

  private

  attr_writer :head, :tail
end

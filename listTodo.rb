require "json"

class ListTodo
  attr_accessor :name, :description, :id

  @@id_sequence = 0

  def initialize(list, id: nil)
    @id = id || @@id_sequence.next
    @@id_sequence = @id

    @name = list[:name]
    @description = list[:description]
    @lists = []
  end

  def to_json(_options = nil)
    { id: @id, name: @name, description: @description, lists: @lists }.to_json
  end

  def set_id(id)
    if id.nil?
      @id = (@@id_sequence += 1)
    elsif @id == id
      @@id_sequence = id if id > @@id_sequence
    end
  end
end

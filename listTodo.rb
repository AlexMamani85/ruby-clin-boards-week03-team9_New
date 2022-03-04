require "json"


class ListTodo
  attr_accessor  :name, :description

  @@id_sequence = 0
  def initialize( list, id: nil)
    # @id = id
    set_id(id)
    @name = list[:name]
    @description = list[:description]
  end


  def to_json(options = nil)
    {id: @id, name: @name, description: @description }.to_json
  end


  def set_id(id)
    if id.nil?
      @id = (@@id_sequence+= 1)
    elsif
      @id = id
      @@id_sequence = id if id > @@id_sequence
    end
  end

end
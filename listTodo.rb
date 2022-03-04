require "json"


class ListTodo
  attr_accessor  :name, :description


  def initialize( list)
    # @id = id
    @name = list["name"]
    @description = list["description"]
  end


  def to_json(options = nil)
    {name: @name, description: @description }.to_json
  end


end
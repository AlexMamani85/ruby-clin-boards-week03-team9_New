require 'json'

class Store
  attr_reader :list

  def initialize(filename)
    @filename = filename
    @list = load_list
  end

  def load_list
    JSON.parse(File.read(@filename))
    JSON.parse(File.read(@filename), symbolize_names: true).map do |list|
      ListTodo.new(list)
    end
    JSON.parse(File.read(@filename), symbolize_names: true)
  end

  def append_todo(listItem)
    @list << listItem
    File.write(@filename, @list.to_json)
  end

end
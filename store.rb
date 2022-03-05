require 'terminal-table'
require 'json'
require './prompter.rb'

class Store
  include Prompter
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

  def update_list(list, id)
    p list[:id]=id.to_i #  no tenia ningun valor list[:id]
    p list #{ name: name, description: description, id: } 
    @list.each do |el| 
      if el[:id] == id.to_i
        el[:name]=list[:name]
        el[:description]=list[:description]
        el[:lists]=[]
        p el[:name]
        p el[:description]
      end
    end
    File.write(@filename, @list.to_json)
    # p @list :  verificar valores modificados 
  end

  def show_board(id)
    p "def show_board(id)"
    p id
    p "def show_board(id)---fin "
    @list.each do |el| 
      if el[:id] == id.to_i
          
        el[:lists].each do |item|
          p "-"*20
          p item[:name] # Todo, In Progress, Code Review, Done  
          item[:cards].each do |element|
            p element # TODO's
            
          end
        end
      end
    end

    # Todo
    # In Progress
    # Code Review
    # ID Title Members Labels Due_Date Checklist


    # table = Terminal::Table.new
    # table.title = "CLIn Boards"
    # table.headings = ["ID", "Name", "Description", "List(#Cards)"]
    # table.rows = @list.map do |lt|
    #   [lt[:id], lt[:name], lt[:description], lt[:lists].empty? ? [] : lt[:lists].map {|el| p el[:name]} ]
    # end
    # puts table





  end


  def delete_board(id)
    @list.each do |el| 
      if el[:id] == id.to_i
        el.delete(:id)
        el.delete(:name)
        el.delete(:description)
        el.delete(:lists)


      end
    end
    p "comienza list"
    p @list
    File.write(@filename, @list.to_json)
    p "termina list"
  end

  def append_todo(listItem)
    @list << listItem
    File.write(@filename, @list.to_json)
  end

end
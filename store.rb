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
    @list.each do |el|
      if el[:id] == id.to_i
        el[:lists].each do |item|
          p "-"*20
          table = Terminal::Table.new
          table.title = item[:name]
          table.headings = ["ID", " Title ", "Members ", "Labels", "Due Date ", "Checklist"]
          table.rows = item[:cards].map do |lt|
            checkList = lt[:checklist].map do |c|
              count_incomplete = 0
              count_complete = 0
                if c[:completed]
                  count_incomplete += 1
                else
                  count_incomplete += 1
                end
                "#{count_incomplete}/#{count_incomplete}"
              end
              [lt[:id], lt[:title], lt[:members], lt[:labels], lt[:due_date], checkList]
          end
          puts table
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
    @list.select! { |listItem| listItem[:id] != id.to_i }
    File.write(@filename, @list.to_json)
  end

  def append_todo(listItem)
    @list << listItem
    File.write(@filename, @list.to_json)
  end

end
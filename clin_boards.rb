require 'terminal-table'
require './store.rb'
require './prompter.rb'
require_relative 'listTodo'

class ClinBoards
  include Prompter
  attr_accessor :store
  def initialize(store = "store.json")
    @store = Store.new(store)
    @list = @store.list
  end

  def start
    action = ""
      welcome_message
      print_list
    until action == "exit"
      action, id = main_menu
      case action
      when "create"
        create_list
        print_list
      when "show" then puts "show"
      when "update" then puts "update"
      when "delete" then puts "delete"
      when "exit" then puts "EXIT!"
      else
        puts "Invalid option!"
      end

    end
  
  end

  def print_list
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ["ID", "Name", "Description", "List(#Cards)"]
    table.rows = @list.map do |lt|
      [lt[:id], lt[:name], lt[:description], lt[:lists].empty? ? [] : lt[:lists].map {|el| p el[:name]} ]
    end
    puts table
  end

  def welcome_message
    puts "#" * 35
    puts "#      Welcome to CLIn Boards     #"
    puts "#" * 35
  end

  def create_list
    list_data = list_form  #{name: "", description: ""}
    list = ListTodo.new(list_data) # => { name: name, description: description }
    
    @store.append_todo({id: list.id, name: list.name, description: list.description, lists: []})
  
  end
end

# get the command-line arguments if neccesary
app = ClinBoards.new
app.start

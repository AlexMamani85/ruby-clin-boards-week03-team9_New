require 'terminal-table'
require './store.rb'
require './prompter.rb'
require_relative 'listTodo'
require_relative 'card'

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
      puts "Board options: create | show ID | update ID | delete ID | exit"
      action, id = main_menu
      case action
      when "create"
        create_list
        print_list
      when "show" then show_board(id)
      when "update" then update_list(id)
      when "delete" then puts delete_board(id)
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

  def update_list(id)
    data = list_form
    # list y id ok
    @store.update_list(data,id)

    print_list
  end 
  
  def delete_board(id)
    @store.delete_board(id)
    print_list
  end

  def menu_cards
    puts "List options: create-list | update-list LISTNAME | delete-list LISTNAME"
    puts "Card options: create-card | checklist ID | update-card ID | delete-card ID"
  end
  
  def show_board(id)
    @store.show_board(id)
    menu_cards
    new_card = Card.new()
    new_card.start
  end

  
end

# get the command-line arguments if neccesary
app = ClinBoards.new
app.start

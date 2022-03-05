require_relative 'prompter'
require_relative 'store'

class CheckList
  include Prompter

  def initialize(id = 1, title = "", checkItem = "")
    @title = title
    @checkItem = checkItem
    @list = Store.new("store.json").load_list
  end

   def start
    action = ""
    until action == "exit"
      action, id = main_menu
      case action
      when "checklist"
        show_checklist(id)
      # when "show" then show_board(id)
      # when "update" then update_list(id)
      # when "delete" then puts delete_board(id)
      when "exit" then puts "EXIT!"
      else
        puts "Invalid option!"
      end

    end
  
  end



  def show_checklist(id)
    @list.each do |el|
      if el[:id] == id.to_i
        el[:lists].each do |item|
          
          item[:cards].map do |lt|

            if lt[:id] == id.to_i
              puts lt[:title]
              count = 0
              # bug en el contador de la lista
              lt[:checklist].each do |item|
                puts "[#{item[:completed] == true ? "x" : " "}] #{count + 1}.- #{item[:title]} "
              end
            end
          end
        end
      end
    end
    puts "-------------------------------------"
    puts option_menu
  end

  def option_menu
    puts "Checklist options: add | toggle INDEX | delete INDEX"
    print "> "
    op = gets.chomp
  end

end
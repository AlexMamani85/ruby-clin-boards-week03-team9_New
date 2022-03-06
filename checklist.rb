require "json"
require_relative 'prompter'
require_relative 'store'
require_relative 'card'


class CheckList
  include Prompter
  @@id_sequence = 0

  def initialize(id = nil, title = "", checkItem = "")
    set_id(id)
    # @id = id
    @title = title 
    @checkItem = checkItem
    @list = Store.new("store.json").load_list
  end

  def start()
    continue = true
    action = ""
    loop do
      action, id = main_menu
      case action
      when "checklist"
        show_checklist(id)
      when "add"
        add_checklist
        show_checklist(1)
      when "toggle"
        toggle(id)
        show_checklist(1)
      when "delete"
        delete_at(id)
        show_checklist(1)
      when "create-card"
        option = select_table_name
        switch_table(option)
      when "back"
        continue = false
        puts "exit!"
        break
      else
        puts "Invalid option!: class CheckList: ln: 47"
      end
    end
    continue
  end

  def delete_at(id = 1,index)
    @list.each do |el|
        if el[:id] == id.to_i
          el[:lists].each do |item|
            item[:cards].each do |card|
              if card[:id] == id.to_i
                count = 0
                card[:checklist].delete_at(index.to_i)
            end
          end
        end
      end
    end
  end

  def toggle(id = 1, index)
     @list.each do |el|
        if el[:id] == id.to_i
          el[:lists].each do |item|
            item[:cards].each do |card|
              if card[:id] == id.to_i
                count = 0
                card[:checklist].each do |listItem|
                  count += 1
                  if count == index.to_i
                    puts "jeje"
                    listItem[:completed] = true
                  end
                end
              end
            end
          end
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
                count+=1
                puts "[#{item[:completed] == true ? "x" : " "}] #{count}.- #{item[:title]} "
              end
            end
          end
        end
      end
    end
    puts "-------------------------------------"
    option_menu
  end


  def add_checklist(id = 1)
    print "Title: "
    title = gets.chomp
    @list.each do |el|
        if el[:id] == id
          el[:lists].each do |item|
            item[:cards].each do |card|
              if card[:id] == id
                card[:checklist] << {"title": title,
                "completed": false}
              end
            end
          end
        end
    end
  end

  def option_menu
    puts "Checklist options: add | toggle INDEX | delete INDEX"
    # print "checklist 133> "
    # op = gets.chomp
  end

  def select_table_name
    puts "Select the list: "
    puts "Todo | In Progress | Code Review | Done"
    print "checklist 140> "
    op_card = gets.chomp
    op_card
  end


  def switch_table(select_name)
    case select_name
    when "Todo"
      print "Title: "
      title_card = gets.chomp
      print "Members: "
      members_card = gets.chomp
      print "Labels: "
      labels_card = gets.chomp
      print "Due Date: "
      date_card = gets.chomp
      new_todo = {
        title: title_card,
        members: members_card,
        labels: labels_card,
        due_date: date_card,
        checklist: []
      } 
      todo_Card = Card.new(**new_todo)
      #todo_Card.to_json
      @list.each do |el|
        el[:lists].each do |item|
          if item[:name] == select_name
            #  @store.append_todo({id: list.id, name: list.name, description: list.description, lists: []})
            item[:cards] << new_todo
          end  
        end
      end
      puts @list
      File.write("store.json", @list.to_json)
      

      # todo_Card.add_todo()
      
    when "In Progress"
      puts "in progresssss :D"
    when "code review"
      puts "Code Review"
    when "done"
      puts "Done"
    else
      puts "invalid option: class CheckList: ln: 187"
    end
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
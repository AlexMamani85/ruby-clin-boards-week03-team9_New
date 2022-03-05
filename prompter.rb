module Prompter
  def main_menu
    
    print "> "
    action, id = gets.chomp.split
    [action, id]
  end

  def list_form
    print "Name: "
    name = gets.chomp
    print "Description: "
    description = gets.chomp
    return { name: name, description: description } unless name.nil? & description.nil?
    nil
  end
end
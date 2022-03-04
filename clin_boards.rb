require "json"

class ClinBoards
  def initialize
    # Complete this
  end

  def start
    # Complete this
  end
end

def banner
  print "  ####################################
  #      Welcome to CLIn Boards      #
  ####################################\n"
end

def menu
  print  "Board options: create | show ID | update ID | delete ID\n exit\n"
  print "> "
  action = gets.chomp
end

store = JSON.parse(File.read("store.json"), { symbolize_names: true })

# get the command-line arguments if neccesary
# app = ClinBoards.new
# app.start

banner
menu
p store
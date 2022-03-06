require "json"
class Card
  attr_reader :id, :title, :members, :labels, :checklist

  @@id_sequence = 0
  def initialize(title:, members:, labels:, due_date:, checklist:, id: nil)
    set_id(id)
    @id = id
    @title = title
    @members = members
    @due_date = due_date
    @labels = labels
    @checklist = []
  end

  def set_id(id)
    if id.nil?
      @id = (@@id_sequence += 1)
    elsif @id == id
      @@id_sequence = id if id > @@id_sequence
    end
  end

  def to_json(_options = nil)
    { id: @id, name: @title, members: @members, due_date: @due_date, labels: @labels, checklist: @checklist }.to_json
  end

  def add_todo(store, _new_todo)
    store << new_tore
  end
end

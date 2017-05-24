require_relative 'entry' #load the library entry.rb relative to address_book.rb's file path

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry| #compare name with name of current entry. If it lexicographically proceeds entry.name, we've found the index to insert at. Otherwise we increment index and continue comparing with the other entries
      if name < entry.name
        break
      end
      index+= 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

end

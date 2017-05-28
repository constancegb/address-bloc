require_relative 'entry' #load the library entry.rb relative to address_book.rb's file path
require "csv"

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

  def import_from_csv(file_name)
    csv_text = File.read(file_name) #reads the file
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true) # create an object of type CSV::Table
    # We iterate over each row to create a hash and add it to AddressBook
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

end

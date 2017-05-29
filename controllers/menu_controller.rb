require_relative '../models/address_book'

 class MenuController
   attr_reader :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
     puts "Main Menu - #{address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - View Entry Number n"
     puts "6 - Exit"
     print "Enter your selection: "

     selection = gets.to_i
     puts "You picked #{selection}"

   case selection
     when 1
       system "clear"
       view_all_entries
       main_menu
     when 2
       system "clear"
       create_entry
       main_menu
     when 3
       system "clear"
       search_entries
       main_menu
     when 4
       system "clear"
       read_csv
       main_menu
     when 5
       system "clear"
       print "Enter entry number: "
       entry_number = gets.chomp.to_i
       if entry_number > address_book.entries.length
         puts "Sorry, there are only #{address_book.entries.length} entry(ies) in address_book"
       else
         puts address_book.entries[entry_number]
       end
     when 6
       puts "Good-bye!"
       exit(0) # terminates the program
     else
       system "clear"
       puts "Sorry, that is not a valid input"
       main_menu
     end
   end

   def view_all_entries
     address_book.entries.each do |entry|
       system "clear"
       puts entry.to_s
       # entry_submenu will be used to create a submenu for each entry. See method under
       entry_submenu(entry)
     end
     system "clear"
     puts "End of entries"
   end

   def create_entry
     system "clear"
     puts "New AddressBloc Entry"
     print "Name: "
     name = gets.chomp
     print "Phone number: "
     phone = gets.chomp
     print "Email: "
     email = gets.chomp
     # add a new Entry to address_book
     address_book.add_entry(name, phone, email)

     system "clear"
     puts "New entry created"
   end

   def search_entries
     print "Search by name: "
     name = gets.chomp
     match = address_book.binary_search(name) #return a match or nil, never an empty string since import_from_csv fail if an entry doesn't have a name.
     system "clear"
     # #11
     if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
   end

   def read_csv
     print "Enter CSV file to import: "
     file_name = gets.chomp
     if file_name.empty?
       system "clear"
       puts "No CSV file read"
       main_menu
     end
     #
     begin
       entry_count = address_book.import_from_csv(file_name).count
       system "clear"
       puts "#{entry_count} new entries added from #{file_name}"
     rescue
       puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
       read_csv
     end
   end

   def entry_submenu(entry)
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     # chomp removes any trailing whitespace from the string returned by gets.
     selection = gets.chomp

     case selection
     # #18
       when "n"
     # #19
       when "d"
         delete_entry(entry)
       when "e"
         edit_entry(entry)
         entry_submenu(entry)
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         entry_submenu(entry)
     end
    end

    def delete_entry(entry)
     address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"
     puts "Updated entry:"
     puts entry
   end

   def search_submenu(entry)
     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     selection = gets.chomp

     case selection
       when "d"
         system "clear"
         delete_entry(entry)
         main_menu
       when "e"
         edit_entry(entry)
         system "clear"
         main_menu
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         puts entry.to_s
         search_submenu(entry)
     end
   end


end

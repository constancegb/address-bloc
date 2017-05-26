require_relative 'controllers/menu_controller'

 # We create a new MenuController when AddressBloc starts
 menu = MenuController.new
 # #5
 system "clear" #clears the command line
 puts "Welcome to AddressBloc!"
 # Call main_menu on the newly created menu 
 menu.main_menu

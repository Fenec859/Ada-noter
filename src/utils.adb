
with Gdk.Event;
with Gtk.Enums;
with Gtk.Window;
with Gtk.Main;
with Gtk.Menu_Shell;
with Gtk.Menu;
with Gtk.Menu_Bar;
with Gtk.Menu_Item;
with Glib.Object;

with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Characters.Latin_1;

with Text_Field;  

package body Utils is



	
	function On_Quit(
		Self  : access Glib.Object.GObject_Record'Class;
		Event : Gdk.Event.Gdk_Event
		)
	return Boolean 
	is
	begin
		Ada.Text_IO.Put_Line("Closing application");
		Gtk.Main.Main_Quit;
		return False;
	end On_Quit;
		



	procedure On_Quit(
		Self  : access Glib.Object.GObject_Record'Class
		)
	is
	begin
		Ada.Text_IO.Put_Line("Quit button clicked, closing application");
		Gtk.Main.Main_Quit;

	end On_Quit;


	procedure On_Open(
		Self  : access Glib.Object.GObject_Record'Class
		)
	is
		use Ada.Text_IO;
		use Ada.Strings.Unbounded;
		use Ada.Characters.Latin_1;
		Char_Bound : constant Natural := 255;
		Text : Unbounded_String := Null_Unbounded_String;
		F : File_Type;
		File_Name : constant String := "test_file.txt";
	
	begin
		
		Put_Line("Open button clicked");
		
		--Reading from file "test_file.txt"
		
		Open(F, In_File, File_Name);


		while not End_Of_File(F) loop
			Text := Text & To_Unbounded_String(Get_Line(F)) & LF;
		end loop;
		Text_Field.Set_Text(To_String(Text));

	exception
		
		when Name_Error =>
			Put_Line("File " & File_Name & " does not exist.");
		when others =>
			Put_Line("Error while processing file " & File_Name);

	end On_Open;



	procedure On_Save(
		Self  : access Glib.Object.GObject_Record'Class
		)
	is	
		use Ada.Text_IO;

		Text : String := Text_Field.Get_Text;
		F : File_Type;
		File_Name : constant String := "test_file.txt";

	begin

		-- Writing to file "test_file.txt"
		Open(F, Out_File, File_Name);
		Put_Line(F, Text);
		Close(F);
	
	exception
		
		when Name_Error =>
			Put_Line("File " & File_Name & " does not exist.");
		when others =>
			Put_Line("Error while processing file " & File_Name);

	end On_Save;


	
	


	function Menu_Bar_Init 
	return Gtk.Menu_Bar.Gtk_Menu_Bar
	is


		Menu_Bar    : Gtk.Menu_Bar.Gtk_Menu_Bar;
		File_Menu   : Gtk.Menu.Gtk_Menu;
		File_MI     : Gtk.Menu_Item.Gtk_Menu_Item;
		Open_MI     : Gtk.Menu_Item.Gtk_Menu_Item;
		Save_MI     : Gtk.Menu_Item.Gtk_Menu_Item;
		Quit_MI     : Gtk.Menu_Item.Gtk_Menu_Item;
	begin


		Menu_Bar  := Gtk.Menu_Bar.Gtk_Menu_Bar_New;
		File_Menu := Gtk.Menu.Gtk_Menu_New;

		File_MI := Gtk.Menu_Item.Gtk_Menu_Item_New_With_Label("File");
		Open_MI := Gtk.Menu_Item.Gtk_Menu_Item_New_With_Label("Open");
		Save_MI := Gtk.Menu_Item.Gtk_Menu_Item_New_With_Label("Save");
		Quit_MI := Gtk.Menu_Item.Gtk_Menu_Item_New_With_Label("Quit");

		Gtk.Menu_Bar.Append(
			Menu_Shell => Menu_Bar, 
			Child      => File_MI
			);

		Gtk.Menu_Item.Set_Submenu(
			Menu_Item => File_MI,
			Submenu   => File_Menu
			);

		Gtk.Menu.Attach(
			Menu          => File_Menu,
			Child         => Open_MI,
			Left_Attach   => 0,
			Right_Attach  => 1,
			Top_Attach    => 0,
			Bottom_Attach => 1
			);
		
		Gtk.Menu.Attach(
			Menu          => File_Menu,
			Child         => Save_MI,
			Left_Attach   => 0,
			Right_Attach  => 1,
			Top_Attach    => 1,
			Bottom_Attach => 2
			);

		Gtk.Menu_Item.On_Activate(
			Self  => Open_MI,
			Call  => On_Open'Access,
			Slot  => Open_MI,
			After => False);

		Gtk.Menu_Item.On_Activate(
			Self  => Save_MI,
			Call  => On_Save'Access,
			Slot  => Save_MI,
			After => False);
		
		Gtk.Menu.Attach(
			Menu          => File_Menu,
			Child         => Quit_MI,
			Left_Attach   => 0,
			Right_Attach  => 1,
			Top_Attach    => 2,
			Bottom_Attach => 3
			);

		Gtk.Menu_Item.On_Activate(
			Self  => Quit_MI,
			Call  => On_Quit'Access,
			Slot  => Quit_MI,
			After => False);

		return Menu_Bar;
	end Menu_Bar_Init;


end Utils;
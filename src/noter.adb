with Ada.Text_IO;
with Gdk.Event;
with Gtk.Main;
with Gtk.Window;
with Gtk.Box;
with Gtk.Menu_Bar;
with Gtk.Text_Buffer;
with Gtk.Text_View;
with Glib.Object;

with Gtk.Enums;

with Utils; 
with Text_Field;

use Utils;
use Text_Field;
procedure Noter is 

	Main_Window : Gtk.Window.Gtk_Window;
	Vbox        : Gtk.Box.Gtk_Vbox;
	Text_Port   : Text_Field.Text_Field_Record;
	Menu_Bar    : Gtk.Menu_Bar.Gtk_Menu_Bar;




	function Main_Window_Init
	return Gtk.Window.Gtk_Window
	is
		Main_Window : Gtk.Window.Gtk_Window;
	begin

		Main_Window := Gtk.Window.Gtk_Window_New(
		The_Type => Gtk.Enums.Window_Toplevel
		);

	Gtk.Window.Set_Title(
		Window => Main_Window, 
		Title  => "Noter"
		);

	Gtk.Window.Set_Default_Size(
		Window => Main_Window,
		Height => 600,
		Width  => 600
		);


	Gtk.Window.On_Delete_Event(
		Self  => Main_Window,
		Call  => On_Quit'Access,
		Slot  => Main_Window,
		After => False
		);

		return Main_Window;
	end Main_Window_Init;



begin

	Ada.Text_IO.Put_Line("Hello, World!");

	-- Gtk.Main.Set_Locale;
	Gtk.Main.Init;

	Main_Window := Main_Window_Init;


	Vbox := Gtk.Box.Gtk_Vbox_New(
		Homogeneous => False,
		Spacing     => 0
		);

	Gtk.Window.Add(
		Container => Main_Window, 
		Widget    => Vbox
		);

	Menu_Bar := Menu_Bar_Init;
	Text_Port := Text_Field_Init;



	Gtk.Box.Pack_Start(
		In_Box  => Vbox,
		Child   => Menu_Bar,
		Expand  => False,
		Fill    => True,
		Padding => 0
		);

	Gtk.Text_View.Set_Editable(
		View    => Text_Port.Text_View,
		Setting => True
		);

	Gtk.Text_Buffer.Set_Text(
		Buffer => Text_Port.Text_Buffer,
		Text   => "Lorem ipsum"
		);
	
	Gtk.Box.Pack_Start(
		In_Box  => Vbox,
		Child   => Text_Port.Text_View,
		Expand  => True,
		Fill    => True,
		Padding => 0
		);


	Gtk.Window.Show_All(Main_Window);
	Gtk.Main.Main;


end Noter;


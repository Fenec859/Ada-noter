with Gtk.Menu_Bar;
with Gtk.Window;
with Gdk.Event;
with Glib.Object;

package Utils is

	function On_Quit(
		Self  : access Glib.Object.GObject_Record'Class;
		Event : Gdk.Event.Gdk_Event
		)
	return Boolean;

	function Menu_Bar_Init 
	return Gtk.Menu_Bar.Gtk_Menu_Bar;


end Utils;
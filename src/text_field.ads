with Gtk.Text_Buffer;
with Gtk.Text_View;
package Text_Field is

	type Text_Field_Record is record
		Text_View   : Gtk.Text_View.Gtk_Text_View;
		Text_Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
	end record;


	function Text_Field_Init 
	return Text_Field_Record;

	function Get_Text
	return String;

	procedure Set_Text(
		Text : String
		);

end Text_Field;
with Gtk.Text_Iter;

package body Text_Field is

	
	Text_Field_Signleton : Text_Field_Record;

	function Text_Field_Init
	return Text_Field_Record
	is
		Text_Buffer : Gtk.Text_Buffer.Gtk_Text_Buffer;
		Text_View	: Gtk.Text_View.Gtk_Text_View;
	begin
		Text_Buffer := Gtk.Text_Buffer.Gtk_Text_Buffer_New(null);
		Text_View   := Gtk.Text_View.Gtk_Text_View_New_With_Buffer(Text_Buffer);
		Text_Field_Signleton := Text_Field_Record'(Text_Buffer => Text_Buffer, Text_View => Text_View); 
		return Text_Field_Signleton;

	end Text_Field_Init;




	function Get_Text
	return String
	is
		Start_i :  Gtk.Text_Iter.Gtk_Text_Iter;
		End_i :  Gtk.Text_Iter.Gtk_Text_Iter;
	begin
		Gtk.Text_Buffer.Get_Bounds(
			Buffer  => Text_Field_Signleton.Text_Buffer,
			Start   => Start_i,
			The_End => End_i
			);

		return Gtk.Text_Buffer.Get_Text(
			Buffer               => Text_Field_Signleton.Text_Buffer,
			Start                => Start_i,
			The_End              => End_i,
			Include_Hidden_Chars => False
			);

	end Get_Text;

	procedure Set_Text(
		Text : String
		)
	is
	begin
		Gtk.Text_Buffer.Set_Text(
			Buffer => Text_Field_Signleton.Text_Buffer,
			Text   => Text
			);
	end Set_Text;


end Text_Field;
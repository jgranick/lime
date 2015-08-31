package lime.system;


#if flash
import flash.desktop.Clipboard in FlashClipboard;
#end


class Clipboard {
	
	
	public static var text (get, set):String;
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private static function get_text ():String {
		
		#if (cpp || neko || nodejs)
		return lime_clipboard_get_text.call ();
		#elseif flash
		if (FlashClipboard.generalClipboard.hasFormat (TEXT_FORMAT)) {
			
			return FlashClipboard.generalClipboard.getData (TEXT_FORMAT);
			
		}
		#end
		
		return null;
		
	}
	
	
	private static function set_text (value:String):String {
		
		#if (cpp || neko || nodejs)
		lime_clipboard_set_text.call (value);
		return value;
		#elseif flash
		FlashClipboard.generalClipboard.setData (TEXT_FORMAT, value);
		return value;
		#end
		
		return null;
		
	}
	
	
	
	
	// Native Methods
	
	
	
	
	#if (cpp || neko || nodejs)
	private static var lime_clipboard_get_text = System.loadPrime ("lime", "lime_clipboard_get_text", "s");
	private static var lime_clipboard_set_text = System.loadPrime ("lime", "lime_clipboard_set_text", "sv");
	#end
	
	
}
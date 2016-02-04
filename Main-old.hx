import flash.accessibility.AccessibilityProperties;
import flash.accessibility.Accessibility;
import flash.display.Sprite;
import flash.events.FocusEvent;
import flash.external.ExternalInterface;
import flash.system.Capabilities;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

class Main {
	static function main() {
		var current = flash.Lib.current;
		// Create sprites
		current.addChild(makeSprite("Name 1", "Description 1", 0xFF0000, 0));
		current.addChild(makeSprite("Name 2", "Description 2", 0x0000FF, 1));
		var sprite = makeSprite("Name 3", "Description 3", 0x00FF00, 2);
		sprite.addEventListener(FocusEvent.FOCUS_OUT, function(_) {
			ExternalInterface.call("goAhead");
		});
		current.addChild(sprite);

		// Setup accessibility
		var accessProps = new AccessibilityProperties();
		accessProps.name = "Moon orbiting planet";
		accessProps.forceSimple = true;
		current.accessibilityProperties = accessProps;
		if (Capabilities.hasAccessibility) {
			Accessibility.updateProperties();
		}
	}

	static function makeSprite(name:String, desc:String, color:UInt, tabIndex:Int) {
		// Create and position element
		var sprite = new Sprite();
		sprite.tabIndex = tabIndex;
		sprite.x = tabIndex * 110 + 10;
		sprite.y = 10;
		sprite.addEventListener(FocusEvent.FOCUS_IN, function(_) {
			Accessibility.sendEvent(sprite, 0, 0x8005);
		});
		// Draw something
		var g = sprite.graphics;
		g.beginFill(color);
		g.drawRect(0, 0, 100, 100);
		g.endFill();
		// Create text field and add it to element
		var tf = new TextField();
		tf.text = name;
		tf.autoSize = TextFieldAutoSize.CENTER;
		tf.y = 50 - tf.textHeight / 2;
		tf.type = flash.text.TextFieldType.DYNAMIC;
		sprite.addChild(tf);
		// Create access props
		var accessProps = new AccessibilityProperties();
		accessProps.name = name;
		accessProps.description = desc;
		sprite.accessibilityProperties = accessProps;
		return sprite;
	}
}
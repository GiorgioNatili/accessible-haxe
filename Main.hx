import flash.accessibility.AccessibilityProperties;
import flash.accessibility.Accessibility;
import flash.display.Sprite;
import flash.display.DisplayObjectContainer;
import flash.events.FocusEvent;
import flash.external.ExternalInterface;
import flash.system.Capabilities;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;

class Main {
  static function main() {
    var current = flash.Lib.current;
    // Create sprites

    makeSprite("Button name 1", 0xFF0000, 1, 0x800a);
    makeSprite("Button name 2", 0x00FF00, 2, 0x800c);

    var sprite = makeSprite("Button name 3", 0x0000FF, 3, 0x8005);
    sprite.addEventListener(FocusEvent.FOCUS_OUT, function(_) {
        ExternalInterface.call("goAhead");
    });

    // Setup accessibility
    current.accessibilityProperties = new AccessibilityProperties();
    current.accessibilityProperties.name = "Testing the accessibility planet";
    current.accessibilityProperties.forceSimple = true;

    Accessibility.updateProperties();
    
    if (Capabilities.hasAccessibility) {
      Accessibility.updateProperties();
    }
  }

  static function makeSprite(name:String, color:UInt, tabIndex:Int, event:Int) {

    var textField:TextField = new TextField();
    textField.name = "textField";
    textField.mouseEnabled = false;

    textField.text = name;

    var rectangleShape:Shape = new Shape();
    rectangleShape.graphics.beginFill(color);
    rectangleShape.graphics.drawRect(0, 0, 100, 25);
    rectangleShape.graphics.endFill();

    var simpleButtonSprite:Sprite = new Sprite();
    simpleButtonSprite.name = "simpleButtonSprite";
    simpleButtonSprite.addChild(rectangleShape);
    simpleButtonSprite.addChild(textField);

    var simpleButton:SimpleButton = new SimpleButton();
    simpleButton.upState = simpleButtonSprite;
    simpleButton.overState = simpleButtonSprite;
    simpleButton.downState = simpleButtonSprite;
    simpleButton.hitTestState = simpleButtonSprite;

    simpleButton.y = 10;
    simpleButton.x = tabIndex * 110 + 10;

    simpleButton.addEventListener(FocusEvent.FOCUS_IN, function(_) {
        Accessibility.sendEvent(simpleButton, 0, event);
    });

    flash.Lib.current.addChild(simpleButton);

    simpleButton.accessibilityProperties = new AccessibilityProperties();
    simpleButton.accessibilityProperties.name = "I am really accessible";

    return simpleButton;

  }

}

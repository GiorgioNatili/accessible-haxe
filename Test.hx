import flash.display.Shape;
import flash.display.Sprite;
import flash.display.SimpleButton;
import flash.text.TextField;
import flash.accessibility.AccessibilityProperties;
import flash.accessibility.Accessibility;
import flash.display.DisplayObjectContainer;

class Test {
  static function main() {
    var mc:flash.display.MovieClip = flash.Lib.current;
    
    mc.addChild(makeButton('Button 1', 0xFF0000));
  
  }

  static function makeButton(name:String, color:UInt) {
  
    var textField:TextField = new TextField();
    textField.name = "textField";
    textField.mouseEnabled = false;
    
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

    var sbs:DisplayObjectContainer = new DisplayObjectContainer();
    sbs.addChild(simpleButton.upState);

    //local textField object
    var tf:TextField = cast(sbs.getChildByName('textField'), TextField);
    tf.text = "simple button test";
    
    simpleButton.accessibilityProperties = new AccessibilityProperties();
    simpleButton.accessibilityProperties.name = "I am accessible";
    simpleButton.accessibilityProperties.description = "I am accessible" + name;
    
    return simpleButton;
    
  }


}

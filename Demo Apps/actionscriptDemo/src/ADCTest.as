
package  {

  import flash.utils.ByteArray;
  import flash.data.EncryptedLocalStore;
  import flash.display.MovieClip;
  import com.jirbo.airadc.AirAdColony;
  import flash.events.StatusEvent;
  import flash.events.TouchEvent;
  import flash.ui.Multitouch;
  import flash.ui.MultitouchInputMode;
  import flash.utils.setTimeout;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextField;
  import flash.geom.Rectangle;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.display.Stage;
  import flash.system.Capabilities;

  public class ADCTest extends MovieClip {

    public static var AdColony:AirAdColony;
    private var cur_app_id:String;
    private var cur_video_zone:String;
    private var cur_v4vc_zone:String;
    private var cur_v4vc_name:String;
    private var cur_v4vc_amount:int;

	 private const ios_app_id:String = "appbdee68ae27024084bb334a";
	 private var ios_video_zone:String = "vzf8fb4670a60e4a139d01b5";
	 private var ios_v4vc_zone:String = "vzf8e4e97704c4445c87504e";

	 private var android_app_id:String = "app185a7e71e1714831a49ec7";
	 private var android_video_zone:String = "vz06e8c32a037749699e7050";
	 private var android_v4vc_zone:String = "vz1fd5a8b2bf6841a0a4b826";

    public function ADCTest() {
     AdColony = new AirAdColony();
     scaleUI();
     if (AdColony.isSupported())
     {
      AdColony.adcContext.addEventListener(StatusEvent.STATUS, handleAdColonyEvent);
      if (AdColony.is_iOS)
      {
       cur_app_id = ios_app_id;
       cur_video_zone = ios_video_zone;
       cur_v4vc_zone = ios_v4vc_zone;
     }
     else
     {
       cur_app_id = android_app_id;
       cur_video_zone = android_video_zone;
       cur_v4vc_zone = android_v4vc_zone;
     }
     AdColony.configure("1.0",cur_app_id,cur_video_zone,cur_v4vc_zone);
   }
   else
   {
    trace("AdColony not supported.");
  }

}

public static const IPHONE_1G:String = "iPhone1,1"; // first gen is 1,1
public static const IPHONE_3G:String = "iPhone1"; // second gen is 1,2
public static const IPHONE_3GS:String = "iPhone2"; // third gen is 2,1
public static const IPHONE_4:String = "iPhone3"; // normal:3,1 verizon:3,3
public static const IPHONE_4S:String = "iPhone4"; // 4S is 4,1
public static const IPHONE_5PLUS:String = "iPhone";
public static const TOUCH_1G:String = "iPod1,1";
public static const TOUCH_2G:String = "iPod2,1";
public static const TOUCH_3G:String = "iPod3,1";
public static const TOUCH_4G:String = "iPod4,1";
public static const TOUCH_5PLUS:String = "iPod";
public static const IPAD_1:String = "iPad1"; // iPad1 is 1,1
public static const IPAD_2:String = "iPad2"; // wifi:2,1 gsm:2,2 cdma:2,3
public static const IPAD_3:String = "iPad3"; // (guessing)
public static const IPAD_4PLUS:String = "iPad";
public static const UNKNOWN:String = "unknown";

private static const IOS_DEVICES:Array = [IPHONE_1G, IPHONE_3G, IPHONE_3GS,
    IPHONE_4, IPHONE_4S, IPHONE_5PLUS, IPAD_1, IPAD_2, IPAD_3, IPAD_4PLUS,
    TOUCH_1G, TOUCH_2G, TOUCH_3G, TOUCH_4G, TOUCH_5PLUS];

public static function getDevice():String {
    var info:Array = Capabilities.os.split(" ");
    if (info[0] + " " + info[1] != "iPhone OS") {
        return UNKNOWN;
    }

    // ordered from specific (iPhone1,1) to general (iPhone)
    for each (var device:String in IOS_DEVICES) {
        if (info[3].indexOf(device) != -1) {
            return device;
        }
    }
    return UNKNOWN;
}

function scaleUI():void
{
	  // get reference t stage
    var stage:Stage = video_button.stage;
	stage.scaleMode = StageScaleMode.NO_SCALE;
    stage.align = StageAlign.TOP_LEFT;
	var dpi:Number = Capabilities.screenDPI;
	var serverString:String = unescape(Capabilities.serverString);
	var reportedDpi:Number = Number(serverString.split("&DP=", 2)[1]);
	var scale = 1;

	var guiSize:Rectangle = new Rectangle(0,0,480,800);
    var appSize:Rectangle = new Rectangle(0,0,stage.fullScreenWidth,stage.fullScreenHeight);
	var deviceSize:Rectangle = appSize.clone();

	if ((deviceSize.width / deviceSize.height) > (guiSize.width / guiSize.height)) {
		//device is wider than GUI's aspect ratio, height determines scale
		scale = appSize.height / guiSize.height;
		appSize.width = deviceSize.width / scale;
	}
	else {
		//device is taller than GUI's aspect ratio, width determines scale
		scale = deviceSize.width / guiSize.width;
		appSize.height = deviceSize.height / scale;
	}


	  //set scaleX and scaleY of all gui elements to be the calculated scale
    version_label.scaleX = version_label.scaleY = v4vc_counter_label.scaleX = v4vc_counter_label.scaleY = video_button_label.scaleX = video_button_label.scaleY = v4vc_button_label.scaleX = v4vc_button_label.scaleY = adc_logo.scaleX = adc_logo.scaleY = video_button.scaleX = video_button.scaleY = v4vc_button.scaleX = v4vc_button.scaleY = scale;

	  //center all gui elements and ensure reasonable spacing between each element.
    adc_logo.x = (deviceSize.width / 2) - (adc_logo.width / 2);
    version_label.x = (deviceSize.width / 2) - (version_label.width / 2);
    version_label.y = adc_logo.y + adc_logo.height;
    video_button.x = (deviceSize.width / 2) - (video_button.width / 2);
    video_button.y = version_label.y + version_label.height + 20;
    v4vc_button.x = (deviceSize.width / 2) - (v4vc_button.width / 2);
    v4vc_button.y = video_button.y + video_button.height + 20;
    video_button_label.x = (deviceSize.width / 2) - (video_button_label.width / 2);
    video_button_label.autoSize = TextFieldAutoSize.CENTER;
    video_button_label.y = video_button.y + ((video_button.height / 2) - (video_button_label.height / 2));
    v4vc_button_label.x = (deviceSize.width / 2) - (v4vc_button_label.width / 2);
    v4vc_button_label.autoSize = TextFieldAutoSize.CENTER;
    v4vc_button_label.y = v4vc_button.y + ((v4vc_button.height / 2) - (v4vc_button_label.height / 2));
    v4vc_counter_label.x = (deviceSize.width / 2) - (v4vc_counter_label.width / 2);
    v4vc_counter_label.autoSize = TextFieldAutoSize.CENTER;
    v4vc_counter_label.y = v4vc_button.y + v4vc_button.height + 10;
  }

  function resetV4VCCounter():void
  {
      //get and store new v4vc name
      cur_v4vc_name = AdColony.getV4VCName(cur_v4vc_zone);
      var ba_name:ByteArray = new ByteArray();
      ba_name.writeUTF(cur_v4vc_name);
      EncryptedLocalStore.setItem("v4vc_name", ba_name);
      //store new total as 0
      var ba_amount:ByteArray = new ByteArray();
      cur_v4vc_amount = 0;
      ba_amount.writeInt(cur_v4vc_amount);
      EncryptedLocalStore.setItem("v4vc_amount", ba_amount);
    }

	public function updateButtonText(success:Boolean,updated_zone:String):void
	{
	  if (updated_zone == cur_video_zone) {
		if (success) {
		  video_button_label.text = "Play Video - Ready";
		}
		else {
		  video_button_label.text = "Play Video - NOT READY";
		}
	  }
	  else if (updated_zone == cur_v4vc_zone) {
		if (success) {
		  v4vc_button_label.text = "Play V4VC - Ready";
		var ba_v4vc_name:ByteArray = EncryptedLocalStore.getItem("v4vc_name");
		if (!ba_v4vc_name)
		{
		  resetV4VCCounter();
		}
		else
		{
		  cur_v4vc_name = ba_v4vc_name.readUTF();
		  if (cur_v4vc_name != AdColony.getV4VCName(cur_v4vc_zone))
		  {
			resetV4VCCounter();
		  }
		  var ba_v4vc_amount:ByteArray = EncryptedLocalStore.getItem("v4vc_amount");
		  cur_v4vc_amount = ba_v4vc_amount.readInt();
		}
		v4vc_counter_label.text = "V4VC Info: " + cur_v4vc_amount + " " + cur_v4vc_name;
		}
		else {
		  v4vc_button_label.text = "Play V4VC - NOT READY";
		}
	  }
	}

    //AdColony Event Handler
	public function handleAdColonyEvent(event:StatusEvent):void {
	  if(event.level == "AdColony")
	  {
		if(event.code == "AdStarted")
		{
		  trace("Ad start");
		}
		else if (event.code.indexOf("AdFinished") >= 0)
		{
		  //AdFinished Event is delimited by |
		  //Format is AdFinished|success
		  var adFinish_arr:Array = event.code.split('|');
		  //if success is true
		  if (adFinish_arr[1] == "true") {
			trace("AdFinished: Ad Play Success");
		  }
		  else {
			trace("AdFinished: Ad Play Fail");
		  }
		  // updateButtonText(1);
		}
		else if (event.code.indexOf("V4VCReward") >= 0)
		{
		  //V4VCReward Event is delimited by |
		  //Order is V4VCReward|success|amount|name
		  var v4vc_arr:Array = event.code.split("|");
		  if(v4vc_arr[1] == "true")
		  {
			trace("V4VC Success");
			if (v4vc_arr[3] != cur_v4vc_name)
			{
			  resetV4VCCounter();
			}
			cur_v4vc_amount += int(v4vc_arr[2]);
			var ba_v4vc_amount:ByteArray = new ByteArray();
			ba_v4vc_amount.writeInt(cur_v4vc_amount);
			EncryptedLocalStore.setItem("v4vc_amount", ba_v4vc_amount);
			v4vc_counter_label.text = "V4VC Info: " + cur_v4vc_amount + " " + cur_v4vc_name;
		  }
		  else
		  {
			trace("V4VC Fail");
		  }
		}
		else if (event.code.indexOf("AdAvailabilityChange") >= 0) {
		  //AdAvailabilityChange Event is delimited by |
		  //Order is AdAvailabilityChange|available|zone
		  var args_arr:Array = event.code.split("|");
		  var outcome:Boolean = false;
          if (args_arr[1] == 'true') outcome = true;
		  updateButtonText(outcome,args_arr[2]);
		}
	  }
	}

  }
}

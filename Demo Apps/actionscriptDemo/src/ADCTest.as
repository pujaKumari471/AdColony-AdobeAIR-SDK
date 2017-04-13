package {
	import flash.display.MovieClip;
	import com.adcolony.airadc.*;
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
		private const IOS_APP_ID: String = "appbdee68ae27024084bb334a";
		private const IOS_VIDEO_ZONE: String = "vzf8fb4670a60e4a139d01b5";
		private const IOS_V4VC_ZONE: String = "vzf8e4e97704c4445c87504e";

		private const ANDROID_APP_ID: String = "app185a7e71e1714831a49ec7";
		private const ANDROID_VIDEO_ZONE: String = "vz06e8c32a037749699e7050";
		private const ANDROID_V4VC_ZONE: String = "vz1fd5a8b2bf6841a0a4b826";
		
		public static const IPHONE_1G: String = "iPhone1,1"; // first gen is 1,1
		public static const IPHONE_3G: String = "iPhone1"; // second gen is 1,2
		public static const IPHONE_3GS: String = "iPhone2"; // third gen is 2,1
		public static const IPHONE_4: String = "iPhone3"; // normal:3,1 verizon:3,3
		public static const IPHONE_4S: String = "iPhone4"; // 4S is 4,1
		public static const IPHONE_5PLUS: String = "iPhone";
		public static const TOUCH_1G: String = "iPod1,1";
		public static const TOUCH_2G: String = "iPod2,1";
		public static const TOUCH_3G: String = "iPod3,1";
		public static const TOUCH_4G: String = "iPod4,1";
		public static const TOUCH_5PLUS: String = "iPod";
		public static const IPAD_1: String = "iPad1"; // iPad1 is 1,1
		public static const IPAD_2: String = "iPad2"; // wifi:2,1 gsm:2,2 cdma:2,3
		public static const IPAD_3: String = "iPad3"; // (guessing)
		public static const IPAD_4PLUS: String = "iPad";
		public static const UNKNOWN: String = "unknown";

		private static const IOS_DEVICES: Array = [IPHONE_1G, IPHONE_3G, IPHONE_3GS,
			IPHONE_4, IPHONE_4S, IPHONE_5PLUS, IPAD_1, IPAD_2, IPAD_3, IPAD_4PLUS,
			TOUCH_1G, TOUCH_2G, TOUCH_3G, TOUCH_4G, TOUCH_5PLUS];

		public static var AdColony: AirAdColony;
		private var interstitialVideoAd:AdColonyInterstitial;
		private var interstitialV4vcAd:AdColonyInterstitial;
		private var currAppId: String;
		private var currVideoZone: String;
		private var currV4vcZone: String;
		private var currRewardName: String;
		private var currRewardAmount: Number;

		public function ADCTest() {
			AdColony = new AirAdColony();
			scaleUI();
			if (AdColony.isSupported()) {
				AdColony.addEventListener(AdColonyInterstitialEvent.EVENT_TYPE, handleInterstitialEvent);
				AdColony.addEventListener(AdColonyRewardEvent.EVENT_TYPE, handleRewardEvent);
				
				if (AdColony.isIos) {
					currAppId = IOS_APP_ID;
					currVideoZone = IOS_VIDEO_ZONE;
					currV4vcZone = IOS_V4VC_ZONE;
				} else {
					currAppId = ANDROID_APP_ID;
					currVideoZone = ANDROID_VIDEO_ZONE;
					currV4vcZone = ANDROID_V4VC_ZONE;
				}
				AdColony.configure(null, currAppId, currVideoZone, currV4vcZone);
			} else {
				trace("AdColony not supported.");
			}

		}

		public static function getDevice(): String {
			var info: Array = Capabilities.os.split(" ");
			if (info[0] + " " + info[1] != "iPhone OS") {
				return UNKNOWN;
			}

			// ordered from specific (iPhone1,1) to general (iPhone)
			for each(var device: String in IOS_DEVICES) {
				if (info[3].indexOf(device) != -1) {
					return device;
				}
			}
			return UNKNOWN;
		}

		function scaleUI(): void {
			// get reference t stage
			var stage: Stage = videoButton.stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			var dpi: Number = Capabilities.screenDPI;
			var serverString: String = unescape(Capabilities.serverString);
			var reportedDpi: Number = Number(serverString.split("&DP=", 2)[1]);
			var scale = 1;

			var guiSize: Rectangle = new Rectangle(0, 0, 480, 800);
			var appSize: Rectangle = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			var deviceSize: Rectangle = appSize.clone();

			if ((deviceSize.width / deviceSize.height) > (guiSize.width / guiSize.height)) {
				//device is wider than GUI's aspect ratio, height determines scale
				scale = appSize.height / guiSize.height;
				appSize.width = deviceSize.width / scale;
			} else {
				//device is taller than GUI's aspect ratio, width determines scale
				scale = deviceSize.width / guiSize.width;
				appSize.height = deviceSize.height / scale;
			}

			//center all gui elements and ensure reasonable spacing between each element.
			adcLogo.x = (deviceSize.width / 2) - (adcLogo.width / 2);
			adcLogo.y = 25;
			videoAdButton.x = (deviceSize.width / 2) - (videoAdButton.width / 2);
			videoAdButton.y = adcLogo.y + adcLogo.height + 50;
			v4vcAdButton.x = (deviceSize.width / 2) - (v4vcAdButton.width / 2);
			v4vcAdButton.y = videoAdButton.y + videoAdButton.height + 50;
			videoAdButtonLabel.x = (deviceSize.width / 2) - (videoAdButtonLabel.width / 2);
			videoAdButtonLabel.autoSize = TextFieldAutoSize.CENTER;
			videoAdButtonLabel.y = videoAdButton.y + ((videoAdButton.height / 2) - (videoAdButtonLabel.height / 2));
			v4vcAdButtonLabel.x = (deviceSize.width / 2) - (v4vcAdButtonLabel.width / 2);
			v4vcAdButtonLabel.autoSize = TextFieldAutoSize.CENTER;
			v4vcAdButtonLabel.y = v4vcAdButton.y + ((v4vcAdButton.height / 2) - (v4vcAdButtonLabel.height / 2));
			v4vcAdCounterLabel.x = (deviceSize.width / 2) - (v4vcAdCounterLabel.width / 2);
			v4vcAdCounterLabel.autoSize = TextFieldAutoSize.CENTER;
			v4vcAdCounterLabel.y = v4vcAdButton.y + v4vcAdButton.height + 25;
		}

		public function updateButtonText(adText: String, updated_zone: String): void {
			if (updated_zone == currVideoZone) {
				videoAdButtonLabel.text = "Play Video -- "+ adText;
	
			} else if (updated_zone == currV4vcZone) {
				v4vcAdButtonLabel.text = "Play V4VC -- "+ adText;
			}
		}
		
		public function handleInterstitialEvent(adEvent:AdColonyInterstitialEvent):void {
			var interstitialAd:AdColonyInterstitial = adEvent.getInterstitialAd();
			var zone:AdColonyZone = adEvent.getZone();

			var zoneStr:String = "";
			if (interstitialAd != null) {
				zoneStr = interstitialAd.getZoneId();
				if (zoneStr == currVideoZone) {
					interstitialVideoAd = interstitialAd;
				} else if (zoneStr == currV4vcZone) {
					interstitialV4vcAd = interstitialAd;
				}
			} else if (zone != null) {
				zoneStr = zone.getZoneId();
			}

			if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_CLICK) {
				updateButtonText("Clicked", zoneStr);
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_CLOSE) {
				updateButtonText("Closed", zoneStr);
				if (zoneStr == currVideoZone) {
					interstitialVideoAd = null;
				} else if (zoneStr == currV4vcZone) {
					interstitialV4vcAd = null;
				}
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_EXPIRING) {
				updateButtonText("Expiring", zoneStr);
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_IAP) {
				updateButtonText("on IAP", zoneStr);
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_LEFT_APP) {
				updateButtonText("Left App", zoneStr);
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_OPEN) {
				updateButtonText("Opened", zoneStr);
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_REQUEST_FILLED) {
				updateButtonText("Request Filled", zoneStr);
				if (interstitialV4vcAd != null) {
					AdColony.showInterstitial(interstitialV4vcAd);
				} else if (interstitialVideoAd != null) {
					AdColony.showInterstitial(interstitialVideoAd);
				}else {
					trace("No Ad Fill");
				}
			} else if (adEvent.getInterstitialEventType() == AirAdColonyDefines.INTERSTITIAL_EVENT_ON_REQUEST_NOT_FILLED) {
				updateButtonText("Request not Filled", zoneStr);
			}
		}

		public function handleRewardEvent(rewardEvent:AdColonyRewardEvent):void {
			var reward:AdColonyReward = rewardEvent.getReward();
			var newRewardName:String = reward.getRewardName();
			var newRewardAmount:Number = reward.getRewardAmount();
			if (currRewardName == null || newRewardName != currRewardName) {
				currRewardAmount = 0;
				currRewardName = newRewardName;
			}
			currRewardAmount += newRewardAmount;
			v4vcCounterLabel.text = "V4VC Info: " + currRewardAmount + " " + currRewardName;
		}

	}
}
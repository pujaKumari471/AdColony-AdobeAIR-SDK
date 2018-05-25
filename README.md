AdColony AIR Native Extension
==================================
- Modified: 2018/05/25
- Android SDK Version: 3.3.4
- iOS SDK Version: 3.3.4
- Native Extension Version: 3.3.4

## Overview AdColony delivers zero-buffering,
[full-screen Instant-Play™ HD video](https://www.adcolony.com/technology/instant-play/),
[interactive Aurora™ Video](https://www.adcolony.com/technology/auroravideo),
and Aurora™ Playable ads that can be displayed anywhere within your
application. Our advertising SDK is trusted by the world’s top gaming
and non-gaming publishers, delivering them the highest monetization
opportunities from brand and performance advertisers. AdColony’s SDK
can monetize a wide range of ad formats including in-stream/pre-roll,
out-stream/interstitial and V4VC™, a secure system for rewarding users
of your app with virtual currency upon the completion of video and
playable ads.

## Release Notes

#### Key Features of the SDK 3.3.4:

* General Data Protection Regulation (GDPR) compliance
* Several bug fixes, memory usage optimizations, and stability improvements

## To Download:

The simplest way to obtain the AdColony ANE is to click the "Download
ZIP" button located in the right-hand navigation pane of this page.

#### Contains:

* Demo Apps
  * actionscriptDemo
  * mxmlDemo
* Library
  * AirAdColony-GPS.ane
  * AirAdColony-no-GPS.ane
* W-9 Form.pdf

Getting Started with AdColony:
----------------------------------
Users should review the [documentation](https://github.com/AdColony/AdColony-AdobeAIR-SDK/wiki) to get started using our ANE.

Change Log (2018/05/25):
-----------------------------
* Update AdColony iOS to 3.3.4
* Update AdColony Android to 3.3.4
* Added a new API to pass user consent as required for compliance with
  the European Union's General Data Protection Regulation (GDPR). If
  you are collecting consent from your users, you can make use of this
  new API to inform AdColony and all downstream consumers of the
  consent. Please see our GDPR FAQ for more information and our GDPR
  wiki for implementation details.

Change Log (2018/02/13):
-----------------------------
* Update AdColony iOS to 3.3.1
* Update AdColony Android to 3.3.1

Change Log (2017/10/06):
-----------------------------
* Update AdColony iOS to 3.2.1
* Update AdColony Android to 3.2.1

Change Log (2017/04/13):
----------------------------------
* Update AdColony iOS to 3.1.1.
* Update AdColony Android to 3.1.2

Change Log (2016/12/05):
----------------------------------
* Update to AdColony iOS 2.6.3.

Change Log (2016/07/21):
----------------------------------
* Update to AdColony Android 2.3.6 and AdColony iOS 2.6.2. Fix bug that caused `cancelAd` to not correctly call the native method on Android.

Change Log (2016/04/21):
----------------------------------
* Update to AdColony Android 2.3.5.

Change Log (2016/03/30):
----------------------------------
* Update to AdColony Android 2.3.4 and AdColony iOS 2.6.1.

Change Log (2015/12/02):
----------------------------------
* Address issue affecting Android apps packaged with the shared AIR runtime.

Change Log (2015/11/09):
----------------------------------
* Lower the required AIR namespace to 3.7.

Change Log (2015/10/22):
----------------------------------
* Add new AdColony Event classes to allow easier handling of events. Please see the updated API in the wiki as well as the demo apps for examples. Update iOS SDK to 2.6.0. Update Android SDK to 2.3.0.

Change Log (2015/05/27):
----------------------------------
* Update iOS SDK to 2.5.1. Update ANE to better handle orientation in AIR apps.

Change Log (2015/02/26):
----------------------------------
* Update Android SDK to 2.2.1. Update iOS SDK to 2.5.0. Add 64 bit iOS support. Add Android x86 support.

Change Log (2014/11/17):
----------------------------------
* Update Android SDK to 2.1.3. Update iOS SDK to 2.4.13. Update Demo apps.

Change Log (2014/09/23):
----------------------------------
* Update Android SDK to 2.1.1. Update iOS SDK to 2.4.10. Repackage ANE for iOS.

Change Log (2014/06/04):
----------------------------------
* Update Android SDK to version 2.0.7. Fix default platform. Fix getCustomID for Android

Change Log (2014/05/05):
----------------------------------
* Update demo apps to use the AdAvailabilityChange event. Include default platform in the ANE.

Change Log (2014/04/25):
----------------------------------
* Fix issue where getV4VCAmount could cause a crash.

Change Log (2014/04/21):
----------------------------------
* Fix an issue that was causing iOS apps packaged with the AdColony ANE to be unecessarily large.

Change Log (2014/04/16):
----------------------------------
* Fix an issue that cause statusForZone to return "null".

Change Log (2013/12/09):
----------------------------------
* iOS SDK 2.2.4 integrated
* Android SDK 2.0.4 integrated
* Public class methods `StatusForZone` and `CancelAd` exposed.
* The `AdFinished` event code now includes a boolean. The change requires a small update to existing integrations. For more information, consult the `Updating from Earlier Versions` section of the AIR SDK documentation.

Sample Applications:
----------------------------------
Included are two sample apps to use as examples and for help on AdColony integration.


Legal Requirements:
----------------------------------
By downloading the AdColony SDK, you are granted a limited, non-commercial license to use and review the SDK solely for evaluation purposes.  If you wish to integrate the SDK into any commercial applications, you must register an account with AdColony and accept the terms and conditions on the AdColony website.

Note that U.S. based companies will need to complete the W-9 form and send it to us before publisher payments can be issued.


Contact Us:
----------------------------------
For more information, please visit AdColony.com. For questions or assistance, please email us at support@adcolony.com.

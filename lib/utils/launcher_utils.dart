import 'package:goresy/utils/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static Future<void> launch(String url) async {
    try {
      final launchUri = Uri.tryParse(url);

      if (launchUri != null && await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch uri.';
      }
    } catch (e, stackTrace) {
      Log.e(e, stackTrace: stackTrace);
    }
  }

  static Future<void> mailTo(String email) async {
    final String launchStr = "mailto:$email";

    if (await canLaunchUrlString(launchStr)) {
      await launchUrlString(launchStr);
    } else {
      throw 'Could not open email app.';
    }
  }

  static Future<void> call(String phoneNumber) async {
    if (!phoneNumber.startsWith("+") && !phoneNumber.startsWith("0")) {
      phoneNumber = "0" + phoneNumber;
    }

    final String launchStr = "tel:$phoneNumber";

    if (await canLaunchUrlString(launchStr)) {
      await launchUrlString(launchStr);
    } else {
      throw 'Could not call.';
    }
  }

  static Future<void> browser(String url) async {
    final String launchStr = (url.startsWith("http") ? "" : "http://") + url;

    if (await canLaunchUrlString(launchStr)) {
      await launchUrlString(launchStr);
    } else {
      throw 'Could not open browser.';
    }
  }

  static Future<void> map(double latitude, double longitude) async {
    final String googleMapsUrl = "comgooglemaps://?center=$latitude,$longitude";

    if (await canLaunchUrlString(googleMapsUrl)) {
      await launchUrlString(googleMapsUrl);
    } else {
      final String mapsUrl = "https://maps.apple.com/?q=$latitude,$longitude";
      //final String mapsUrl =
      //    'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunchUrlString(mapsUrl)) {
        await launchUrlString(mapsUrl);
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  static Future<void> instagramUser(String username) async {
    var url = 'instagram://user?username=$username';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      url = 'http://instagram.com/_u/$username';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        url = 'https://www.instagram.com/$username';
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url);
        } else {
          throw 'Could not open instagram user.';
        }
      }
    }
  }

  static Future<void> instagramMedia(String mediaCode) async {
    var url = 'instagram://media?id=$mediaCode';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      url = 'https://www.instagram.com/p/$mediaCode/';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch media with code $mediaCode';
      }
    }
  }
}

import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInitializer {
  AdInitializer() {
    _createInterstitialAd();
  }
  int _interstitialLoadAttempt = 0;
  InterstitialAd? _interstitialAd;
  String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      //return 'ca-app-pub-5492091545098636/8932816118';
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      //return 'ca-app-pub-5492091545098636/5815698182';
      return 'ca-app-pub-3940256099942544/4411468910';
    } else {
      throw UnsupportedError('UnSupported Platform');
    }
  }

  void disposeAd() {
    if (_interstitialAd != null) {
      _interstitialAd?.dispose();
    }
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempt = 0;
        }, onAdFailedToLoad: (error) {
          _interstitialAd = null;
          _interstitialLoadAttempt++;
          if (_interstitialLoadAttempt <= 2) {
            _createInterstitialAd();
          }
        }));
  }

  void showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          _createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          _createInterstitialAd();
        },
      );
      _interstitialAd!.show();
    }
  }
}

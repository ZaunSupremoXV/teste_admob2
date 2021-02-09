import 'package:flutter/material.dart';
import 'package:admob_flutter/admob_flutter.dart';

String _appid = "ca-app-pub-1577485202493071~9154466604";
String _idbanner = "ca-app-pub-1577485202493071/9244066135";
String _idintertitial = "ca-app-pub-1577485202493071/6145994033";
String _reward = "ca-app-pub-1577485202493071/5030123411";

void main() {
  Admob.initialize(_appid);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdmobInterstitial interstitialAd;
  AdmobReward rewardAd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, top: 50),
              child: Text("Tutorial Admob Flutter"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150.0, top: 50),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  interstitialAd.show();
                },
                child: new Text("Show Intertitial Ads"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 50),
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  rewardAd.show();
                },
                child: new Text("Show Reward Ads"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AdmobBanner(
                adUnitId: _idbanner,
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  handleEvent(event, args, 'Banner');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: _idintertitial,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    rewardAd = AdmobReward(
        adUnitId: _reward,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) rewardAd.load();
          handleEvent(event, args, 'Reward');
        });

    interstitialAd.load();
    rewardAd.load();
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        //showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        //showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        print("Goto next page");
        break;
      case AdmobAdEvent.failedToLoad:
        //print("Goto next page");
        break;
      case AdmobAdEvent.rewarded:
        break;
      default:
    }
  }
}

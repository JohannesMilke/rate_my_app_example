import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rate_my_app_example/page/rate_comment_page.dart';
import 'package:rate_my_app_example/page/rate_info_page.dart';
import 'package:rate_my_app_example/page/rate_dialog_page.dart';
import 'package:rate_my_app_example/page/rate_stars_page.dart';
import 'package:rate_my_app_example/widget/rate_app_init_widget.dart';
import 'package:rate_my_app_example/widget/tabbar_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Rate My App';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: RateAppInitWidget(
          builder: (rateMyApp) => HomePage(rateMyApp: rateMyApp),
        ),
      );
}

class HomePage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const HomePage({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => TabBarWidget(
        title: MyApp.title,
        tabs: [
          Tab(icon: Icon(Icons.open_in_full), text: 'Dialog'),
          Tab(icon: Icon(Icons.rate_review), text: 'Comment'),
          Tab(icon: Icon(Icons.star_rate_sharp), text: 'Stars'),
          Tab(icon: Icon(Icons.info_outline_rounded), text: 'Info'),
        ],
        children: [
          RateDialogPage(rateMyApp: widget.rateMyApp),
          RateCommentPage(rateMyApp: widget.rateMyApp),
          RateStarsPage(rateMyApp: widget.rateMyApp),
          RateInfoPage(rateMyApp: widget.rateMyApp),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:rate_my_app_example/widget/button_widget.dart';

class RateStarsPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RateStarsPage({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);

  @override
  _RateStarsPageState createState() => _RateStarsPageState();
}

class _RateStarsPageState extends State<RateStarsPage> {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(48),
        child: Center(
          child: ButtonWidget(
            text: 'Rate App',
            onClicked: () => widget.rateMyApp.showStarRateDialog(
              context,
              title: 'Rate This App',
              message: 'Do you like this app? Please leave a rating',
              starRatingOptions: StarRatingOptions(initialRating: 4),
              actionsBuilder: actionsBuilder,
            ),
          ),
        ),
      );

  List<Widget> actionsBuilder(BuildContext context, double? stars) =>
      stars == null
          ? [buildCancelButton()]
          : [buildOkButton(stars), buildCancelButton()];

  Widget buildOkButton(double stars) => TextButton(
        child: Text('OK'),
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Thanks for your feedback!')),
          );

          final launchAppStore = stars >= 4;

          final event = RateMyAppEventType.rateButtonPressed;

          await widget.rateMyApp.callEvent(event);

          if (launchAppStore) {
            widget.rateMyApp.launchStore();
          }

          Navigator.of(context).pop();
        },
      );

  Widget buildCancelButton() => RateMyAppNoButton(
        widget.rateMyApp,
        text: 'CANCEL',
      );
}

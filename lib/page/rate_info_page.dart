import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateInfoPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RateInfoPage({
    Key? key,
    required this.rateMyApp,
  }) : super(key: key);

  @override
  _RateInfoPageState createState() => _RateInfoPageState();
}

class _RateInfoPageState extends State<RateInfoPage> {
  List<DebuggableCondition> conditions = [];

  bool shouldOpenDialog = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) => reset());
  }

  T getCondition<T>() =>
      widget.rateMyApp.conditions.whereType<T>().toList().first;

  @override
  Widget build(BuildContext context) {
    final minimumDays = getCondition<MinimumDaysCondition>();
    final minimumLaunches = getCondition<MinimumAppLaunchesCondition>();
    final doNotOpenAgain = getCondition<DoNotOpenAgainCondition>();
    final hasMetConditions = shouldOpenDialog ? 'Yes' : 'No';
    final openRatingAgain = doNotOpenAgain.doNotOpenAgain ? 'No' : 'Yes';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildText('Minimum Days: ${minimumDays.minDays}'),
        buildText('Remind After Days: ${minimumDays.remindDays}'),
        buildText('Current Launches: ${minimumLaunches.launches}'),
        buildText('Minimum Launches: ${minimumLaunches.minLaunches}'),
        buildText('Remind After Launches: ${minimumLaunches.remindLaunches}'),
        buildText('Open Rating Again? $openRatingAgain'),
        buildText('Are Conditions Met? $hasMetConditions'),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(minimumSize: Size(140, 46)),
          icon: Icon(Icons.close, size: 28),
          label: Text(
            'RESET',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: reset,
        ),
      ],
    );
  }

  Widget buildText(String content) => Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
      );

  Future reset() async {
    await widget.rateMyApp.reset();

    setState(() {
      conditions =
          widget.rateMyApp.conditions.whereType<DebuggableCondition>().toList();
      shouldOpenDialog = widget.rateMyApp.shouldOpenDialog;
    });
  }
}

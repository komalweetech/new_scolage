import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constant/asset_icons.dart';



class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetIcons.HELP_SCREEN_APP_LOGO_ICON,
              width: 60.w,
              height: 75.h,
            ),
            SizedBox(height: 20.h,),
            Text(
              '     Coming Soon! \n Offere of all Collages',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Text(
              'Our pretest will be available soon.\nStay tuned!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}


// only for coming soon page countdown-time.....

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _duration = const Duration(days: 30); // Set the countdown duration

  @override
  Widget build(BuildContext context) {
    return CountdownTimerWidget(
      duration: _duration,
      onFinish: () {
        // Handle logic when the countdown finishes
        print('Countdown finished!');
      },
    );
  }
}

class CountdownTimerWidget extends StatefulWidget {
  final Duration duration;
  final Function onFinish;

  CountdownTimerWidget({
    required this.duration,
    required this.onFinish,
  });

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Duration _remainingTime;
  late int _totalSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.duration.inSeconds;
    _remainingTime = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        _timer.cancel();
        widget.onFinish();
      } else {
        setState(() {
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int days = _remainingTime.inDays;
    int hours = (_remainingTime.inHours % 24);
    int minutes = (_remainingTime.inMinutes % 60);
    int seconds = (_remainingTime.inSeconds % 60);

    return Column(
      children: [
        const Text(
          'Time Left:',
          style: TextStyle(fontSize: 16),
        ),
        Text(
          '$days days $hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
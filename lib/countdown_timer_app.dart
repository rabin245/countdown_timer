import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimerApp extends StatefulWidget {
  const CountdownTimerApp({Key? key}) : super(key: key);

  @override
  _CountdownTimerAppState createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  var minute = 0;
  var seconds = 0;
  late Timer timer;
  late int totalTime;

  void setMinutes(value) {
    setState(() {
      minute = value;
    });
  }

  void setSeconds(value) {
    setState(() {
      seconds = value;
    });
  }

  void startTimer() {
    final oneSecond = Duration(seconds: 1);
    // if (timer != null) {
    //   timer.cancel();
    // }
    timer.cancel(); //(timer!= null) is always true
    timer = Timer.periodic(oneSecond, (timer) {
      totalTime = minute * 60 + seconds;

      setState(() {
        if (totalTime == 0) {
          timer.cancel();
        } else {
          if (seconds == 0) minute -= 1;
          totalTime -= 1;
          seconds = (totalTime % 60);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.deepPurple),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Countdown Timer'),
        ),
        body: Center(
          child: Text(
            '$minute:$seconds',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // showTimePicker(
            //   context: context,
            //   initialTime: TimeOfDay.now(),
            // );
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                contentPadding: EdgeInsets.all(15.0),
                children: [
                  Text('Set your time'),
                  DropdownButton<int>(
                    value: minute,
                    icon: Text('Minute'),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      );
                    }),
                    onChanged: setMinutes,
                  ),
                  DropdownButton<int>(
                    value: seconds,
                    icon: Text('Seconds'),
                    items: List.generate(60, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index.toString()),
                      );
                    }),
                    onChanged: setSeconds,
                  ),
                  SizedBox(height: 15),
                  OutlinedButton(
                    child: Text('Start'),
                    onPressed: () {
                      startTimer();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.alarm_add_outlined),
        ),
      ),
    );
  }
}

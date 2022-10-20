import 'dart:async';

import 'package:flutter/material.dart';

class TimerPageAssignment extends StatefulWidget {
  const TimerPageAssignment({Key? key}) : super(key: key);

  @override
  State<TimerPageAssignment> createState() => _TimerPageAssignmentState();
}

class _TimerPageAssignmentState extends State<TimerPageAssignment> {
  Timer? timer;
  Stopwatch stopwatch = Stopwatch();
  Duration time = Duration.zero;

  List laps = [];

  playAndPause() {
    if (timer != null) {
      stopwatch.stop();
      timer?.cancel();
      timer = null;
      return;
    } else {
      stopwatch.start();
      timer = Timer.periodic(
        Duration(milliseconds: 10),
        (timer) {
          setState(() {
            time = stopwatch.elapsed;
          });
        },
      );
    }
  }

  reset() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
    stopwatch.reset();
    setState(() {
      time = Duration.zero;
      laps = [];
    });
  }

  void addLaps() {
    String lap = "$time";
    setState(() {
      laps.add(lap);
    });
  }

  mark() {
    // TODO 기록 저장하기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${time.inHours.toString().padLeft(2, '0')} : ${(time.inMinutes % 60).toString().padLeft(2, '0')} : ${(time.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  '${(time.inMilliseconds / 10).floor() % 100}',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Container(
                  height: 320.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " Lap n°${index + 1}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                " ${laps[index]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                laps[index] == laps[0]
                                    ? "${laps[index]}"
                                    : "${double.parse(laps[index]) - double.parse(laps[index - 1])}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: reset,
              ),
              FloatingActionButton.large(
                child: Icon(timer != null ? Icons.pause : Icons.play_arrow),
                onPressed: playAndPause,
              ),
              FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: addLaps,
              ),
            ],
          )
        ],
      ),
    );
  }
}

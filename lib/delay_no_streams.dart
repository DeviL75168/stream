
import 'dart:async';

import 'package:flutter/material.dart';

class DelayNoStreams extends StatelessWidget {
   DelayNoStreams({super.key});

 final StreamController<int> _controller = StreamController<int>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            
            Text('Upper Stream Builder'),
            
            StreamBuilder<int>(
              //stream: _controller.stream,
              stream: delayedNumberStreams(),
              builder: (BuildContext, AsyncSnapshot<int>snapshot){
                if (snapshot.hasData){
                  return Text('The numbers are: ${snapshot.data}', textScaleFactor: 2,);
                }else if (snapshot.hasError){
                  return Text('Error: ${snapshot.hasError}');
                }else{
                  return Text('no data yet');
                }
              },
            ),
            
            SizedBox(),
            
            Text('Lower Stream Builder'),
            
            StreamBuilder<int>(
              //stream: _controller.stream,
                stream: delayedNumberStreams(),
                builder: (BuildContext, AsyncSnapshot<int>snapshot){
                  if (snapshot.hasData){
                    return Text('The numbers are: ${snapshot.data}', textScaleFactor: 2,);
                  }else if (snapshot.hasError){
                    return Text('Error: ${snapshot.hasError}');
                  }else{
                    return Text('no data yet');
                  }
                },
            )

          ],
        ),
      ),
    );
  }
  Future<void> startEmittingNumbers() async{
    for (int i = 1; i<= 12; i++){
      await Future.delayed(Duration(seconds: 1));
      _controller.add(i);// Emit the next number
    }
    _controller.close();
  }

  Stream<int> delayedNumberStreams() async*{
    for (int i = 1; i <= 12; i++){
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}

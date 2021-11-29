// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/aboveWidget/page_model.dart';

class LoadingRoomWidget extends StatelessWidget {

  Function onLoadingEnd;

  LoadingRoomWidget({required this.onLoadingEnd});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      onLoadingEnd();
    });
    return MyKiloBamayaPageModel(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Creating...', style: Theme.of(context).textTheme.headline4,),
          const SizedBox(child: SizedBox(child: CircularProgressIndicator(), width: 20, height: 20,), height: 50,),
          const Text('Please wait'),
        ],
      ),
    );
  }
}

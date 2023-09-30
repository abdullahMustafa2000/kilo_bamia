// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/elements/page_model.dart';

class LoadingRoomWidget extends StatelessWidget {

  Function onLoadingEnd;
  Function moveToPrev;

  LoadingRoomWidget({required this.onLoadingEnd, required this.moveToPrev});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      onLoadingEnd();
    });
    return MyKiloBamayaPageModel(
      showBackBtn: false,
      onPrev: moveToPrev,
      onClose: (){},
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

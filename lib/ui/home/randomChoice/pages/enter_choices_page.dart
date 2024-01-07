import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kilo_bamya/main.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/elements/page_model.dart';

import '../../../../models/choice_class_model.dart';

class EnterChoicesPage extends StatefulWidget {
  EnterChoicesPage(
      {required this.onCloseClick, required this.onSpinningWheelClick});
  final Function onCloseClick;
  final Function({List<ChoiceModel>? choices}) onSpinningWheelClick;

  @override
  State<EnterChoicesPage> createState() => _EnterChoicesPageState();
}

class _EnterChoicesPageState extends State<EnterChoicesPage> {
  var maxInput = MyColors.spinnerColorsArray.length;
  List<Color?> colorsArray =
      List.filled(MyColors.spinnerColorsArray.length, null);
  List<ChoiceModel> choices = [];
  List<bool> checkSelected =
      List.filled(MyColors.spinnerColorsArray.length, false);
  var currentColorIndex = 0;
  @override
  void initState() {
    for (var i = 0; i < maxInput;) {
      var random = Random().nextInt(maxInput);
      if (!checkSelected[random]) {
        colorsArray[i] = MyColors.spinnerColorsArray[random];
        checkSelected[random] = true;
        i++;
      }
    }

    choices = List.filled(
        2, ChoiceModel(choiceName: '', choiceColor: Colors.transparent),
        growable: true);
    choices[0] = ChoiceModel(
        choiceName: 'xxxx', choiceColor: colorsArray[currentColorIndex]!);
    choices[1] = ChoiceModel(
        choiceName: 'xxxx', choiceColor: colorsArray[currentColorIndex += 1]!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onTextChange(String text, var index) {
      setState(() {
        choices[index].choiceName = text;
      });
    }

    return MyKiloBamayaPageModel(
      showBackBtn: false,
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          children: [
            Text(
              getLocalization(context).enterChoicesNames,
              style: GoogleFonts.k2d(
                textStyle: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Expanded(
              child: GridView.builder(
                itemCount: choices.length < maxInput
                    ? choices.length + 1
                    : choices.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == colorsArray.length) {
                    return TextInputDesign(
                        onTextChange, index, choices[index].choiceColor);
                  } else if (index == choices.length) {
                    return AddButtonWidget(onAddBtnClick, colorsArray[index]!);
                  } else {
                    return TextInputDesign(
                        onTextChange, index, choices[index].choiceColor);
                  }
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1 / .4),
              ),
            ),
            InkWell(
              onTap: () {
                widget.onSpinningWheelClick(choices: choices);
              },
              child: Container(
                width: 47,
                height: 47,
                margin: const EdgeInsets.all(8),
                child: Image.asset('assets/images/spinning_wheel.png'),
              ),
            )
          ],
        ),
      ),
      onClose: () {
        widget.onCloseClick();
      },
      onPrev: () {},
    );
  }

  void onClosePage() {}

  void onAddBtnClick() {
    setState(() {
      choices.add(ChoiceModel(
          choiceName: 'xxxx',
          choiceColor: colorsArray[currentColorIndex += 1]!));
    });
  }
}

class AddButtonWidget extends StatelessWidget {
  final Color color;
  final Function onAddBtnClick;

  AddButtonWidget(this.onAddBtnClick, this.color);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAddBtnClick();
      },
      child: ItemShapeDesign(
          contentWidget: const Center(
            child: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
          ),
          containerColor: color),
    );
  }
}

class ItemShapeDesign extends StatelessWidget {
  final Widget contentWidget;
  final Color containerColor;
  const ItemShapeDesign(
      {required this.contentWidget, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor,
      ),
      child: contentWidget,
    );
  }
}

class TextInputDesign extends StatelessWidget {
  const TextInputDesign(this.onTxtChange, this.index, this.color);
  final Function(String, int) onTxtChange;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ItemShapeDesign(
      containerColor: color,
      contentWidget: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: TextField(
          onChanged: (txt) {
            onTxtChange(txt, index);
          },
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.titleMedium,
            hintText: 'xxxx',
          ),
        ),
      ),
    );
  }
}

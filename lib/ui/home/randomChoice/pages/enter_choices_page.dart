import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kilo_bamya/moduls/choice_class_model.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_model.dart';

class EnterChoicesPage extends StatefulWidget {
  EnterChoicesPage({required this.onCloseClick});
  Function onCloseClick;

  @override
  State<EnterChoicesPage> createState() => _EnterChoicesPageState();
}

class _EnterChoicesPageState extends State<EnterChoicesPage> {
  var maxInput = 6;
  List<Color?> colorsArray = List.filled(MyColors.spinnerColorsArray.length, null);
  List<ChoiceModel> choices = [];
  List<bool> checkSelected = List.filled(MyColors.spinnerColorsArray.length, false);
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
    print('build func');
    void onTextChange(String text, var index) {
      setState(() {
        choices[index].choiceName = text;
      });
    }
    return Container(
      child: MyKiloBamayaPageModel(
        content: SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          child: Column(
            children: [
              Text(
                'Enter names :',
                style: Theme.of(context).textTheme.headline4,
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: choices.length < maxInput? choices.length + 1 : choices.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == colorsArray.length) {
                      return TextInputDesign(onTextChange, index, choices[index].choiceColor);
                    } else if (index == choices.length) {
                      return AddButtonWidget(onAddBtnClick, colorsArray[index]!);
                    }
                    else {
                      return TextInputDesign(onTextChange, index,
                          choices[index].choiceColor);
                    }
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1 / .4),
                ),
              ),
              Container(
                width: 47,
                height: 47,
                margin: const EdgeInsets.all(8),
                child: Image.asset('assets/images/spinning_wheel.png'),
              )
            ],
          ),
        ),
        onClose: () {
          widget.onCloseClick();
        },
        onPrev: () {},
      ),
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
  Color color;
  Function onAddBtnClick;

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
  Widget contentWidget;
  Color containerColor;
  ItemShapeDesign({required this.contentWidget, required this.containerColor});

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
  TextInputDesign(this.onTxtChange, this.index, this.color);
  Function(String, int) onTxtChange;
  int index;
  Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ItemShapeDesign(
      containerColor: color,
      contentWidget: TextField(
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
          hintStyle: Theme.of(context).textTheme.subtitle1,
          hintText: 'xxxx',
        ),
      ),
    );
  }
}

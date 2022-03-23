import 'package:flutter/material.dart';
import 'package:kilo_bamya/ui/home/teamSelection/page_model.dart';

class EnterChoicesPage extends StatelessWidget {
  EnterChoicesPage({required this.onCloseClick});
  Function onCloseClick;
  @override
  Widget build(BuildContext context) {
    void onTextChange(String text, var index, Color boxColor) {}

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
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return TextInputDesign(onTextChange, index);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1 / .5),
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
        onClose: (){
          onCloseClick();
        },
        onPrev: () {},
      ),
    );
  }

  void onClosePage() {}
}

class TextInputDesign extends StatelessWidget {
  TextInputDesign(this.onTxtChange, this.index);
  Function(String, int, Color) onTxtChange;
  int index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.yellow,
      ),
      child: TextField(
        onChanged: (txt) {
          onTxtChange(txt, index, Colors.yellow);
        },
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.subtitle1,
          hintText: 'name',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kilo_bamya/themes/colors_file.dart';
import 'package:kilo_bamya/ui/home/btm_nav_provider.dart';
import 'package:kilo_bamya/ui/home/coin_widget.dart';
import 'package:kilo_bamya/ui/home/side_menu_widget.dart';
import 'package:kilo_bamya/ui/home/wheel_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BtmNavProvider provider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<BtmNavProvider>(context);
    return Scaffold(
      drawer: const MyDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(builder: (context){
          return InkWell(
            child: Image.asset('assets/images/menu_ic.png'),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: const Center(
          child: Text(
            'Kilo Bamia',
            style: TextStyle(fontSize: 34),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: MyColors.darkBlue,
      ),
      body: views[provider.btmIndex],
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}

List<Widget> views = [
  WheelWidget(),
  CoinWidget(),
];

class CustomBottomNav extends StatefulWidget {
  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late BtmNavProvider provider;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<BtmNavProvider>(context);
    return Container(
      height: 62,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
          color: MyColors.lightBlack,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
            )
          ]),
      child: Row(
        children: [
          Expanded(
            child: wheelOrCoinWidget('Wheel',
                provider.btmIndex == 0 ? MyColors.darkBlue : MyColors.white),
          ),
          Container(
            width: 4,
            decoration: BoxDecoration(
                color: MyColors.blueShadowClr,
                borderRadius: BorderRadius.circular(6)),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
          Expanded(
            child: wheelOrCoinWidget('Coin',
                provider.btmIndex == 1 ? MyColors.darkOrange : MyColors.white),
          ),
        ],
      ),
    );
  }

  Widget wheelOrCoinWidget(String title, Color color) {
    return InkWell(
      onTap: () {
        if (title.toLowerCase() == 'Wheel'.toLowerCase()) {
          provider.updateBtnNavIndex(0);
        } else {
          provider.updateBtnNavIndex(1);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 8,
            width: 50,
            decoration: BoxDecoration(
                color: color == MyColors.white ? MyColors.lightBlack : color,
                borderRadius: BorderRadius.circular(6)),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}

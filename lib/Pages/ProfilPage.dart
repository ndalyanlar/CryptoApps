import 'package:crypto_dashboard/Icons/my_flutter_app_icons.dart';
import 'package:crypto_dashboard/MainPage/fullmain.dart';
import 'package:crypto_dashboard/Pages/QRScreen.dart';
import 'package:crypto_dashboard/Pages/timer.dart';

import 'package:crypto_dashboard/widgets/carousel.dart';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../style.dart';

class ProfilPageMain extends StatefulWidget {
  @override
  _ProfilPageMainState createState() => _ProfilPageMainState();
}

class _ProfilPageMainState extends State<ProfilPageMain> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _Pages() {
    return [
      Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: NeumorphicBackground(
            child: Column(children: <Widget>[
              const HeadDrawer(),
              ItemDrawer(
                icon: FontAwesomeIcons.language,
                text: 'Dil',
                onTap: () {},
                child: DropdownButton<dynamic>(
                  // value:,
                  dropdownColor: NeumorphicTheme.baseColor(context),
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                  items: <DropdownMenuItem<dynamic>>[
                    const DropdownMenuItem<dynamic>(
                      // value: Locale('en'),
                      child: Text('Türkçe'),
                    ),
                    const DropdownMenuItem<dynamic>(
                      // value: Locale('fr'),
                      child: Text('English'),
                    ),
                    const DropdownMenuItem<dynamic>(
                      // value: Locale('ru'), de
                      child: Text('Русский'),
                    )
                  ],
                  onChanged: (dynamic data) {
                    print("heyy" + data.toString());
                  },
                ),
              ),
              ItemDrawer(
                icon: FontAwesomeIcons.moon,
                text: 'Dark Mod',
                onTap: () {},
                child: NeumorphicSwitch(
                  value: false,
                  onChanged: (dark) {
                    if (dark) {
                      //ThemeMode.dark;
                    } else {
                      //ThemeMode.light;
                    }
                  },
                ),
              ),
              const Spacer(),
              //wait version info
              const About(),
            ]),
          ),
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        appBar: NeumorphicAppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => AllPagesinOne()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.logout),
                  ],
                ))
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: Style.doublePadding),
                child: MainTimer(),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(Style.doublePadding,
                    Style.mainPadding, Style.mainPadding, 0.0),
                child: NeumorphicText(
                  "Quick Pay",
                  style: NeumorphicStyle(
                    color: Style.textColor,
                  ),
                  textStyle:
                      NeumorphicTextStyle(fontSize: 30, fontFamily: 'Ledger'),
                ), //body kısmı
              ),
            ],
          ),
        ),
      ),
      Container(
        width: 500,
        height: 100,
        color: Colors.red,
        child: Text(
          ' Coin Transfer',
          style: optionStyle,
        ),
      ),
      Scaffold(
        body: QrScreenPage(),
      ),
      Scaffold(
        body: Carousel(),
      ),
      Container(
        width: 500,
        height: 100,
        color: Colors.red,
        child: Text(
          "data",
          style: optionStyle,
        ),
      ),
    ];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _Pages().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(MyFlutterApp.home),
              icon: Icon(Icons.home),
              label: 'Ana Sayfa',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(MyFlutterApp.xing_squared),
              icon: Icon(MyFlutterApp.xing),
              label: 'Transfer',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.qr_code_scanner,
              ),
              icon: Icon(
                MyFlutterApp.qrcode,
              ),
              label: 'Öde',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              activeIcon: Icon(MyFlutterApp.credit_card),
              label: "Cüzdan",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(MyFlutterApp.chart_area),
              icon: Icon(MyFlutterApp.chart_line),
              label: "Teknik Analiz",
            ),
          ],
          unselectedItemColor: Colors.blueGrey,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[400],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HeadDrawer extends StatefulWidget {
  const HeadDrawer({Key? key}) : super(key: key);

  @override
  _HeadDrawerState createState() => _HeadDrawerState();
}

class _HeadDrawerState extends State<HeadDrawer> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Center(
        child: NeumorphicText('Quick Pay',
            textStyle:
                NeumorphicTextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final GestureTapCallback onTap;
  final String text;
  final Widget child;

  const ItemDrawer(
      {required this.icon,
      required this.text,
      required this.onTap,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
      ),
      trailing: child,
      onTap: onTap,
    );
  }
}

class About extends StatelessWidget {
  const About({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemDrawer(
      icon: Icons.access_alarm,
      text: 'v.1.0',
      child: Text(
        'Qpay by Redclick',
        style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
      ),
      onTap: () => showAboutDialog(
        context: context,
        applicationVersion: "1.0",
        applicationIcon: Image.asset(
          'assets/icon/icon.png',
          height: 50,
        ),
        children: [
          Text('settings.about_text'),
        ],
      ),
    );
  }
}

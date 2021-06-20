import 'package:crypto_dashboard/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'MainPage/fullmain.dart';
import 'Pages/404.dart';
import 'Pages/add_category.dart';
import 'models/pages_arguments.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // //only portrait
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // //fonts license
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('google_fonts/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  runApp(MyApp());
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(

        // home: Container(
        //   color: Colors.red,
        // ),
        debugShowCheckedModeBanner: false,
        title: 'title',
        initialRoute: '/',
        onGenerateRoute: generateRoute,
        theme: NeumorphicThemeData(
            defaultTextColor: Style.textColor,
            baseColor: Style.bgColor,
            accentColor: Style.primaryColor,
            variantColor: Style.primaryColor,
            intensity: 0.6,
            lightSource: LightSource.topRight,
            depth: 3,
            appBarTheme: NeumorphicAppBarThemeData(
                buttonPadding: EdgeInsets.all(14.0),
                buttonStyle: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                iconTheme: IconThemeData(
                  color: Style.textColor,
                ),
                icons: NeumorphicAppBarIcons(
                    backIcon: Icon(FontAwesomeIcons.chevronLeft),
                    menuIcon: Icon(FontAwesomeIcons.bars)))),
        darkTheme: NeumorphicThemeData(
            defaultTextColor: Style.textColorDark,
            baseColor: Style.bgColorDark,
            accentColor: Style.primaryColor,
            variantColor: Style.primaryColor,
            intensity: 0.6,
            lightSource: LightSource.topRight,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.grey,
            depth: 3,
            appBarTheme: const NeumorphicAppBarThemeData(
                buttonPadding: EdgeInsets.all(14.0),
                buttonStyle:
                    NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
                iconTheme: IconThemeData(
                  color: Style.textColorDark,
                ),
                icons: NeumorphicAppBarIcons(
                    backIcon: Icon(FontAwesomeIcons.chevronLeft),
                    menuIcon: Icon(FontAwesomeIcons.bars)))));
  }

  Route generateRoute(RouteSettings settings) {
    //check named route and return page
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<Widget>(builder: (context) => AllPagesinOne());
      // case '/account':
      //   return MaterialPageRoute<Widget>(
      //       builder: (context) =>
      //           AddItem(settings.arguments as ItemPageArguments));
      // case '/settings':
      //   //return router with card animation
      //   return CardRoute(
      //       widget: TodoPage(settings.arguments as MainPageArguments),
      //       arguments: settings.arguments as MainPageArguments);
      case '/category/add':
        return CardRoute(
            widget: AddCategory(settings.arguments as MainPageArguments),
            arguments: settings.arguments as MainPageArguments);
      // case '/category/edit':
      //   return MaterialPageRoute<Widget>(
      //       builder: (context) =>
      //           AddCategory(settings.arguments as MainPageArguments));
      default:
        return MaterialPageRoute<Widget>(builder: (context) => const Page404());
    }
  }
}

class CardRoute extends PageRouteBuilder<Widget> {
  final Widget widget;
  final MainPageArguments arguments;

  CardRoute({required this.widget, required this.arguments})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            // return widget;
            return AnimationPageInjection(
                child: widget, animationPage: animation);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return CardTransition(
                child: child,
                animation: curvedAnimation,
                cardPosition: arguments.cardPosition!);
          },
          transitionDuration: Style.pageDuration,
        );
}

class CardTransition extends AnimatedWidget {
  const CardTransition(
      {Key? key,
      required Animation<double> animation,
      required this.child,
      required this.cardPosition})
      : super(key: key, listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;
  final Widget child;
  final CardPosition cardPosition;

  @override
  Widget build(BuildContext context) {
    var animValue = animation.value;
    var paddingAnim = Style.doublePadding - Style.doublePadding * animValue;
    var borderAnim = BorderRadius.circular(
        Style.mainBorderRadiusValue - Style.mainBorderRadiusValue * animValue);

    var animLeft = cardPosition.left - cardPosition.left * animValue;
    var animRight = cardPosition.right - cardPosition.right * animValue;
    var animTop = cardPosition.top - cardPosition.top * animValue;
    var animBottom = cardPosition.bottom - cardPosition.bottom * animValue;

    return Stack(children: <Widget>[
      Positioned(
        left: animLeft,
        right: animRight,
        top: animTop,
        bottom: animBottom,
        child: Neumorphic(
          duration: const Duration(),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(borderAnim),
          ),

          margin: EdgeInsets.fromLTRB(0, paddingAnim, paddingAnim, paddingAnim),

          ///https://flutter.dev/docs/perf/rendering/best-practices#pitfalls
          ///TODO: optimization opacity
          child: AnimatedOpacity(
            opacity: animValue,
            duration: const Duration(),
            child:
                AnimationPageInjection(child: child, animationPage: animation),
          ),
        ),
      ),
    ]);
  }
}

//animation page injector
class AnimationPageInjection extends InheritedWidget {
  final Animation<double> animationPage;

  const AnimationPageInjection({
    Key? key,
    required this.animationPage,
    required Widget child,
  })   : assert(child != null),
        assert(animationPage != null),
        super(key: key, child: child);

  static AnimationPageInjection? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AnimationPageInjection>();
  }

  @override
  bool updateShouldNotify(AnimationPageInjection oldWidget) =>
      animationPage != oldWidget.animationPage;
}

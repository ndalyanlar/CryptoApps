import 'package:crypto_dashboard/Icons/my_flutter_app_icons.dart';
import 'package:crypto_dashboard/utils/balances.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/pages_arguments.dart';
import '../models/todo_models.dart';

import '../style.dart';
import 'detail_card.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 0.8);

  final double scaleFraction = 0.9;
  final double scaleDepth = 0.5;
  final double fullScale = 1.0;
  final double viewPortFraction = 0.8;

  int page = 0;
  int pageIndex = 1;

  int touchedIndex = 1;
  int listItemCount = balances(null).length;
  // int listItemCount = balancesTest.length;
  int toplam() {
    int toplam = 0;
    for (var i = 0; i <= listItemCount - 1; i++) {
      toplam += balances(null)[i].value.toInt();
      // toplam += balancesTest[i].value.toInt();
    }
    return toplam;
  }

  bool _handlePageNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      setState(() {
        // page = _pageController.page!.toInt();
        page = _pageController.page!.toInt();

    
      });
    }
    return false;
  }

  var dropdownValue = "Grafik";
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return NotificationListener<ScrollNotification>(
          onNotification:
              _handlePageNotification, //listen scroll and update page
          child: Container(
            child: Center(
              child: Column(
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Grafik', 'Kart']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  (dropdownValue == "Grafik"
                      ? Expanded(
                          child: Container(
                            color: Colors.blue[200],
                            child: Column(
                              children: [
                                Expanded(
                                  child: PieChart(PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchCallback: (pieTouchResponse) {
                                      setState(() {
                                        final desiredTouch =
                                            pieTouchResponse.touchInput
                                                    is! PointerExitEvent &&
                                                pieTouchResponse.touchInput
                                                    is! PointerUpEvent;
                                        if (desiredTouch &&
                                            pieTouchResponse.touchedSection !=
                                                null) {
                                          setState(() {
                                            // page = pieTouchResponse
                                            //     .touchedSection!.touchedSectionIndex;
                                          });
                                        } else {
                                          setState(() {
                                            page = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                            if (_pageController.hasClients) {
                                              _pageController.animateToPage(
                                                page,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.linear,
                                              );
                                            }
                                          });
                                        }
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: true,
                                    ),
                                    sectionsSpace: 5,
                                    centerSpaceRadius: 60,
                                    sections: balances(page),
                                  )),
                                ),
                                Expanded(
                                    child: Container(
                                  child: Center(
                                    child: ListView(
                                      padding: const EdgeInsets.all(8),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.amber[600],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            height: 50,
                                            child: const Center(
                                                child: Text('Bitcoin')),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.amber[500],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            height: 50,
                                            child: const Center(
                                                child: Text('Ethereum')),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.amber[100],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0)),
                                            height: 50,
                                            child: const Center(
                                                child: Text('Ripple')),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: listItemCount + 1, //list Count
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              if (index == listItemCount) {
                                return CategoryAddCard(0.9, 0.9);
                              } else {
                                return CategoryCard(
                                  TodoCategory(
                                      value: balances(touchedIndex)[index]
                                          .value
                                          .toInt(),
                                      title:
                                          balances(touchedIndex)[index].title,
                                      icon: MyFlutterApp.bitcoin,
                                      totalItems: toplam(),
                                      completed: balances(touchedIndex)[index]
                                          .value
                                          .toInt()
                                          .round()),
                                );
                              }
                            },
                          ),
                        ))
                ],
              ),
            ),
          )

          // Column(
          //   children: [
          //     Expanded(
          //       child: Container(
          //         color: Colors.blue[200],
          //         child: PieChart(PieChartData(
          //           pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          //             setState(() {
          //               final desiredTouch =
          //                   pieTouchResponse.touchInput is! PointerExitEvent &&
          //                       pieTouchResponse.touchInput is! PointerUpEvent;
          //               if (desiredTouch &&
          //                   pieTouchResponse.touchedSection != null) {
          //                 setState(() {
          //                   // page = pieTouchResponse
          //                   //     .touchedSection!.touchedSectionIndex;
          //                 });
          //               } else {
          //                 setState(() {
          //                   page = pieTouchResponse
          //                       .touchedSection!.touchedSectionIndex;
          //                   if (_pageController.hasClients) {
          //                     _pageController.animateToPage(
          //                       page,
          //                       duration: const Duration(milliseconds: 500),
          //                       curve: Curves.linear,
          //                     );
          //                   }
          //                 });
          //               }
          //             });
          //           }),
          //           borderData: FlBorderData(
          //             show: true,
          //           ),
          //           sectionsSpace: 5,
          //           centerSpaceRadius: 60,
          //           sections: balances(page),
          //         )),
          //       ),
          //     ),
          //     Expanded(
          //       child: PageView.builder(
          //         scrollDirection: Axis.horizontal,
          //         physics: const BouncingScrollPhysics(),
          //         itemCount: listItemCount + 1, //list Count
          //         controller: _pageController,
          //         itemBuilder: (context, index) {
          //           if (index == listItemCount) {
          //             return CategoryAddCard(0.9, 0.9);
          //           } else {
          //             return CategoryCard(
          //               TodoCategory(
          //                   value: balances(touchedIndex)[index].value.toInt(),
          //                   title: balances(touchedIndex)[index].title,
          //                   icon: MyFlutterApp.bitcoin,
          //                   totalItems: toplam(),
          //                   completed: balances(touchedIndex)[index]
          //                       .value
          //                       .toInt()
          //                       .round()),
          //             );
          //           }
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          );
    });
  }
}

class CategoryCard extends StatelessWidget {
  final TodoCategory category;

  const CategoryCard(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.9,
      alignment: Alignment.centerLeft,
      child: Neumorphic(
        padding: const EdgeInsets.all(18.0),
        margin: EdgeInsets.fromLTRB(
            0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
        style: NeumorphicStyle(
            color: Colors.blue[700],
            depth: NeumorphicTheme.depth(context)! * 2 * 0.9,
            boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius)),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pushNamed(context, '/category',
                arguments: MainPageArguments(
                    category: category,
                    cardPosition: CardPosition.getPosition(context)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeroIcon(category: category),
                const Spacer(),
                HeroTitle(category: category),
                SizedBox(
                  height: Style.mainPadding,
                ),
                HeroProgress(category: category)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryAddCard extends StatelessWidget {
  final double scale;
  final double scaleDepth;
  const CategoryAddCard(this.scale, this.scaleDepth, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      alignment: Alignment.centerLeft,
      child: Neumorphic(
        padding: const EdgeInsets.all(18.0),
        margin: EdgeInsets.fromLTRB(
            0, Style.doublePadding, Style.doublePadding, Style.doublePadding),
        style: NeumorphicStyle(
          depth: NeumorphicTheme.depth(context)! * 2 * scaleDepth,
          boxShape: NeumorphicBoxShape.roundRect(Style.mainBorderRadius),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pushNamed(context, '/category/add',
                arguments: MainPageArguments(
                    cardPosition: CardPosition.getPosition(context)));
          },
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: Style.textColor,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}

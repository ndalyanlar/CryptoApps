import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/todo_models.dart';
import '../style.dart';
import 'animated_percent.dart';

class HeroProgress extends StatelessWidget {
  const HeroProgress({
    Key? key,
    required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'progress_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            category.value!.toDouble().toString(),
            style: TextStyle(
                color: Colors.white.withOpacity(0.9), fontSize: 16.00),
          ),
          const SizedBox(
            height: Style.halfPadding,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: NeumorphicProgress(
                  percent: category.percent,
                  height: 10,
                  duration: const Duration(milliseconds: 300),
                  style: ProgressStyle(
                      accent: Colors.blue[900], variant: Colors.blue[900]
                      // depth: NeumorphicTheme.depth(
                      //     context)! // TODO: fix depth and others
                      ),
                ),
              ),
              SizedBox(
                width: Style.mainPadding,
              ),
              Container(
                width: 58,
                alignment: Alignment.centerRight,
                child: AnimatedPercent(
                  category.percent,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.9), fontSize: 16.00),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HeroTitle extends StatelessWidget {
  const HeroTitle({
    Key? key,
    required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'title_${category.id}',
      flightShuttleBuilder: flightShuttleBuilderFix,
      child: Text(
        category.title!,
        style: TextStyle(color: Colors.white, fontSize: 40.00),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class HeroIcon extends StatelessWidget {
  const HeroIcon({
    Key? key,
    required this.category,
  }) : super(key: key);

  final TodoCategory category;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'icon_${category.id}',
      child: Neumorphic(
        padding: const EdgeInsets.all(16),
        style: const NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        child: FaIcon(
          category.icon,
          color: Style.iconColor,
          size: 32,
        ),
      ),
    );
  }
}

Widget flightShuttleBuilderFix(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  ///fix overflow flex
  return SingleChildScrollView(
    //fix missed style
    child: DefaultTextStyle(
        style: DefaultTextStyle.of(fromHeroContext).style,
        child: fromHeroContext.widget),
  );
}

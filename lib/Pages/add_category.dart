import 'package:crypto_dashboard/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/pages_arguments.dart';
import '../models/todo_models.dart';

import '../style.dart';
import '../utils/icons.dart';

class AddCategory extends StatefulWidget {
  final MainPageArguments args;

  AddCategory(this.args, {Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String title = '';
  IconData icon = icons_list.entries.first.value;
  AnimationPageInjection? animationPageInjection;

  bool get _argsHaveCategory => widget.args.category != null;

  ///check page transistion end
  ///if editing then return true
  bool get _transistionPageEnd =>
      animationPageInjection?.animationPage.value == 1 || _argsHaveCategory;

  bool get _canSave {
    if (title != null && icon != null) {
      return title.isNotEmpty;
    } else {
      return false;
    }
  }

  void categoryTitleChanget(String title) {
    setState(() {
      this.title = title;
    });
  }

  void iconChanget(IconData? icon) {
    setState(() {
      if (icon != null) {
        this.icon = icon;
      }
    });
  }

  @override
  void didChangeDependencies() {
    //update animation injection
    animationPageInjection = AnimationPageInjection.of(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        resizeToAvoidBottomInset: false,
        appBar: NeumorphicAppBar(
          title: _argsHaveCategory
              ? const Text('add_category.title_edit')
              : const Text('add_category.title_add'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(Style.mainPadding, Style.halfPadding,
                Style.mainPadding, Style.mainPadding),
            child: AnimatedOpacity(
              ///run Opacity animation when page transistion end
              opacity: _transistionPageEnd ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: Builder(builder: (context) {
                //if page transistion not end show empty widget
                if (!_transistionPageEnd) {
                  return const SizedBox.shrink();
                }
                return Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    runSpacing: Style.doublePadding,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: null,
                            labelText: 'add_category.name',
                            helperText: title,
                          ),
                          onChanged: categoryTitleChanget),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('add_category.icon'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Wrap(
                              alignment: WrapAlignment.spaceAround,
                              runSpacing: 16,
                              spacing: 16,
                              children: icons_list.entries
                                  .map((item) => NeumorphicRadio(
                                        groupValue: icon,
                                        padding: const EdgeInsets.all(16),
                                        style: const NeumorphicRadioStyle(
                                          boxShape: NeumorphicBoxShape.circle(),
                                        ),
                                        value: item.value,
                                        child: FaIcon(item.value,
                                            size: 18,
                                            color: item.value == icon
                                                ? NeumorphicTheme.accentColor(
                                                    context)
                                                : NeumorphicTheme
                                                    .defaultTextColor(context)),
                                        onChanged: iconChanget,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Style.halfPadding,
                      ),
                      Center(
                        child: NeumorphicButton(onPressed: null),
                      )
                    ]);
              }),
            )));
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

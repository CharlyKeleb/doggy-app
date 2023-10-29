import 'package:doggy/utils/config.dart';
import 'package:doggy/views/home/pages/breed/breed.dart';
import 'package:doggy/views/home/pages/sub_breed/sub_breed.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    _pages.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Breed",
          baseStyle: Config.textTheme.titleSmall!,
          colorLineSelected: Colors.white,
          selectedStyle: Config.textTheme.titleMedium!,
        ),
        const Breed(),
      ),
    );

    _pages.add(
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Sub-Breed",
          baseStyle: Config.textTheme.titleSmall!,
          colorLineSelected: Colors.white,
          selectedStyle: Config.textTheme.titleMedium!,
        ),
        const SubBreed(),
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      slidePercent: 60,
      backgroundColorMenu: Theme.of(context).colorScheme.secondary,
      elevationAppBar: 0.5,
      screens: _pages,
    );
  }
}

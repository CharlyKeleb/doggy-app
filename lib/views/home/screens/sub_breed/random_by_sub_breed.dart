import 'dart:async';

import 'package:doggy/components/navigate.dart';
import 'package:doggy/utils/config.dart';
import 'package:doggy/view_model/home/sub_breed_view_model.dart';
import 'package:doggy/views/home/screens/breed/breed_list.dart';
import 'package:doggy/views/home/screens/sub_breed/sub_breed_list.dart';
import 'package:doggy/widgets/card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RandomImageBySubBreed extends StatefulWidget {
  const RandomImageBySubBreed({super.key});

  @override
  State<RandomImageBySubBreed> createState() => _RandomImageBySubBreedState();
}

class _RandomImageBySubBreedState extends State<RandomImageBySubBreed> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Create a timer to call the function every 1000 milliseconds
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      Provider.of<SubBreedViewModel>(context, listen: false)
          .getRandomImageByBreedAndSubBreed();
    });
  }

  @override
  void dispose() {
    // Cancel the timer to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SubBreedViewModel viewModel = Provider.of<SubBreedViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Config.contentPadding(v: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: Config.contentPadding(h: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.keyboard_backspace),
                    ),
                    const SizedBox(width: 20.0),
                    const Text(
                      'Random Images',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigate.pushPageDialog(context, const SubBreedList());
                      },
                      child: Row(
                        children: [
                          Text(
                            viewModel.selectedSubBreed,
                            style: Config.textTheme.labelSmall,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: Icon(Icons.arrow_right),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CardView(imageURL: viewModel.randomImageURL ?? ""),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}

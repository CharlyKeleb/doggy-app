import 'package:doggy/components/animated_card/controller.dart';
import 'package:doggy/components/animated_card/custom_cards.dart';
import 'package:doggy/components/navigate.dart';
import 'package:doggy/model/enum/enum.dart';
import 'package:doggy/utils/config.dart';
import 'package:doggy/view_model/home/home_view_model.dart';
import 'package:doggy/views/home/screens/sub_breed/random_by_sub_breed.dart';
import 'package:doggy/views/home/screens/sub_breed/sub_breed_list.dart';
import 'package:doggy/widgets/card_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SubBreed extends StatefulWidget {
  const SubBreed({super.key});

  @override
  State<SubBreed> createState() => _SubBreedState();
}

class _SubBreedState extends State<SubBreed> {
  // Add a variable to track the number of cards swiped
  int swipedCardCount = 0;
  int counter = 4;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeViewModel>(context, listen: false)
          .getImagesByBreedAndSubBreed();
    });
    super.initState();
  }

  //create a CardController
  final CardController _cardController = CardController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    // Make sure to check if there are images in the viewModel
    if (viewModel.images != null && viewModel.images!.isNotEmpty) {
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
                      Text('Browse', style: Config.textTheme.titleSmall),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigate.pushPageDialog(
                              context, const SubBreedList());
                        },
                        child: Row(
                          children: [
                            Text(
                              'Select Sub-Breed',
                              style: Config.textTheme.labelSmall,
                            ),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CustomAnimatedCards(
                  cardController: _cardController,
                  context: context,
                  items: viewModel.images!.map((imageUrl) {
                    return CardView(
                      imageURL: imageUrl,
                    );
                  }).toList(),
                  onCardSwiped: (dir, index, widget) {
                    //Add the next card
                    if (counter <= 20) {
                      _cardController.addItem(
                        CardView(
                          imageURL: viewModel.images![index],
                        ),
                      );
                      counter++;
                    }

                    if (dir == Direction.left) {
                    } else if (dir == Direction.right) {
                    } else if (dir == Direction.up) {
                    } else if (dir == Direction.down) {}
                  },
                  enableSwipeUp: true,
                  enableSwipeDown: true,
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () => Navigate.pushPage(
                    context,
                    const RandomImageBySubBreed(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Random Image',
                        style: Config.textTheme.displayLarge,
                      ),
                      const SizedBox(width: 10.0),
                      const Icon(Icons.arrow_circle_right_sharp),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Show a loading indicator or error message
      // when images are loading or not available.
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }
}

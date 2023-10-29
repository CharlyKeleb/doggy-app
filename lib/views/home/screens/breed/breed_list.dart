import 'package:doggy/utils/config.dart';
import 'package:doggy/view_model/home/breed_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BreedList extends StatefulWidget {
  const BreedList({super.key});

  @override
  State<BreedList> createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  @override
  Widget build(BuildContext context) {
    BreedViewModel viewModel =
        Provider.of<BreedViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breed List',
          style: Config.textTheme.titleSmall,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, right: 20),
            child: GestureDetector(
              onTap: () async {
                viewModel.images!.clear();
                Navigator.pop(context);
                //get images list by breed
                viewModel.getImagesByBreed();
                //get random images by breed
                viewModel.getRandomImageByBreed();
              },
              child: Text('DONE', style: Config.textTheme.labelSmall),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Select Breed',
                style: Config.textTheme.labelLarge,
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 5.0,
                width: 130.0,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(),
            Flexible(
              child: ListView.builder(
                itemCount: viewModel.allBreeds!.length,
                itemBuilder: (BuildContext context, int index) {
                  var breed = viewModel.allBreeds![index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        viewModel.selectBreed(breed);
                      },
                      child: StatefulBuilder(builder: (context, snapshot) {
                        return Container(
                          height: 40.0,
                          color: viewModel.selectedBreed == breed
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              breed.toUpperCase(),
                              style: TextStyle(
                                color: viewModel.selectedBreed == breed
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

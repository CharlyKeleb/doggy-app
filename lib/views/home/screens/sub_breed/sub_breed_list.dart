import 'package:doggy/utils/config.dart';
import 'package:doggy/view_model/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubBreedList extends StatefulWidget {
  const SubBreedList({super.key});

  @override
  State<SubBreedList> createState() => _SubBreedListState();
}

class _SubBreedListState extends State<SubBreedList> {
  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = Provider.of<HomeViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sub-Breeds',
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
                //get images by breed and sub breed
                viewModel.getImagesByBreedAndSubBreed();
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
                'Select Sub-Breed',
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
                itemCount: viewModel.breedAndSubBreedList.length,
                itemBuilder: (BuildContext context, int index) {
                  var breed = viewModel.breedAndSubBreedList[index];
                  var subBreeds = viewModel.subBreedsMap[breed];

                  return ExpansionTile(
                    collapsedTextColor: Theme.of(context).colorScheme.secondary,
                    collapsedIconColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: EdgeInsets.zero,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    title: Text(
                      breed.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    children: [
                      for (var subreed in subBreeds!)
                        GestureDetector(
                          onTap: () {
                            viewModel.selectBreed(breed);
                            viewModel.selectSubBreed(subreed);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              subreed,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                decoration:
                                    viewModel.selectedSubBreed == subreed
                                        ? TextDecoration.underline
                                        : null,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

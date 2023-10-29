import 'package:doggy/services/dogs_service.dart';
import 'package:flutter/cupertino.dart';

class SubBreedViewModel extends ChangeNotifier {
  //booleans
  bool loading = false;

  //lists
  List<String>? images = [];
  List<String> breedAndSubBreedList = [];

  //services
  DogsService service = DogsService();

  //maps
  Map<String, List<String>> subBreedsMap = {};

  // Strings
  String selectedBreed = 'hound';
  String selectedSubBreed = 'afghan';
  String? randomImageURL;

  //get dog images by breed and sub breed
  getImagesByBreedAndSubBreed() async {
    loading = true;
    notifyListeners();
    //clear the images
    images!.clear();
    var result = await service.getImagesByBreedAndSubBreed(
      breed: selectedBreed,
      subBreed: selectedSubBreed,
    );
    try {
      loading = false;
      if (result!.status == "success") {
        setImages(result.message);
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print('Has Error');
    }
  }

  //get dog images by breed
  getRandomImageByBreedAndSubBreed() async {
    loading = true;
    notifyListeners();
    var result = await service.randomImageBySubBreed(
      breed: selectedBreed,
      subBreed: selectedSubBreed,
    );
    try {
      loading = false;
      if (result!.status == "success") {
        setRandomImage(result.message!);
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print('Has Error');
    }
  }

  Future<void> getDogBreedAndSubBreed() async {
    loading = true;
    notifyListeners();
    try {
      final breeds = await service.fetchDogBreeds();

      for (var breed in breeds.keys) {
        var subBreeds = breeds[breed];
        subBreedsMap[breed] = subBreeds!;
      }

      breedAndSubBreedList
          .addAll(subBreedsMap.keys); // Add main breeds to the list

      // Now 'breedAndSubBreedList' contains both main breeds and sub-breeds.
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  void selectBreed(String breed) {
    selectedBreed = breed;
    print('BREED SELECTED $breed');

    notifyListeners();
  }

  void selectSubBreed(String breed) {
    selectedSubBreed = breed;
    print('BREED SELECTED $breed');
    notifyListeners();
  }

  //setters
  setImages(List<String>? value) {
    images = value;
    print('IMAGES LIST $value');
    print('IMAGES LENGTH ${value!.length}');
    notifyListeners();
  }

  setRandomImage(String value) {
    randomImageURL = value;
    print('IMAGE URL $value');
    notifyListeners();
  }
}

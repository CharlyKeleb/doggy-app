import 'package:doggy/services/dogs_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  //services
  DogsService service = DogsService();

  //booleans
  bool loading = false;

  //list
  List<String>? images = [];
  List<String>? allBreeds = [];
  List<String> breedAndSubBreedList = [];

  //maps
  Map<String, List<String>> subBreedsMap = {};

  // String breed
  String selectedBreed = 'hound';
  String selectedSubBreed = 'afghan';

  String? randomImageURL;

  //get dog images by breed
  getImagesByBreed() async {
    loading = true;
    notifyListeners();
    //clear the images
    images!.clear();
    var result = await service.getImagesByBreed(breed: selectedBreed);
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
  getRandomImageByBreed() async {
    loading = true;
    notifyListeners();
    var result = await service.randomImageByBreed(breed: selectedBreed);
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

  Future<void> getDogBreeds() async {
    loading = true;
    notifyListeners();
    try {
      final breeds = await service.fetchDogBreeds();
      for (var breed in breeds.keys) {
        allBreeds?.addAll(breeds.keys);
        print(breed);
        final subBreeds = breeds[breed];
        print('Sub-breeds for $breed: $subBreeds');
        if (subBreeds != null && subBreeds.isNotEmpty) {
          // If there are sub-breeds, add them to the list
          subBreeds.addAll(subBreeds);
        }
      }
      // You can now use the 'breeds' Map to access the list of breeds and their sub-breeds.
    } catch (e) {
      print('Error: $e');
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

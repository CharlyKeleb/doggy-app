import 'package:doggy/view_model/home/breed_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreedViewModel', () {
    late BreedViewModel breedViewModel;

    setUp(() {
      breedViewModel = BreedViewModel();
    });

    test('BreedViewModel initial values are correct', () {
      expect(breedViewModel.loading, false);
      expect(breedViewModel.images, []);
      expect(breedViewModel.allBreeds, []);
      expect(breedViewModel.breedAndSubBreedList, isEmpty);
      expect(breedViewModel.selectedBreed, 'hound');
      expect(breedViewModel.selectedSubBreed, 'afghan');
      expect(breedViewModel.randomImageURL, isNull);
      expect(breedViewModel.subBreedsMap, isEmpty);
    });

    test('getImagesByBreed sets images correctly', () async {
      await breedViewModel.getImagesByBreed();

      expect(breedViewModel.loading, false);
      expect(breedViewModel.images, isNotEmpty);
    });

    test('getRandomImageByBreed sets randomImageURL correctly', () async {
      await breedViewModel.getRandomImageByBreed();

      expect(breedViewModel.loading, false);
      expect(breedViewModel.randomImageURL, isNotNull);
    });
  });
}

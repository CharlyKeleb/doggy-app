import 'dart:convert';
import 'package:doggy/model/images_model.dart';
import 'package:doggy/model/random_image_model.dart';
import 'package:doggy/utils/api.dart';
import 'package:http/http.dart' as http;

class DogsService {
  Future<ImageModel?> getImagesByBreed({
    required String breed,
  }) async {
    ImageModel? images;
    try {
      var response = await http.get(
        Uri.parse('${Api.dogBreedURL}/$breed/images'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        images = ImageModel.fromJson(data);
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return images!;
  }

  Future<ImageModel?> getImagesByBreedAndSubBreed({
    required String breed,
    required String subBreed,
  }) async {
    ImageModel? images;
    try {
      var response = await http.get(
        Uri.parse('${Api.baseURL}/breed/$breed/$subBreed/images'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        images = ImageModel.fromJson(data);
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return images!;
  }

  Future<RandomImageModel?> randomImageByBreed({
    required String breed,
  }) async {
    RandomImageModel? image;
    try {
      var response = await http.get(
        Uri.parse('${Api.dogBreedURL}/$breed/images/random'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        image = RandomImageModel.fromJson(data);
        print('RANDOM IMAGE $image');
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return image!;
  }

  Future<RandomImageModel?> randomImageBySubBreed({
    required String breed,
    required String subBreed,
  }) async {
    RandomImageModel? image;
    try {
      var response = await http.get(
        Uri.parse('${Api.baseURL}/breed/$breed/$subBreed/images/random'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        image = RandomImageModel.fromJson(data);
        print('RANDOM IMAGE $image');
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return image!;
  }

  Future<Map<String, List<String>>> fetchDogBreeds() async {
    final response = await http.get(Uri.parse(Api.allBreeds));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, List<String>> breeds = {};

      if (data['status'] == 'success') {
        final Map<String, dynamic> message = data['message'];

        for (var breed in message.keys) {
          final List<dynamic> subBreeds = message[breed];
          final List<String> subBreedList =
              subBreeds.map((e) => e.toString()).toList();
          breeds[breed] = subBreedList;
        }
      }
      return breeds;
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load dog breeds');
    }
  }
}

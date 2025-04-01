import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/pancake.dart';
import '../model/pancake_dto.dart';
import 'pancake_repository.dart';

class FirebasePancakeRepository extends PancakeRepository {
  static const String baseUrl =
      'https://pancake-c3cde-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String pancakesCollection = "pancakes";
  static const String allPancakesUrl = '$baseUrl/$pancakesCollection.json';

  @override
  Future<Pancake> addPancake(
      {required String color, required double price}) async {
    Uri uri = Uri.parse(allPancakesUrl);
    final newPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newPancakeData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add pancake');
    }

    final newId = json.decode(response.body)['name'];
    return Pancake(id: newId, color: color, price: price);
  }

  Future<void> deletePancake({required String id}) async {
    final Uri uri = Uri.parse('$baseUrl/$pancakesCollection/$id.json');
    final http.Response response = await http.delete(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.noContent) {
      throw Exception('Failed to delete pancake');
    }
  }

  @override
  Future<List<Pancake>> getPancakes() async {
    Uri uri = Uri.parse(allPancakesUrl);
    final http.Response response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load pancakes');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];
    return data.entries
        .map((entry) => PancakeDto.fromJson(entry.key, entry.value))
        .toList();
  }
}

import 'package:flutter/material.dart';
import '../repository/pancake_repository.dart';
import '../model/pancake.dart';
import 'async_value.dart';

class Pancakeprovider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;

  Pancakeprovider(this._repository) {
    fetchUsers();
  }

  bool get isLoading =>
      pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData =>
      pancakesState != null && pancakesState!.state == AsyncValueState.success;

  void fetchUsers() async {
    try {
      pancakesState = AsyncValue.loading();
      notifyListeners();

      pancakesState = AsyncValue.success(await _repository.getPancakes());
    } catch (error) {
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addPancake(String color, double price) async {
    if (pancakesState == null || pancakesState!.data == null) return;

    final List<Pancake> currentPancakes = List.from(pancakesState!.data!);
    final Pancake newPancake = Pancake(
      id: DateTime.now().toString(),
      color: color,
      price: price,
    );

    currentPancakes.add(newPancake);
    pancakesState = AsyncValue.success(currentPancakes);
    notifyListeners();

    try {
      final Pancake addedPancake =
          await _repository.addPancake(color: color, price: price);

      final int index =
          currentPancakes.indexWhere((p) => p.id == newPancake.id);
      if (index != -1) {
        currentPancakes[index] = addedPancake;
        pancakesState = AsyncValue.success(currentPancakes);
        notifyListeners();
      }
    } catch (error) {
      currentPancakes.remove(newPancake);
      pancakesState = AsyncValue.success(currentPancakes);
      notifyListeners();
    }
  }

  void deletePancake(String id) async {
    if (pancakesState == null || pancakesState!.data == null) return;

    final List<Pancake> currentPancakes = List.from(pancakesState!.data!);
    final Pancake pancakeToRemove = currentPancakes.firstWhere(
        (pancake) => pancake.id == id,
        orElse: () => Pancake(id: '', color: '', price: 0));

    currentPancakes.remove(pancakeToRemove);
    pancakesState = AsyncValue.success(currentPancakes);
    notifyListeners();

    try {
      await _repository.deletePancake(id: id);
    } catch (error) {
      currentPancakes.add(pancakeToRemove);
      pancakesState = AsyncValue.success(currentPancakes);
      notifyListeners();
    }
  }

  void editPancake(String id, String color, double price) async {
    if (pancakesState == null || pancakesState!.data == null) return;

    final List<Pancake> currentPancakes = List.from(pancakesState!.data!);
    final int index = currentPancakes.indexWhere((pancake) => pancake.id == id);

    if (index != -1) {
      final Pancake updatedPancake =
          Pancake(id: id, color: color, price: price);
      currentPancakes[index] = updatedPancake;
      pancakesState = AsyncValue.success(currentPancakes);
      notifyListeners();

      try {
        await _repository.deletePancake(id: id);
        await _repository.addPancake(color: color, price: price);
      } catch (error) {
        currentPancakes[index] = pancakesState!.data![index];
        pancakesState = AsyncValue.success(currentPancakes);
        notifyListeners();
      }
    }
  }
}

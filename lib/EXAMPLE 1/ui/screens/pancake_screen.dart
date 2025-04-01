import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/async_value.dart';
import '../../provider/pancake_provider.dart';
import '../../model/pancake.dart';
import 'pancake_form_screen.dart';

class PancakeScreen extends StatelessWidget {
  const PancakeScreen({super.key});

  void _onAddPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PancakeForm(),
      ),
    );
  }

  void _onDeletePressed(BuildContext context, String id) {
    final Pancakeprovider pancakeProvider = context.read<Pancakeprovider>();
    pancakeProvider.deletePancake(id);
  }

  @override
  Widget build(BuildContext context) {
    final pancakeProvider = Provider.of<Pancakeprovider>(context);

    Widget content;
    if (pancakeProvider.pancakesState == null ||
        pancakeProvider.pancakesState!.state == AsyncValueState.loading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (pancakeProvider.pancakesState!.state == AsyncValueState.error) {
      content = Center(
        child: Text(
          'Error: ${pancakeProvider.pancakesState!.error}',
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    } else if (pancakeProvider.pancakesState!.state ==
        AsyncValueState.success) {
      final List<Pancake> pancakes = pancakeProvider.pancakesState!.data!;

      if (pancakes.isEmpty) {
        content = const Center(
          child: Text(
            "No pancakes available.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      } else {
        content = ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: pancakes.length,
          itemBuilder: (context, index) => Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  pancakes[index].color[0].toUpperCase(),
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              title: Text(
                pancakes[index].color,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("\$${pancakes[index].price.toStringAsFixed(2)}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PancakeForm(pancake: pancakes[index]),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        _onDeletePressed(context, pancakes[index].id),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      content = const Center(child: Text("Unknown state."));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pancake List"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => _onAddPressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

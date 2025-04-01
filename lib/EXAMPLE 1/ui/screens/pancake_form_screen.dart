import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/pancake_provider.dart';
import '../../model/pancake.dart';

class PancakeForm extends StatefulWidget {
  final Pancake? pancake;

  const PancakeForm({super.key, this.pancake});

  @override
  _PancakeFormState createState() => _PancakeFormState();
}

class _PancakeFormState extends State<PancakeForm> {
  final _formKey = GlobalKey<FormState>();
  late String _color;
  late double _price;

  @override
  void initState() {
    super.initState();
    _color = widget.pancake?.color ?? '';
    _price = widget.pancake?.price ?? 0.0;
  }

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final pancakeProvider = context.read<Pancakeprovider>();

      if (widget.pancake == null) {
        pancakeProvider.addPancake(_color, _price);
      } else {
        pancakeProvider.editPancake(widget.pancake!.id, _color, _price);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pancake == null ? 'Add Pancake' : 'Edit Pancake'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _color,
                decoration: const InputDecoration(
                  labelText: 'Color',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a color';
                  }
                  return null;
                },
                onSaved: (value) {
                  _color = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _price.toString(),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _saveForm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    widget.pancake == null ? 'Add Pancake' : 'Save Changes',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

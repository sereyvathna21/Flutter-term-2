import 'package:flutter/material.dart';
import '../../../model/ride/locations.dart';
import '../../../repository/location_repository.dart';
import '../../../repository/mock/mock_location_preferences_repository.dart';

class LocationPickerScreen extends StatefulWidget {
  final List<Location> locations;

  const LocationPickerScreen({required this.locations, super.key});

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late List<Location> _filteredLocations;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _filteredLocations = widget.locations;
    _searchController = TextEditingController();
    _searchController.addListener(_filterLocations);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterLocations);
    _searchController.dispose();
    super.dispose();
  }

  void _filterLocations() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLocations = widget.locations
          .where((location) => location.name.toLowerCase().contains(query))
          .toList();
    });
  }

//location repository
  List<Location> getLocationsFor(String text) {
    // Instantiate the repository correctly
    InMemoryLocationRepository locationRepository =
        InMemoryLocationRepository();

    // Use getAllLocations() to retrieve the list of locations
    return locationRepository
        .getAllLocations()
        .where(
          (location) =>
              location.name.toUpperCase().contains(text.toUpperCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to gray
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the default back button
        backgroundColor: Colors.white, // Set top bar color to white
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200], // Set search bar color to light gray
            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            prefixIcon: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLocations.length,
              itemBuilder: (context, index) {
                final location = _filteredLocations[index];
                return ListTile(
                  title: Text(location.name),
                  onTap: () {
                    Navigator.of(context).pop(location);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

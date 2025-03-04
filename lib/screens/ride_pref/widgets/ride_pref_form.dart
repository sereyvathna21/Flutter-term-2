import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';

import 'ride_pref_input_tile.dart';

class RidePrefForm extends StatefulWidget {
  const RidePrefForm(
      {super.key, required this.initialPreference, required this.onSubmit});

  final RidePreference? initialPreference;
  final Function(RidePreference preference) onSubmit;

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();

    if (widget.initialPreference != null) {
      RidePreference current = widget.initialPreference!;
      departure = current.departure;
      arrival = current.arrival;
      departureDate = current.departureDate;
      requestedSeats = current.requestedSeats;
    } else {
      // Provide default values if initialPreference is null
      departure = Location(name: "siemreap", country: Country.cambodia);
      arrival = Location(name: "battambang", country: Country.cambodia);
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  void onDeparturePressed() async {
    Location? selectedLocation = await Navigator.of(context)
        .push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
      initLocation: departure,
    )));

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    Location? selectedLocation = await Navigator.of(context)
        .push<Location>(AnimationUtils.createBottomToTopRoute(BlaLocationPicker(
      initLocation: arrival,
    )));

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSubmit() {
    bool hasDeparture = departure != null;
    bool hasArrival = arrival != null;
    bool isValid = hasDeparture && hasArrival;

    if (isValid) {
      RidePreference newPreference = RidePreference(
          departure: departure!,
          departureDate: departureDate,
          arrival: arrival!,
          requestedSeats: requestedSeats,
          petsAccepted: false);

      widget.onSubmit(newPreference); // Pass the preference to the callback
    }
  }

  void onSwappingLocationPressed() {
    setState(() {
      if (departure != null && arrival != null) {
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  String get departureLabel =>
      departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          child: Column(
            children: [
              RidePrefInputTile(
                isPlaceHolder: showDeparturePLaceHolder,
                title: departureLabel,
                leftIcon: Icons.location_on,
                onPressed: onDeparturePressed,
                rightIcon: switchVisible ? Icons.swap_vert : null,
                onRightIconPressed:
                    switchVisible ? onSwappingLocationPressed : null,
              ),
              const BlaDivider(),
              RidePrefInputTile(
                  isPlaceHolder: showArrivalPLaceHolder,
                  title: arrivalLabel,
                  leftIcon: Icons.location_on,
                  onPressed: onArrivalPressed),
              const BlaDivider(),
              RidePrefInputTile(
                  title: dateLabel,
                  leftIcon: Icons.calendar_month,
                  onPressed: () => {}),
              const BlaDivider(),
              RidePrefInputTile(
                  title: numberLabel,
                  leftIcon: Icons.person_2_outlined,
                  onPressed: () => {})
            ],
          ),
        ),
        BlaButton(text: 'Search', onPressed: onSubmit),
      ],
    );
  }
}

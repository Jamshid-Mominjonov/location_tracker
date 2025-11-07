import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location_tracker/pages/viewPage.dart';
import '../providers/location_state.dart';
import '../riverpod.dart';
import '../widgets/customButton.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationProvider);
    final notifier = ref.read(locationProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Location Tracker",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is LocationLoading)
              const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              state is LocationError
                  ? state.message
                  : state is LocationSuccess && state.locations.isNotEmpty
                  ? "Address: ${state.locations.last.address}"
                  : state is LocationSuccess && state.locations.isEmpty
                  ? "No location"
                  : "",
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: "START",
              onPressed: notifier.startGetLocation,
              color: Colors.indigo,
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: "STOP",
              onPressed: notifier.stopGetLocation,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 50),
            CustomButton(
              text: "VIEW",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SavedLocationsPage(),
                  ),
                );
              },
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
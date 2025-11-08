import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/location_state.dart';
import '../riverpod.dart';

class SavedLocationsPage extends ConsumerWidget {
  const SavedLocationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationProvider);
    final notifier = ref.read(locationProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier.getSavedLocations();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Saved Locations",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){notifier.clearAllLocations();}, icon: Icon(Icons.delete), color: Colors.red,),
        ],
      ),
      body: state is LocationLoading
          ? const Center(child: CircularProgressIndicator())
          : state is LocationError
          ? Center(
        child: Text(
          state.message,
          style: const TextStyle(color: Colors.red),
        ),
      )
          : state is LocationSuccess
          ? state.locations.isEmpty
          ? const Center(child: Text("No saved locations"))
          : ListView.builder(
        itemCount: state.locations.length,
        itemBuilder: (context, index) {
          final loc = state.locations[index];
          final dateFormat = DateFormat('dd MMM yyyy, HH:mm:ss ').format(loc.time.toLocal());
          return ListTile(
            title: Text(
                style: TextStyle(fontSize: 17),
                "${loc.address}\n $dateFormat"),

          );
        },
      )
          : const Center(child: Text("")),
    );
  }
}
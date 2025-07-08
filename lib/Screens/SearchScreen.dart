import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vpn_app/Controller/CountryController.dart';
import 'package:vpn_app/Utils/Colors.dart';
import 'package:vpn_app/Widgets/CountryTile.dart';
import 'package:vpn_app/Widgets/BottomNavigationBar.dart';

class SearchScreen extends StatelessWidget {
  final CountryController controller = Get.put(CountryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1,
        title: const Text("Search", style: TextStyle(fontFamily: 'Gilroy')),
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(color: SpecialColors.textColorDarkGray),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search for Country or City',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: SpinKitFadingCube(
                    color: SpecialColors.mainColor,
                    size: 50.0,
                  ),
                );
              }

              final countries = controller.filteredCountries;
              if (countries.isEmpty) {
                return const Center(child: Text('No countries found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return GestureDetector(
                    onTap: () {
                      controller.connectToCountry(country);
                      Get.back();
                    },
                    child: CountryTile(
                      flag: country.flagCode,
                      name: country.name,
                      city: country.city,
                      locations: country.locationCount,
                      strength: country.strength,
                      isConnected: country.isConnected,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}

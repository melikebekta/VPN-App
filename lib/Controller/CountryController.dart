import 'dart:async';

import 'package:get/get.dart';

class CountryModel {
  final String name;
  final String flagCode;
  final String? city;
  final int locationCount;
  final int strength;
  final bool isConnected;

  CountryModel({
    required this.name,
    required this.flagCode,
    this.city,
    required this.locationCount,
    required this.strength,
    this.isConnected = false,
  });

  CountryModel copyWith({
    String? name,
    String? flagCode,
    String? city,
    int? locationCount,
    int? strength,
    bool? isConnected,
  }) {
    return CountryModel(
      name: name ?? this.name,
      flagCode: flagCode ?? this.flagCode,
      city: city ?? this.city,
      locationCount: locationCount ?? this.locationCount,
      strength: strength ?? this.strength,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}

class CountryController extends GetxController {
  var countries = <CountryModel>[
    CountryModel(name: 'Italy', flagCode: 'it', locationCount: 4, strength: 70),
    CountryModel(
      name: 'Netherlands',
      flagCode: 'nl',
      city: 'Amsterdam',
      locationCount: 12,
      strength: 85,
    ),
    CountryModel(
      name: 'Germany',
      flagCode: 'de',
      locationCount: 10,
      strength: 90,
    ),
  ].obs;

  var searchQuery = ''.obs;
  var isLoading = false.obs;
  var downloadSpeed = 0.obs;
  var uploadSpeed = 0.obs;
  var signalStrength = 0.obs;
  var isConnecting = false.obs;

  List<CountryModel> get filteredCountries {
    final query = searchQuery.value.toLowerCase();
    return countries.where((c) {
      return c.name.toLowerCase().contains(query) ||
          (c.city?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  void updateSearchQuery(String value) async {
    searchQuery.value = value;
    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    isLoading.value = false;
  }

  void connectToCountry(CountryModel selected) async {
    isConnecting.value = true;
    await Future.delayed(Duration(seconds: 2));
    countries.value = countries.map((c) {
      return c.name == selected.name
          ? c.copyWith(isConnected: true)
          : c.copyWith(isConnected: false);
    }).toList();

    isConnected.value = true;
    downloadSpeed.value = 527;
    uploadSpeed.value = 49;
    signalStrength.value = 14;
    startConnectionTimer();
    isConnecting.value = false;
  }

  late Timer _timer;
  var connectedTime = Duration().obs;
  var isConnected = false.obs;

  void startConnectionTimer() {
    connectedTime.value = Duration.zero;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      connectedTime.value += Duration(seconds: 1);
    });
  }

  void stopConnectionTimer() {
    _timer.cancel();
  }

  Future<void> disconnect() async {
    isConnecting.value = true;
    await Future.delayed(Duration(seconds: 1));

    countries.value = countries
        .map((c) => c.copyWith(isConnected: false))
        .toList();
    isConnected.value = false;
    stopConnectionTimer();
    connectedTime.value = Duration.zero;
    downloadSpeed.value = 0;
    uploadSpeed.value = 0;
    signalStrength.value = 0;

    isConnecting.value = false;
  }
}

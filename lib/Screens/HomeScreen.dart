import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/CountryController.dart';
import 'package:vpn_app/Screens/SearchScreen.dart';
import 'package:vpn_app/Utils/Colors.dart';
import 'package:vpn_app/Widgets/BottomNavigationBar.dart';
import 'package:vpn_app/Widgets/CountryTile.dart';

void main() {
  runApp(VPNApp());
}

class VPNApp extends StatefulWidget {
  VPNApp({super.key});

  @override
  State<VPNApp> createState() => _VPNAppState();
}

class _VPNAppState extends State<VPNApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          primary: Colors.blue,
          secondary: Color(0xFFF1F1F1),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: SpecialColors.textColorGray,
        colorScheme: ColorScheme.dark(
          background: SpecialColors.textColorGray,
          primary: Colors.grey,
          secondary: Colors.grey,
        ),
      ),
      themeMode: _themeMode,
      home: VPNHomePage(onToggleTheme: toggleTheme),
    );
  }
}

class VPNHomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final CountryController controller = Get.put(CountryController());

  VPNHomePage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: SpecialColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Image.asset(
                          'assets/icon/menu.png',
                          width: 24,
                          height: 24,
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: onToggleTheme,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Icon(Icons.light_mode, color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "Countries",
                          style: TextStyle(
                            color: SpecialColors.textColorWhite,
                            fontSize: 18,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        Image.asset(
                          'assets/icon/premium.png',
                          width: 40,
                          height: 40,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },

                    child: Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: true,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search For Country Or City',
                                hintStyle: TextStyle(
                                  color: SpecialColors.textColorGray,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/icon/search.png',
                          width: 28,
                          height: 28,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Connecting Time',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Gilroy',
              color: SpecialColors.textColorDarkGray,
            ),
          ),
          const SizedBox(height: 5),
          Obx(() {
            final duration = controller.connectedTime.value;
            String formatTime(int n) => n.toString().padLeft(2, '0');
            final timeText =
                "${formatTime(duration.inHours)} : ${formatTime(duration.inMinutes.remainder(60))} : ${formatTime(duration.inSeconds.remainder(60))}";

            return Text(
              timeText,
              style: const TextStyle(
                color: SpecialColors.textColorDarkGray,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'GilroyBold',
              ),
            );
          }),

          const SizedBox(height: 25),
          Obx(() {
            final connected = controller.countries.firstWhereOrNull(
              (c) => c.isConnected,
            );
            if (connected == null) return SizedBox.shrink();

            return Container(
              width: 310,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.all(16),
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      'https://flagcdn.com/w40/${connected.flagCode}.png',
                      width: 40,
                      height: 38,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        connected.name,
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: SpecialColors.textColorGray,
                        ),
                      ),
                      Text(
                        connected.city ?? '',
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 10,
                          color: SpecialColors.textColorGray,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Stealth",
                        style: TextStyle(
                          fontFamily: 'Gilroy',
                          fontSize: 10,
                          color: SpecialColors.textColorGray,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "${controller.signalStrength.value}%",
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: SpecialColors.textColorDarkGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/download.png',
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Download :',
                          style: TextStyle(
                            color: SpecialColors.textColorGray,
                            fontFamily: 'Gilroy',
                            fontSize: 13,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${controller.uploadSpeed.value} MB',
                            style: TextStyle(
                              color: SpecialColors.textColorDarkGray,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(16),
                width: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon/upload.png',
                      width: 35,
                      height: 35,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload :',
                          style: TextStyle(
                            color: SpecialColors.textColorGray,
                            fontFamily: 'Gilroy',
                            fontSize: 13,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${controller.uploadSpeed.value} MB',
                            style: TextStyle(
                              color: SpecialColors.textColorDarkGray,
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Free Locations (3)',
                  style: TextStyle(
                    color: SpecialColors.textColorGray,
                    fontFamily: 'Gilroy',
                    fontSize: 13,
                  ),
                ),
                Icon(Icons.error, color: SpecialColors.textColorGray, size: 16),
              ],
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                CountryTile(
                  city: '',
                  flag: 'it',
                  name: 'Italy',
                  locations: 4,
                  isConnected: true,
                ),
                CountryTile(
                  city: '',
                  flag: 'nl',
                  name: 'Netherlands',
                  locations: 12,
                  isConnected: false,
                ),
                CountryTile(
                  city: '',
                  flag: 'de',
                  name: 'Germany',
                  locations: 10,
                  isConnected: false,
                ),
                CountryTile(
                  city: '',
                  flag: 'de',
                  name: 'Germany',
                  locations: 10,
                  isConnected: false,
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Bottomnavigationbar(),
    );
  }
}

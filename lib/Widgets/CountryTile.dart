import 'package:flutter/material.dart';
import 'package:vpn_app/Controller/CountryController.dart';
import 'package:vpn_app/Utils/Colors.dart';
import 'package:get/get.dart';

class CountryTile extends StatefulWidget {
  final String flag;
  final String name;
  final String? city;
  final int locations;
  final int strength;
  final bool isConnected;

  const CountryTile({
    super.key,
    required this.flag,
    required this.name,
    required this.locations,
    this.city,
    this.strength = 0,
    this.isConnected = false,
  });

  @override
  State<CountryTile> createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  late bool _isPowerConnected;
  late bool _isArrowActivated;
  final controller = Get.find<CountryController>();

  @override
  void initState() {
    super.initState();
    _isPowerConnected = widget.isConnected;
    _isArrowActivated = false;
  }

  void _toggleArrow() {
    setState(() {
      _isArrowActivated = !_isArrowActivated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://flagcdn.com/w40/${widget.flag.toLowerCase()}.png',
              width: 50,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Gilroy',
                    color: SpecialColors.textColorDarkGray,
                  ),
                ),
                if (widget.city != null && widget.city!.isNotEmpty)
                  Text(
                    widget.city!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: SpecialColors.textColorGray,
                      fontFamily: 'Gilroy',
                    ),
                  ),
                Text(
                  '${widget.locations} Locations',
                  style: const TextStyle(
                    color: SpecialColors.textColorGray,
                    fontFamily: 'Gilroy',
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Obx(() {
            final isLoading = controller.isConnecting.value;
            final isConnected = widget.isConnected;

            return GestureDetector(
              onTap: () {
                if (isConnected) {
                  controller.disconnect();
                } else {
                  controller.connectToCountry(
                    CountryModel(
                      name: widget.name,
                      flagCode: widget.flag,
                      city: widget.city,
                      locationCount: widget.locations,
                      strength: widget.strength,
                    ),
                  );
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isConnected
                      ? SpecialColors.mainColor
                      : SpecialColors.boxBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading
                    ? const Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.power_settings_new,
                        color: isConnected
                            ? Colors.white
                            : SpecialColors.textColorDarkGray,
                        size: 24,
                      ),
              ),
            );
          }),

          const SizedBox(width: 10),
          GestureDetector(
            onTap: _toggleArrow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isArrowActivated
                        ? SpecialColors.mainColor
                        : SpecialColors.boxBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: _isArrowActivated
                      ? Colors.white
                      : SpecialColors.textColorDarkGray,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

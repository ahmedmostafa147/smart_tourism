import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_icons/country_icons.dart';

class Country {
  final String name;
  final String countryCode;

  Country(this.name, this.countryCode);
}

class CountryController extends GetxController {
  var favoriteCountries = <Country>[].obs;

  void toggleFavorite(Country country) {
    if (favoriteCountries.contains(country)) {
      favoriteCountries.remove(country);
    } else {
      favoriteCountries.add(country);
    }
  }
}

class CountrySelectionPage extends StatelessWidget {
  final CountryController controller = Get.put(CountryController());

  final List<Country> countries = [
    Country('Egypt', 'eg'),
    Country('Saudi Arabia', 'sa'),
    Country('UAE', 'ae'),
    Country('Oman', 'om'),
    Country('Lebanon', 'lb'),
    Country('Morocco', 'ma'),
    Country('Algeria', 'dz'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Favorite Countries'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          return GestureDetector(
            onTap: () {
              controller.toggleFavorite(country);
            },
            child: Obx(() {
              final isSelected = controller.favoriteCountries.contains(country);
              return GridTile(
                child: Image.asset(
                  'icons/flags/png/${country.countryCode}.png',
                  package: 'country_icons',
                  fit: BoxFit.cover,
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(country.name),
                  trailing: Icon(
                    isSelected ? Icons.favorite : Icons.favorite_border,
                    color: isSelected ? Colors.red : Colors.white,
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final selectedCountries =
              controller.favoriteCountries.map((c) => c.name).join(', ');
          Get.snackbar('Selected Countries',
              selectedCountries.isNotEmpty ? selectedCountries : 'None');
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

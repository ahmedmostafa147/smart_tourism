import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smart_tourism/Controller/Survay/survay_controller.dart';

class Recommendation {
  final String title;
  final double price;
  final String tags;
  final String governorate;
  final int day;

  Recommendation({
    required this.title,
    required this.price,
    required this.tags,
    required this.governorate,
    required this.day,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      title: json['Title'],
      price: json['Price'],
      tags: json['Tags'],
      governorate: json['Governorate'],
      day: json['Day'],
    );
  }
}

class ModelAIController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final TextEditingController countryController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController numDaysController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final RxList<Recommendation> recommendations = <Recommendation>[].obs;
  final RxList<String> filteredCountries = RxList<String>();
  final RxList<String> filteredGovernorates = RxList<String>();
  final RxList<String> filterednumDays = RxList<String>();
  final RxList<String> filteredbudget = RxList<String>();
  final List<String> countries = [
    'Egypt',
    "Algeria",
    "Iraq",
    "Jordan",
    "Lebanon",
    "Morocco",
    "Saudi Arabia",
    "Oman",
    "Qatar",
    "Bahrain",
    "Syria",
    "United Arab Emirates",
    "Tunisia"
  ];

  final List<Map<String, dynamic>> governorates = [
    {
      "country": "Egypt",
      "governorates": [
        "Cairo",
        "Alexandria",
        "Giza",
        "Shubra El-Kheima",
        "Port Said",
        "Suez",
        "Luxor",
        "Mansoura",
        "El-Mahalla El-Kubra",
        "Tanta",
        "Asyut",
        "Ismailia",
        "Fayyum",
        "Zagazig",
        "Aswan",
        "Damietta",
        "Damanhur",
        "El-Minya",
        "Beni Suef",
        "Hurghada",
        "Qena",
        "Sohag",
      ],
    },
    {
      "country": "Algeria",
      "governorates": [
        "Algiers",
        "Oran",
        "Constantine",
        "Annaba",
        "Blida",
        "Batna",
        "Djelfa",
        "Sétif",
        "Sidi Bel Abbès",
        "Biskra",
      ],
    },
    {
      "country": "Iraq",
      "governorates": [
        "Baghdad",
        "Basra",
        "Mosul",
        "Erbil",
        "Sulaymaniyah",
        "Kirkuk",
        "Najaf",
        "Karbala",
      ],
    },
    {
      "country": "Jordan",
      "governorates": [
        "Amman",
        "Zarqa",
        "Irbid",
        "Aqaba",
        "Salt",
        "Mafraq",
        "Madaba",
        "Karak",
      ],
    },
    {
      "country": "Lebanon",
      "governorates": [
        "Beirut",
        "Tripoli",
        "Sidon",
        "Tyre",
        "Jounieh",
        "Zahle",
        "Byblos",
        "Baalbek",
      ],
    },
    {
      "country": "Morocco",
      "governorates": [
        "Casablanca",
        "Rabat",
        "Fes",
        "Marrakech",
        "Agadir",
        "Tangier",
        "Meknes",
        "Oujda",
        "Kenitra",
        "Tetouan",
        "Safi",
        "El Jadida",
        "Nador",
        "Larache",
        "Khouribga",
        "Taza",
        "Settat",
        "Berrechid",
        "Beni Mellal",
        "Ouarzazate",
        "Sidi Kacem",
        "Tan-Tan",
        "Khemisset",
        "Taourirt",
        "Dakhla",
        "Taroudant",
        "Essaouira",
        "Tiznit",
        "Al Hoceima",
        "Lagouira",
        "Guelmim",
        "Tiznit",
        "Laayoune",
        "Boujdour",
        "Tata",
        "Figuig",
        "Guercif",
        "Oued Ed-Dahab",
        "Sidi Ifni",
        "Midelt",
        "Azilal",
        "Figuig",
        "Tinghir",
        "Sefrou",
        "El Hajeb",
        "Boulemane",
        "Taounate",
        "Sefrou",
        "Jerada",
        "Ouezzane",
        "Chefchaouen",
        "Fahs-Anjra",
        "Sidi Slimane",
      ],
    },
    {
      "country": "Saudi Arabia",
      "governorates": [
        "Riyadh",
        "Jeddah",
        "Mecca",
        "Medina",
        "Dammam",
        "Tabuk",
        "Buraidah",
        "Khamis Mushait",
        "Abha",
        "Al-Kharj",
        "Al-Hofuf",
        "Hail",
        "Najran",
        "Yanbu",
        "Al-Jubail",
        "Al-Qatif",
        "Hafr Al-Batin",
        "Arar",
        "Sakaka",
        "Jizan",
        "Al-Bahah",
        "Rafha",
        "Dawadmi",
        "Al-Dawadmi",
        "Al-Majmaah",
        "Al-Mubarraz",
        "Al-Ula",
        "Badr",
        "Baljurashi",
        "Bisha",
        "Dhahran",
        "Dumat Al-Jandal",
        "Gurayat",
        "Hafar Al-Batin",
        "Hail",
        "Jazan",
        "Jizan",
        "Khafji",
        "Khobar",
        "Majmaah",
        "Makkah",
        "Muzahmiyya",
        "Najran",
        "Qatif",
        "Qurayyat",
        "Rabigh",
        "Rafha",
        "Riyadh",
        "Saihat",
        "Sakakah",
        "Tabuk",
        "Taif",
        "Tarut",
        "Turaif",
        "Umluj",
        "Unaizah",
        "Yanbu",
        "Zulfi",
      ],
    },
    {
      "country": "Oman",
      "governorates": [
        "Muscat",
        "Salalah",
        "Sohar",
        "Nizwa",
        "Sur",
        "Barka",
        "Ibri",
        "Rustaq",
        "Al Buraimi",
        "Suhar",
        "Bahla",
        "Ibra",
        "Izki",
        "Bidbid",
        "Adam",
        "Yanqul",
        "Khasab",
        "Thumrait",
      ]
    },
    {
      "country": "Qatar",
      "governorates": [
        "Doha",
        "Al Rayyan",
        "Umm Salal",
        "Al Wakrah",
        "Al Khor",
        "Al Shamal",
        "Al Daayen",
        "Madinat ash Shamal",
        "Al Ghuwayriyah",
        "Al Jumaliyah",
        "Al Khawr",
        "Al Wakrah",
        "Jariyan al Batnah",
        "Madinat ash Shamal",
        "Umm Salal",
      ],
    },
    {
      "country": "Bahrain",
      "governorates": [
        "Manama",
        "Muharraq",
        "Riffa",
        "Hamad Town",
        "A'ali",
        "Isa Town",
        "Sitra",
        "Budaiya",
        "Jidhafs",
        "Al-Malikiyah",
        "Juffair",
        "Sanabis",
        "Seef",
        "Zallaq",
        "Adliya",
        "Al Jasra",
        "Al-Markh",
        "Barbar",
        "Bilad Al Qadeem",
        "Budaiya",
        "Busaiteen",
        "Daih",
        "Diplomatic Area",
        "Durrat Al Bahrain",
        "East Riffa",
        "Galali",
        "Gudaibiya",
        "Hidd",
        "Hoora",
        "Isa Town",
        "Jannusan",
        "Jidhafs",
        "Juffair",
        "Karzakan",
        "Ma'ameer",
        "Madinat Hamad",
        "Madinat Isa",
        "Muharraq",
        "Nabih Saleh",
        "Northern City",
        "Riffa",
        "Sakhir",
        "Salmabad",
        "Sanabis",
        "Sar",
        "Seef",
        "Shahrakan",
        "Shakhura",
        "Sitrah",
        "Tashan",
        "Tubli",
        "Umm an Nasan",
        "Zallaq",
      ],
    },
    {
      "country": "Syria",
      "governorates": [
        "Damascus",
        "Aleppo",
        "Homs",
        "Latakia",
        "Hama",
        "Deir ez-Zor",
        "Raqqa",
        "Idlib",
        "Daraa",
        "As-Suwayda",
        "Tartus",
        "Al-Hasakah",
        "Quneitra",
        "Al-Qamishli",
        "Al-Hasakah",
        "Al-Malikiyah",
        "Al-Qamishli",
        "Al-Qahtaniyah",
        "Al-Qamishli",
        "Al-Yaarubiyah",
        "Al-Qamishli",
        "Amuda",
        "Al-Hasakah",
        "Ayn al-Arab",
        "Kobani",
        "Baniyas",
        "Tartus",
        "Bosra",
        "Daraa",
        "Darayya",
        "Rif Dimashq",
        "Duma",
        "Rif Dimashq",
        "Hama",
        "Homs",
        "Homs",
        "Idlib",
        "Idlib",
        "Jableh",
        "Latakia",
        "Latakia",
        "Maaloula",
        "Rif Dimashq",
      ]
    }
  ];
  final List<String> numDays = ['1', '2', '3', '4', '5'];
  final List<String> budget = ['1000', '2000', '3000', '4000', '5000'];
  SurveySaveController surveySaveController = Get.put(SurveySaveController());

  @override
  void onInit() {
    super.onInit();
    loadSurveyResults();
  }

  Future<void> loadSurveyResults() async {
    await surveySaveController.fetchSurveyResults();
  }

  void showAllCountries() {
    filteredCountries.value = countries;
  }

  List<String> getGovernoratesByCountry(String country) {
    final countryData = governorates.firstWhere(
      (element) => element['country'] == country,
      orElse: () => {"country": "", "governorates": []},
    );
    return List<String>.from(countryData['governorates']);
  }

  void showGovernoratesForSelectedCountry(String country) {
    filteredGovernorates.value = getGovernoratesByCountry(country);
  }

  void showAllnumDays() {
    filterednumDays.value = numDays;
  }

  void showAllbudget() {
    filteredbudget.value = budget;
  }

  Future<void> getRecommendations() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      recommendations.clear();

      final Map<String, dynamic> requestData = {
        "country": countryController.text.trim(),
        "governorate": governorateController.text.trim(),
        "survey_responses": surveySaveController.surveyResults,
        "num_days": numDaysController.text.trim(),
        "budget": budgetController.text.trim(),
      };

      var url = Uri.parse(
          "https://model-smart-tourism.onrender.com/recommendations/");
      final http.Response response = await http.post(
        url,
        body: jsonEncode(requestData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);
        print(surveySaveController.surveyResults);
        data.forEach((element) {
          recommendations.add(Recommendation.fromJson(element));
        });
      } else {
        throw Exception('Failed to load recommendations');
      }
    } catch (e) {
      print('Failed to load recommendations: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

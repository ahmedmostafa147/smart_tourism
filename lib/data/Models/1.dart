import '../../constants/images.dart';

class Travel{
  //model variables
  final String name;
  final String description;
  final int duration;
  final String location;
  final double rating;
  final int distance;
  final double cost;
  final List<String> imageUrl;

  //model constuctor
  Travel(this.name, this.duration, this.description, this.location, this.rating, this.distance, this.imageUrl, this.cost);

  //List of travel items
static List<Travel> getTravelItems(){
  final List<Travel> _travelList = [
    Travel('Magic Tower',4, 'The building where the heights meets the golden touches', 'Cairo, Egypt', 4.6, 3, [Assets.imagesImg1, Assets.imagesThumbnail1], 230),
    Travel('Dubai Burg',5, 'Built on top of a man-made island, this building is a masterpiece', 'Dubai, UAE', 4.3, 6, [Assets.imagesImg2, Assets.imagesThumbnail2], 432),
    Travel('Arc Bridge',3, 'Visit and experience the magic of the oldest arc bridge in the world', 'Rhodes, Greece', 4.5, 8, [Assets.imagesImg3, Assets.imagesThumbnail3], 283),
    Travel('Magic Beaches',3, 'Do you have a taste for beaches, and camels. Magic Sandy Beaches is for you', 'Santo, Vanuatu', 4.2, 16, [Assets.imagesImg4, Assets.imagesThumbnail4], 389),
    Travel('Blue Nature',2, 'The beach offers senernity and deep connection to the mother nature', 'Ayia, Cyprus', 4.8, 21, [Assets.imagesImg5, Assets.imagesThumbnail5], 534),
  ];
  return _travelList;
}

//Get the nearest list items (Those whose distance is less than 10kms
static List<Travel> getNearestItems(){
  List<Travel> _travelList = Travel.getTravelItems();
  return _travelList.where((element) => element.distance < 10).toList();
}

}
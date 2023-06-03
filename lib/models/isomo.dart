// MODEL TO REPRESENT THE ISOMO
class IsomoModel {
  // TITLE AND DESCRIPTION
  String id = '';
  String title = '';
  String description = '';
  String introText = '';

  // CONSTRUCTOR
  IsomoModel({ required this.id, required this.title, required this.description, required this.introText });

  // TO STRING
  @override
  String toString() {
    return 'IsomoModel{id: $id, title: $title, description: $description, introText: $introText}';
  }
}

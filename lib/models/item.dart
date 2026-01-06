class Item {
  int? id;
  int userId;
  String title;
  String description;
  String category;
  String location;
  String status;
  String imagePath;
  String? userName;

  Item({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    this.status='lost',
    this.imagePath='',
    this.userName,
  });

  Map<String,String> toMap(){
    return {
      'user_id':userId.toString(),
      'title':title,
      'description':description,
      'category':category,
      'location':location,
      'status':status,
      'image_path':imagePath,
    };
  }

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
      id: int.parse(json['id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      title: json['title'],
      description: json['description'],
      category: json['category'],
      location: json['location'],
      status: json['status'],
      imagePath: json['image_path'] ?? '',
      userName: json['name'] ?? '',
    );
  }
}

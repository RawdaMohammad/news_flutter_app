class OnBoardingModel{
  final String? image;
  final String? title;
  final String? desc;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) {
    return OnBoardingModel(
      image: json["image"],
      title: json["title"],
      desc: json["desc"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "desc": desc,
    };
  }


}
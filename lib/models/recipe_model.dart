class RecipeModel {
  String? appLabel;
  String? appImgUrl;
  double? appCalories;
  String? appUrl;

  RecipeModel({
    required this.appCalories,
    required this.appImgUrl,
    required this.appLabel,
    required this.appUrl,
  });

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      appCalories: recipe['calories'],
      appImgUrl: recipe['image'],
      appLabel: recipe['label'],
      appUrl: recipe['url'],
    );
  }
}

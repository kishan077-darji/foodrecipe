import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:foodrecipe/models/recipe_model.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RecipeModel> recipeList = <RecipeModel>[];
  List recipeCatList = [
    {
      "imgUrl": "https://source.unsplash.com/NnTQBkBkU9g",
      "heading": "Sweet Food",
    },
    {
      "imgUrl": "https://source.unsplash.com/BgHfl1p3yAA",
      "heading": "Chilli Food",
    },
    {
      "imgUrl": "https://source.unsplash.com/CbNAuxSZTFo",
      "heading": "Pizza",
    },
    {
      "imgUrl": "https://source.unsplash.com/Lntnns1YBEY",
      "heading": "Hot dog",
    },
  ];
  TextEditingController searchController = TextEditingController();

  void getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=c22f0c4d&app_key=f68f3cdf5b00d01b97ae8f810ba668aa";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data['hits'].forEach((element) {
      RecipeModel recipeModel = RecipeModel(
          appCalories: 0.0, appImgUrl: '', appLabel: '', appUrl: '');
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);
    });
    // for (var element in recipeList) {
    //   print(element.appLabel);
    // }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xff213A50),
                Color(0xff071938),
              ]),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search recipe",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              log("Blank dearch");
                            } else {
                              getRecipe(searchController.text);
                            }
                          },
                          child: const Icon(
                            Icons.search,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook Something New..",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recipeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Card(
                          margin: const EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0.0,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  recipeList[index].appImgUrl.toString(),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 200,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      )),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(
                                    recipeList[index].appLabel.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: recipeCatList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        recipeCatList[index]["imgUrl"],
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 250,
                                      )),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            recipeCatList[index]["heading"],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma/menulistscreen.dart';
import 'package:figma/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  List locationlist = ["Bilzen, Tanjungbalai", "location"];
  String searchKey = "";
  late Stream streamQuery;
  TextEditingController searchController = TextEditingController();
  String txxt = "Cappucino";
  final ScrollController _scrollController = ScrollController();
  int currentposition = 0;
  String category = "Cappucino";
  List buttons = [
    "Cappucino",
    "Machiato",
    "Latte",
    "Americano",
  ];

  categoryFn(String cat) {
    streamQuery = FirebaseFirestore.instance
        .collection("items")
        .where('name', isEqualTo: cat)
        .snapshots();

    MenuListScreen(
      streamQery: streamQuery,
    );
  }

  @override
  void initState() {
    super.initState();
    categoryFn(category);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                color: Colors.black,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                   SizedBox(
                    height: 3.h,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Color.fromARGB(255, 206, 204, 204)),
                          ),
                          Text("Bilzen, Tanjungbalai",
                              style: TextStyle(color: Colors.white))
                        ],
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("images/propic.png"),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: SizedBox(
                        height: 60,
                        child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyclr,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.offwhite,
                                    size: 25,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        controller: searchController,
                                        decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Search coffee',
                                            hintStyle: TextStyle(
                                                color: AppColors.labeltxt)),
                                        onChanged: (value) {
                                          setState(() {
                                            searchKey = value;

                                            if (searchKey != "") {
                                              streamQuery = FirebaseFirestore
                                                  .instance
                                                  .collection("items")
                                                  .where('name',
                                                      isGreaterThanOrEqualTo:
                                                          searchKey.trim())
                                                  .where('name',
                                                      isLessThan:
                                                          searchKey.trim() +
                                                              'z')
                                                  .snapshots();
                                            } else {
                                              categoryFn(category);
                                            }
                                          });
                                        }),
                                  ),
                                ),
                              ],
                            )),
                      )),
                ])),
            Transform.translate(
                offset: const Offset(0, -90),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/sub_banner.png"),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(242, 228, 63, 63),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "Promo",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Buy one get \none FREE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Transform.translate(
              offset: const Offset(0, -65),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                height: 55,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: _scrollController,
                    itemCount: buttons.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 140,
                       margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: ButtonsCategory(buttons[index], 14),
                      );
                    }),
              ),
            ),
            Transform.translate(
                offset: const Offset(0, -60),
                child: MenuListScreen(
                  streamQery: streamQuery,
                )),
          ]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.catbtnbg,
            unselectedItemColor: AppColors.bttmclr,
            onTap: (value) {},
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset('images/Home.png',
                          width: 25, height: 25, color: AppColors.catbtnbg)),
                  label: '-'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        'images/heart.png',
                        width: 25,
                        height: 25,
                        color: AppColors.bttmclr,
                      )),
                  label: '-'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        'images/bag.png',
                        width: 25,
                        height: 25,
                        color: AppColors.bttmclr,
                      )),
                  label: '-'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Image.asset(
                        'images/bell.png',
                        width: 25,
                        height: 25,
                        color: AppColors.bttmclr,
                      )),
                  label: '-')
            ]),
      ),
    );
  }

  ElevatedButton ButtonsCategory(String txt, double font) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: txxt == txt || buttons[currentposition] == txt
              ? AppColors.catbtnbg
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0
        ),
        onPressed: () {
          setState(() {
            txxt = "";
            category = txt;
            currentposition = buttons.indexOf(txt);
            print("clicked category $category");
            print("position of $currentposition");

            categoryFn(category);
          });

          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              140.0 * currentposition,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 300),
            );
          }
        },
        child: Text(txt,
            style: TextStyle(
                color: txxt == txt || buttons[currentposition] == txt
                    ? Colors.white
                    : AppColors.greytxt,
                fontSize: font)));
  }
}

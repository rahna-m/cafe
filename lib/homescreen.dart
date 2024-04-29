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
  List locationlist = ["Bilzen, Tanjungbalai", "Bandung, Indonesia"];
  String locationvalue = "";

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
    locationvalue = locationlist[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                color: Colors.black,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 206, 204, 204)),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isDense: true,
                              icon: Image.asset(
                                "images/dropdownarrow.png",
                                color: Colors.white,
                                width: 20,
                                height: 20,
                              ),
                              items: locationlist.map((e) {
                                return DropdownMenuItem(
                                  value: e.toString(),
                                  child: Text(e.toString()),
                                );
                              }).toList(),
                              value: locationvalue,
                              style: const TextStyle(
                                  color: AppColors.whitetext,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              onChanged: (value) {
                                setState(() {
                                  locationvalue = value.toString();
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Container(
                          height: 44.0,
                          width: 44.0,
                          color: Colors.white,
                          child: const Image(
                            image: AssetImage("images/propic.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: SizedBox(
                        height: 52,
                        width: 315,
                        child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyclr,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "images/searchicon.png",
                                        color: Colors.white,
                                      ),
                                    )),
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
                                                color: AppColors.labeltxt,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
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
                          width: 60,
                          height: 26,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(242, 228, 63, 63),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Center(
                              child: Text(
                                "Promo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Buy one get \none FREE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Transform.translate(
              offset: const Offset(0, -70),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                height: 55,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: _scrollController,
                    itemCount: buttons.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        child: ButtonsCategory(buttons[index]),
                      );
                    }),
              ),
            ),
            Transform.translate(
                offset: const Offset(0, -65),
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
                      child: Column(
                        children: [
                        const  SizedBox(height: 5,),
                          Image.asset('images/Home.png',
                              width: 25, height: 25, color: AppColors.catbtnbg),

                              Image.asset('images/Bg.png',
                              width: 10, height: 15, color: AppColors.catbtnbg),

                        ],
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: [
                          const  SizedBox(height: 5,),
                          Image.asset(
                            'images/Heart.png',
                            width: 25,
                            height: 25,
                            color: AppColors.bttmclr,
                          ),

                            Image.asset('images/Bg.png',
                              width: 10, height: 15, color: Colors.white),
                        ],
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: [
                           const SizedBox(height: 5,),
                          Image.asset(
                            'images/Bag.png',
                            width: 25,
                            height: 25,
                            color: AppColors.bttmclr,
                          ),

                            Image.asset('images/Bg.png',
                              width: 10, height: 15, color: Colors.white),
                        ],
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        children: [
                          const  SizedBox(height: 5,),
                          Image.asset(
                            'images/Notification.png',
                            width: 25,
                            height: 25,
                            color: AppColors.bttmclr,
                          ),

                            Image.asset('images/Bg.png',
                              width: 10, height: 15, color: Colors.white),
                        ],
                      )),
                  label: '')
            ]),
      ),
    );
  }

  ElevatedButton ButtonsCategory(String txt) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: txxt == txt || buttons[currentposition] == txt
              ? AppColors.catbtnbg
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          minimumSize: const Size(69, 38),
          maximumSize: const Size(121, 38),
          padding: const EdgeInsets.only(left: 18, right: 18),
          elevation: 0,
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
              130.0 * currentposition,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 300),
            );
          }
        },
        child: Text(txt == "Cappucino" ? "Cappuccino" : txt,
            style: TextStyle(
                color: txxt == txt || buttons[currentposition] == txt
                    ? Colors.white
                    : AppColors.greytxt,
                fontSize: 14,
                fontWeight: FontWeight.w600)));
  }
}

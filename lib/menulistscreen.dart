import 'package:figma/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MenuListScreen extends StatefulWidget {
  final Stream streamQery;
  const MenuListScreen({super.key, required this.streamQery});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  List products = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
            height: 35.h,
          margin: const EdgeInsets.only(top: 5),
          child: StreamBuilder(
              stream: widget.streamQery,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var docs = snapshot.data.docs;
      
                  return GridView.builder(
                      shrinkWrap: true,
                      // scrollDirection: Axis.vertical,
                      // primary: true,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      itemCount: docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0,
                        mainAxisExtent: 235,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 0.1,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 15.5.h,
                                    padding: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            docs[index]
                                                .data()!["imgadrss"]
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15))),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "images/Vector.png",
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text(
                                          docs[index].data()!["rating"].toString(),
                                          style:
                                              const TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          docs[index].data()!["name"].toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          docs[index]
                                              .data()!["description"]
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '\$ ${docs[index].data()!["price"].toString()}',
                                          style: const TextStyle(
                                              color: AppColors.pricetext,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            color: AppColors.catbtnbg,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                              child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          )),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator(color: AppColors.catbtnbg,));
                }
              })),
    );
  }
}

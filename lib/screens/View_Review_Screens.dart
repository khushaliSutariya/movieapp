import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../helpers/DatabaseHandlers.dart';

class ViewReviewScreens extends StatefulWidget {
  const ViewReviewScreens({Key? key}) : super(key: key);

  @override
  State<ViewReviewScreens> createState() => _ViewReviewScreensState();
}

class _ViewReviewScreensState extends State<ViewReviewScreens> {
  late Future<List> allreviewdata;
  Future<List> getdata() async {
    DatabaseHandler obj = DatabaseHandler();
    var alldata = await obj.viewreview();
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      allreviewdata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: allreviewdata,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var myrate =  snapshot.data![index]["addrating"];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red.shade200,
                      ),
                      child: Card(
                        elevation: 10.0,
                        color: Colors.yellow.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: myrate,
                                minRating: 1,
                                ignoreGestures: true,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,

                                ),
                                onRatingUpdate: (rating) {
                                  print("dcxvvvvvvvvv");

                                },
                              ),
                              Text(
                                snapshot.data![index]["addtitle"],
                                style: const TextStyle(
                                    fontSize: 20.0, fontFamily: "Oswald"),
                              ),
                              Text(
                                snapshot.data![index]["addreview"],
                                style: const TextStyle(
                                    fontSize: 17.0, fontFamily: "Roboto"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

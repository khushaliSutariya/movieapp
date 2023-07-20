import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/screens/Homepage.dart';

import '../helpers/DatabaseHandlers.dart';
import 'View_Review_Screens.dart';

class AddReviewScreens extends StatefulWidget {
  const AddReviewScreens({Key? key}) : super(key: key);

  @override
  State<AddReviewScreens> createState() => _AddReviewScreensState();
}

class _AddReviewScreensState extends State<AddReviewScreens> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();
  double rating = 0;
  var formKey = GlobalKey<FormState>();
  String title = "";
  changeText() {

    setState(() {
      title = 'New Sample Text...';
    });

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Your Review's",
                  style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0,),
                const Text("How would you rate it?",style: TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.w600,fontFamily: "Oswald"
                )),
                const SizedBox(height: 15.0,),
                RatingBar.builder(

                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 25,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (ratingValue) {
                    print("dcxvvvvvvvvv");
                    setState(() {
                      rating = ratingValue;
                    });
                  },
                ),
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: (rating<=0)?Text(title):SizedBox()),
                const SizedBox(height: 20.0,),
                const Text("Title your review",style: TextStyle(
                    fontSize: 20.0,fontWeight: FontWeight.w600,fontFamily: "Oswald"
                )),
                const SizedBox(height: 10.0,),
                TextFormField(
                  validator: (value) {
                    {
                      if(value!.isEmpty)
                      {
                        return "Please enter title";
                      }
                      else
                      {
                        bool validtitle = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
                            .hasMatch(value);
                        if(validtitle)
                        {
                          return "A title is required";
                        }
                      }
                      return null;
                    }
                  },
                  cursorColor: Colors.black,
                  controller: _titleController,
                  onFieldSubmitted: (value) async {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "What's most important to know?",
                    fillColor: Colors.grey,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0,),
                const Text("Write your review",style: TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.w600,fontFamily: "Oswald"
                )),
                const SizedBox(height: 10.0,),
                TextFormField(
                  validator: (value) {
                    {
                      if(value!.isEmpty)
                      {
                        return "Please enter review";
                      }
                      else
                      {
                        bool validtitle = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
                            .hasMatch(value);
                        if(validtitle)
                        {
                          return "Please writtien review";
                        }
                      }
                      return null;
                    }
                  },
                  cursorColor: Colors.black,
                  controller: _reviewController,
                  maxLines: 5,
                  onFieldSubmitted: (value) async {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Write yor review",
                    fillColor: Colors.grey,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: size.height * 0.1,
            width: size.width * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xff0F0D3C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async{
                      if(formKey.currentState!.validate()){
                        setState(() async{
                          var addtitle = _titleController.text.toString();
                          var addreview = _reviewController.text.toString();
                          var addrating = rating;
                          // title = "Choose a rating to continue";
                          changeText();

                          DatabaseHandler obj = DatabaseHandler();
                          var rid = await obj.insertreview(addtitle,addreview,addrating);
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ViewReviewScreens(),));
                        });
                      }



                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: const Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ));
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/models/categories_news_model.dart';
import 'package:my_news_app/view_model/news_view_model.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModelApi=NewsViewModel();
  final format=DateFormat('MMMM dd, yyyy');
  String categoryName='General';
  List<String> categoriesNameList=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width*1;
    final height=MediaQuery.sizeOf(context).height*1;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemCount: categoriesNameList.length,
                  itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    categoryName=categoriesNameList[index];
                    setState(() {

                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: categoryName == categoriesNameList[index]?Colors.blue.shade200:Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(categoriesNameList[index].toString(),
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16
                        ),),
                      ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: height*.02,),
            Expanded(

              child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModelApi.fetchCategoriesNewsApi(context, categoryName),
                  builder: (BuildContext context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const SpinKitCircle(
                        color: Colors.black,
                        size: 50,
                      );
                    }else{
                      return ListView.builder(

                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      height:height*.22,
                                      width:width*.35,
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context,url)=>Container(child: spinKit2,),
                                      errorWidget: (context,url,error)=>(const Icon(Icons.error_outline
                                        ,color: Colors.red,)),
                                    ),
                                  ),
                                  Expanded(child: Container(height: height*.2,
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),
                                        maxLines: 3,
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700

                                        ),),

                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString(),
                                            style: GoogleFonts.aBeeZee(
                                              fontSize: 14,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w700,
                                            ),


                                            ),
                                            Text(format.format(dateTime),
                                              style: GoogleFonts.aBeeZee(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),


                                            ),
                                          ],
                                        )
                                      ],
                                    ),


                                  )),
                                ],
                              ),
                            );
                          }
                      );
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 40,
);

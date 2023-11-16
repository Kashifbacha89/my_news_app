import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailsScreen extends StatefulWidget {
  String? id,newsName,title, urlToImage, author, publishedAt, description, content;
  ArticleDetailsScreen(
      {super.key,
        this.id,
        this.newsName,
        this.title,
        this.urlToImage,
        this.author,
        this.publishedAt,
        this.description,
        this.content,
      });

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  final format =  DateFormat('MMMM dd,yyyy');
  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    //DateTime dateTime = DateTime.parse(widget.publishedAt!);

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[600],
            )),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: Kheight * 0.02),
              height: Kheight * 0.45,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: "${widget.urlToImage}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>const  CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>  const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration:const  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text('${widget.newsName}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.title}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Text(
                      widget.publishedAt!,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: Kheight * 0.05,
                ),
                Text('Author:  ${widget.author}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),

                SizedBox(
                  height: Kheight * 0.05,
                ),
                Text('${widget.description}',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text(widget.content.toString(),
                    maxLines: 100,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
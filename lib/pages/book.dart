import 'package:flutter/material.dart';

import '../models/book.dart';

class BookPage extends StatelessWidget {
  final Book book;

  BookPage(this.book);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("${book.title}"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              "Book Title: ${book.title}",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Authors: ${book.author.toString()}",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Image.network("${book.images.smallThumbnail}"),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Book Description: ${book.description}",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${book.pageCount} pages",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Categories: ${book.categories.toString()}",
              style: TextStyle(fontSize: 16.0),
            ),
          ].toList(),
        )));
  }
}

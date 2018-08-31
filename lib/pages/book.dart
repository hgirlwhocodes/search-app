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
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Title: ${book.title}"),
              Text("Authors: ${book.author[0]}"),
              Image.network("${book.images.smallThumbnail}"),
              Text("Book Description: ${book.description}"),
              Text("${book.pageCount} pages"),
              Text("Categories: ${book.categories.toString()}"),

            ],
          ) 
        ),
      ); 
    }
}

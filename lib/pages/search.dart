import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';
import './book.dart';

Future<List<Book>> fetchBooks(http.Client client) async {
  final response = await client
      .get("https://desolate-depths-93559.herokuapp.com/api/bookInfo?q=bible");
  if (response.statusCode == 200) {
    print(response.body);
    return compute(parseBooks, response.body);
  } else {
    throw Exception('Failed to fetch books.');
  }
}

List<Book> parseBooks(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Book>((json) => Book.fromJson(json)).toList();
}

class SearchPage extends StatefulWidget {
  final String inputQuery;

  SearchPage(this.inputQuery);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final String title = 'Search Results';

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                // setState(() {
                                //   widget.inputQuery = value;
                                // });
                              },
                              decoration: InputDecoration(
                                labelText: widget.inputQuery,
                                  helperText: "Search for a book by title"),
                            ),
                          ),
                          IconButton(
                              tooltip: 'Search for a specific book',
                              icon: Icon(Icons.search),
                              onPressed: () {}),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      )
                    ])),
            Expanded(
              child: FutureBuilder<List<Book>>(
                future: fetchBooks(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? BooksList(books: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ));
  }
}

// https://stackoverflow.com/questions/48081917/flutter-listview-not-scrollable-not-bouncing

class BooksList extends StatelessWidget {
  final List<Book> books;

  BooksList({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
     // itemExtent: 152.0,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Card(
            child: ListTile(
              leading: Image.network(books[index].images.smallThumbnail),
              title: Text(books[index].title),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookPage(books[index]),
                ));
          },
        );
      },
    );
  }
}

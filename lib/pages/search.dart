import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';
import './book.dart';

Future<List<Book>> fetchBooks(http.Client client) async {
  final response = await client
      .get("https://desolate-depths-93559.herokuapp.com/api/bookInfo?q=${inputQuery}");
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
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String inputQuery = '';
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
                margin: EdgeInsets.all(30.0),
                padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  inputQuery = value.toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                  helperText: "Search for a book by title"),
                            ),
                          ),
                          IconButton(
                            tooltip: 'Search for a specific book',
                            icon: Icon(Icons.search),
                            onPressed: () {
                            }
                                
                          ),
                        ],
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

class BooksList extends StatelessWidget {
  final List<Book> books;

  BooksList({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(books);

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookPage(books[index]),
                ));
          },
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(books[index].title),
                // subtitle: Text(books[index].author.toString()),
              ),
              Image.network(books[index].images.smallThumbnail)
            ],
          ),
        );
      },
    );
  }
}

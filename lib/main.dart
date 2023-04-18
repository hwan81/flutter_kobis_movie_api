import 'package:flutter/material.dart';
import 'package:flutter_application_kobis_api/movie_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  var result = MovieApi();

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> movies = result.getMoives();
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: FutureBuilder(
          future: movies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var movieData = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    Map<dynamic, dynamic> movie = movieData[index];
                    return ListTile(
                      title: Text(movie['movieNm']),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: movieData!.length);
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}

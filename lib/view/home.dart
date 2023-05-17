import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imdb_api/controller/api_controller.dart';
import 'package:imdb_api/model/movie_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<Movie> movies = [];
  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'IMDb',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetch,
          child: movies.isEmpty
              ? const Center(
                  child: Text("empty"),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      if (movies.isEmpty) {
                        print("keri");
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  // color: Colors.amber,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(movie.image))),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Text(
                                  movie.rating,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                ElevatedButton.icon(
                                    onPressed: () async {
                                      final url = movie.trailer;
                                      final uri = Uri.parse(url);
                                      print('uri parsed');
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri,
                                            mode: LaunchMode.platformDefault);
                                        print('uri launch');
                                      } else {
                                        print('uri not launch');
                                      }
                                    },
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('Watch Trailer'))
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
        child: Center(
          child: LoadingAnimationWidget.twistingDots(
              leftDotColor: Colors.black,
              rightDotColor: Colors.amber,
              size: 50),
        ),
      ),
    );
  }

  Future<void> fetch() async {
    movies = await MovieAPI.fetchMovies();
    // if (response.isEmpty) {
    //   setState(() {
    //     isLoading = false;
    //   });

    //   return;
    // }
    print(movies);
    // setState(() {
    //   //movies = response;
    // });

    setState(() {
      isLoading = false;
    });
  }
}

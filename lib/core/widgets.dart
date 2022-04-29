import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_gain/models/movie_details.dart';
import 'package:movie_gain/models/popular_movies.dart';

const imageSrc = 'https://image.tmdb.org/t/p/original';
String? token = '';

Widget movieItem(Result movie) => SizedBox(
      height: 160.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(imageSrc + movie.posterPath),
              width: 110.0,
              height: 160.0,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 27,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(movie.releaseDate.year.toString(),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20)),
                    const SizedBox(width: 8),
                    if (!movie.adult)
                      const Text('PG-13',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    if (movie.adult)
                      const Text('R',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    const SizedBox(width: 2),
                    Text(movie.voteAverage.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey,
        height: 2,
      ),
    );

Widget buildBackdropCarousel(MovieDetails movieDetails) => CarouselSlider(
        items: [
          Image(
            image:
                NetworkImage(imageSrc + movieDetails.backdropPath.toString()),
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          if (movieDetails.belongsToCollection != null)
            Image(
              image: NetworkImage(imageSrc +
                  movieDetails.belongsToCollection!.backdropPath.toString()),
              width: double.infinity,
              fit: BoxFit.fill,
            )
        ],
        options: CarouselOptions(
          height: 250.0,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll:
              movieDetails.belongsToCollection != null ? true : false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));

Widget buildPosterCarousel(MovieDetails movieDetails) => CarouselSlider(
        items: [
          Image(
            image: NetworkImage(imageSrc + movieDetails.posterPath.toString()),
            fit: BoxFit.fill,
            width: 155,
            height: 250,
          ),
          if (movieDetails.belongsToCollection != null)
            Image(
              image: NetworkImage(imageSrc +
                  movieDetails.belongsToCollection!.posterPath.toString()),
              fit: BoxFit.fill,
              width: 155,
              height: 250,
            )
        ],
        options: CarouselOptions(
          initialPage: 0,
          viewportFraction: 1.0,
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
        ));

Widget buildGenres(Genres genres) => Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          genres.name!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );

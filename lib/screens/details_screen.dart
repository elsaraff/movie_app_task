import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gain/app_cubit/app_cubit.dart';
import 'package:movie_gain/app_cubit/app_states.dart';
import 'package:movie_gain/core/widgets.dart';

class DetailsScreen extends StatelessWidget {
  final String movieName;
  const DetailsScreen({Key? key, required this.movieName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movieName)),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          if (appCubit.movieDetails == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        appCubit.movieDetails!.originalTitle.toString(),
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Row(children: [
                        Text(
                          appCubit.movieDetails!.tagline!,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black54),
                        )
                      ]),
                      Row(
                        children: [
                          Text(
                            appCubit.movieDetails!.releaseDate.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 10),
                          if (!appCubit.movieDetails!.adult!)
                            const Text('PG-13',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          if (appCubit.movieDetails!.adult!)
                            const Text('R',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Text(
                            appCubit.movieDetails!.spokenLanguages!.first
                                .englishName
                                .toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 250.0,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      const Center(child: CircularProgressIndicator()),
                      buildBackdropCarousel(appCubit.movieDetails!),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 260.0,
                              width: 160.0,
                              color: Colors.black12,
                              child: Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  buildPosterCarousel(appCubit.movieDetails!),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                buildGenres(appCubit
                                                    .movieDetails!
                                                    .genres![index]),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 5),
                                            itemCount: appCubit
                                                .movieDetails!.genres!.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SelectableText(
                                    appCubit.movieDetails!.overview!,
                                    maxLines: 9,
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    appCubit.movieDetails!.voteAverage!
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.black54,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    appCubit.movieDetails!.status!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.attach_money_sharp,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    appCubit.movieDetails!.budget! == 0
                                        ? 'No data'
                                        : appCubit.movieDetails!.budget!
                                                .toString() +
                                            '\$',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

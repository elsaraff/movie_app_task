import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_gain/app_cubit/app_cubit.dart';
import 'package:movie_gain/app_cubit/app_states.dart';
import 'package:movie_gain/core/functions.dart';
import 'package:movie_gain/core/show_toast.dart';
import 'package:movie_gain/core/widgets.dart';
import 'package:movie_gain/screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies'), actions: [
        IconButton(
            tooltip: 'Subscribe FCM Topic',
            onPressed: () {
              FirebaseMessaging.instance
                  .subscribeToTopic('announcement')
                  .then((value) {
                showToast(text: 'Subscribed', state: ToastStates.success);
              });
            },
            icon: const Icon(Icons.unsubscribe_outlined))
      ]),
      body: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var appCubit = AppCubit.get(context);
          if (appCubit.popularMovies == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      appCubit.getMovieDetails(
                          movieId: appCubit.popularMovies!.results[index].id);
                      navigateTo(
                          context,
                          DetailsScreen(
                            movieName:
                                appCubit.popularMovies!.results[index].title,
                          ));
                    },
                    child: movieItem(appCubit.popularMovies!.results[index]),
                  ),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: appCubit.popularMovies!.results.length,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food/core/utils/color.dart';
import 'package:food/core/utils/function.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/details/presentation/bloc/bloc.dart';
import 'package:food/feature/food/details/presentation/bloc/food_detail_bloc.dart';
import 'package:food/feature/food/favorite/presentation/bloc/bloc.dart' as fav;
import 'package:food/feature/food/list/domain/entities/food.dart';

class FoodDetailPage extends StatefulWidget {
  final String? name;

  const FoodDetailPage({Key? key, this.name}) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodDetailBloc>(
      create: (_) => Modular.get<FoodDetailBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<FoodDetailBloc, FoodDetailState>(
            builder: (context, state) {
              if (state is Loaded) {
                return Text(state.detail.strMeal ?? '');
              } else {
                return const Text('Waiting data...');
              }
            },
          ),
        ),
        body: BlocBuilder<FoodDetailBloc, FoodDetailState>(
          builder: (context, state) {
            if (state is Empty) {
              return const Center(
                child: Text('Empty'),
              );
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is Loaded) {
              return _detailMealWidget(state.detail);
            } else if (state is Error) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              BlocProvider.of<FoodDetailBloc>(context)
                  .add(FetchDetailByMealId(Modular.args.data['id']));
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _detailMealWidget(Food item) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              FadeInImage.assetNetwork(
                placeholder: getSourceName('placeholder'),
                image: item.strMealThumb ?? '',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                imageErrorBuilder: (_, __, ___) => const Placeholder(
                  fallbackWidth: double.infinity,
                ),
              ),
              BlocProvider(
                create: (_) => Modular.get<fav.FoodFavoriteBloc>(),
                child:
                    BlocListener<fav.FoodFavoriteBloc, fav.FoodFavoriteState>(
                  listener: (context, state) {
                    if (state is fav.Success) {
                      Scaffold.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Success'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child:
                      BlocBuilder<fav.FoodFavoriteBloc, fav.FoodFavoriteState>(
                          builder: (context, state) {
                    if (state is fav.Loaded) {
                      bool hasItem = state.favorites
                          .any((element) => element.mealId == item.idMeal);
                      return Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: IconButton(
                            splashColor: red,
                            icon: FaIcon(
                                hasItem
                                    ? FontAwesomeIcons.trash
                                    : FontAwesomeIcons.solidHeart,
                                color: red),
                            onPressed: () => hasItem
                                ? BlocProvider.of<fav.FoodFavoriteBloc>(context)
                                    .add(
                                    fav.RemoveFavorite(item),
                                  )
                                : BlocProvider.of<fav.FoodFavoriteBloc>(context)
                                    .add(
                                    fav.AddFavorites(item),
                                  ),
                          ),
                        ),
                      );
                    } else if (state is fav.Success || state is fav.Initial) {
                      BlocProvider.of<fav.FoodFavoriteBloc>(context)
                          .add(fav.FetchFavorites());
                      return Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: IconButton(
                            splashColor: red,
                            icon: const FaIcon(FontAwesomeIcons.solidHeart,
                                color: red),
                            onPressed: () => null,
                          ),
                        ),
                      );
                    } else {
                      return Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: white, shape: BoxShape.circle),
                          child: IconButton(
                            splashColor: red,
                            icon: const FaIcon(FontAwesomeIcons.solidHeart,
                                color: red),
                            onPressed: () => null,
                          ),
                        ),
                      );
                    }
                  }),
                ),
              )
            ],
          ),
          Text(
            item.strMeal ?? '',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${item.strArea ?? ''} | ${item.strCategory ?? ''}'),
          ),
          Text(
            item.strInstructions ?? '',
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

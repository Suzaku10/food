import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food/core/utils/color.dart';
import 'package:food/core/utils/function.dart';
import 'package:food/feature/food/details/domain/usecases/fetch_meal_detail.dart';
import 'package:food/feature/food/details/presentation/bloc/bloc.dart';
import 'package:food/feature/food/details/presentation/bloc/food_detail_bloc.dart';
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
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  decoration:
                      const BoxDecoration(color: white, shape: BoxShape.circle),
                  child: IconButton(
                      splashColor: red,
                      icon:
                          const FaIcon(FontAwesomeIcons.solidHeart, color: red),
                      onPressed: () {
                        print("Pressed");
                      }),
                ),
              ),
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

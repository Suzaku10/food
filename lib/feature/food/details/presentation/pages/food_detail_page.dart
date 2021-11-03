import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
          title: Text(Modular.args.data['id']),
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
      child: Column(
        children: [
          Image.network(
            item.strMealThumb ?? '',
            width: double.infinity,
            fit: BoxFit.fitWidth,
            errorBuilder: (_, __, ___) => const Placeholder(
              fallbackWidth: double.infinity,
            ),
          ),
          Text(
            item.strMeal ?? '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('${item.strArea ?? ''} | ${item.strCategory ?? ''}'),
          Text(item.strInstructions ?? '')
        ],
      ),
    );
  }
}

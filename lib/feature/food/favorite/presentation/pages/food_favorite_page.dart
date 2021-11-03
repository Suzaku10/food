import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/core/utils/color.dart';
import 'package:food/core/utils/moor_helper/moor_helper.dart';
import 'package:food/feature/food/favorite/presentation/bloc/bloc.dart';

class FoodFavoritePage extends StatelessWidget {
  const FoodFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Meals'),
      ),
      body: _body(context),
    );
  }

  BlocProvider<FoodFavoriteBloc> _body(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<FoodFavoriteBloc>(),
      child: BlocBuilder<FoodFavoriteBloc, FoodFavoriteState>(
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
            return _mealsWidget(state.favorites, context);
          } else if (state is Error) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            BlocProvider.of<FoodFavoriteBloc>(context).add(FetchFavorites());
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  Widget _mealsWidget(List<Favorite> meals, BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      itemBuilder: (_, index) => _itemMealWidget(meals[index], context),
      separatorBuilder: (_, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Divider(color: black),
      ),
    );
  }

  Widget _itemMealWidget(Favorite item, BuildContext context) {
    return InkWell(
      onTap: () => Modular.to
          .pushNamed('/detail/', arguments: {'id': item.mealId}).then((value) =>
              BlocProvider.of<FoodFavoriteBloc>(context).add(FetchFavorites())),
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: red,
                  blurRadius: 2,
                  spreadRadius: 2)
            ]),
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.mealName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('${item.mealArea} | ${item.mealCategory}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

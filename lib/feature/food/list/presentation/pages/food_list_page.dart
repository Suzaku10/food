import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/core/utils/color.dart';
import 'package:food/feature/food/list/domain/entities/food.dart';
import 'package:food/feature/food/list/presentation/bloc/bloc.dart';
import 'package:food/feature/food/list/presentation/bloc/food_list_bloc.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: _body(context),
    );
  }

  BlocProvider<FoodListBloc> _body(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<FoodListBloc>(),
      child: BlocBuilder<FoodListBloc, FoodListState>(
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
            return _mealsWidget(state.meals);
          } else if (state is Error) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            BlocProvider.of<FoodListBloc>(context).add(FetchMeals());
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  Widget _mealsWidget(List<Food> meals) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: meals.length,
      itemBuilder: (_, index) => _itemMealWidget(meals[index]),
      separatorBuilder: (_, index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Divider(color: black),
      ),
    );
  }

  Widget _itemMealWidget(Food item) {
    return Container(
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
                    item.strMeal ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('${item.strArea ?? ''} | ${item.strCategory ?? ''}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            child: ClipOval(
              child: Image.network(
                '${(item.strMealThumb ?? '')}/preview',
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

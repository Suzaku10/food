import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        title: const Text('Meals'),
        actions: [
          IconButton(
              onPressed: () => Modular.to.pushNamed('/favorites'),
              icon: const FaIcon(FontAwesomeIcons.heart)),
        ],
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
    return InkWell(
      onTap: () =>
          Modular.to.pushNamed('/detail/', arguments: {'id': item.idMeal}),
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
                      item.strMeal ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('${item.strArea ?? ''} | ${item.strCategory ?? ''}'),
                  ],
                ),
              ),
            ),
            if (item.strMealThumb != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: ClipOval(
                  child: Image.network(
                    '${(item.strMealThumb ?? '')}/preview',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    errorBuilder: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: black),
                          color: white,
                          shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: const Text(
                        'No Image Found',
                        textAlign: TextAlign.center,
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

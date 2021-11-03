import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:food/core/utils/color.dart';
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
      backgroundColor: red,
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
            return Center(
              child: Text('Ada Data ${state.meals.length}'),
            );
          } else if (state is Error) {
            return const Center(
              child: Text('error'),
            );
          } else {
            BlocProvider.of<FoodListBloc>(context).add(FetchMeals());
            return const Center(
              child: Text('apa ini'),
            );
          }
        },
      ),
    );
  }
}

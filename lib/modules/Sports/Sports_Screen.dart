import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/Cubit/NewsCubit.dart';
import 'package:news_app/layouts/Cubit/States.dart';
import 'package:news_app/shared/component/Components.dart';



class SportsScreen extends StatelessWidget {
  const SportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticlesItem(list[index],context),
              separatorBuilder: (context, index) => MyDivider(),
              itemCount: list.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

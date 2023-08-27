import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/Cubit/NewsCubit.dart';
import 'package:news_app/layouts/Cubit/States.dart';
import 'package:news_app/modules/Search/Search_Screen.dart';
import 'package:news_app/shared/Cubit/Cubit.dart';
import 'package:news_app/shared/component/Components.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    NavigateTo(context, SearchScreen(),);
                  },
                  icon: const Icon(Icons.search)
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).ChangeAppMode();
                    },
                    icon: const Icon(Icons.brightness_4_outlined)
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.ChangeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}

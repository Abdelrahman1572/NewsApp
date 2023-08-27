import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/Cubit/States.dart';
import 'package:news_app/modules/Business/Business_Screen.dart';
import 'package:news_app/modules/Science/Science_Screen.dart';
import 'package:news_app/modules/Sports/Sports_Screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business),
        label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.settings),
    //   label: 'Setting',
    // ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    // SettingScreen(),
  ];

  void ChangeBottomNavBar(index){
     currentIndex = index;
     if (index == 1) {
       getSports();
     }
     if (index ==2) {
       getScience();
     }
     emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country':'eg',
      'category':'business',
      'apiKey':'12e8cc2548a94339a9ed3f753b14de5f',
    }).then((value) {
      emit(NewsGetBusinessSuccessState());
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
    }).catchError((error){
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];

  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'12e8cc2548a94339a9ed3f753b14de5f',
      }).then((value) {
        emit(NewsGetSportsSuccessState());
        //print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
      }).catchError((error){
        emit(NewsGetSportsErrorState(error.toString()));
        print(error.toString());
      });
    }
    else {
      emit(NewsGetSportsSuccessState());
    }
    }


  List<dynamic> science = [];

  void getScience(){
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty){
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country':'eg',
        'category':'science',
        'apiKey':'12e8cc2548a94339a9ed3f753b14de5f',
      }).then((value) {
        emit(NewsGetScienceSuccessState());
        //print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);
      }).catchError((error){
        emit(NewsGetScienceErrorState(error.toString()));
        print(error.toString());
      });
    }
  else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value){
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q':'$value',
      'apiKey':'12e8cc2548a94339a9ed3f753b14de5f',
    }).then((value) {
      emit(NewsGetSearchSuccessState());
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }

}

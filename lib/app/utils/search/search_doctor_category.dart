import 'package:flutter/material.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';

class SearchDoctorCategory extends SearchDelegate<DoctorCategory> {
  late List<DoctorCategory> doctorCategory;
  late List<DoctorCategory> doctorCategorySugestion;
  SearchDoctorCategory({
    required this.doctorCategory,
    required this.doctorCategorySugestion,
  });

  //Action button, right button
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  //Back Button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, query);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    var allDoctorCategory = doctorCategory
        .where(
          (category) => category.categoryName!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: allDoctorCategory.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allDoctorCategory[index].categoryName!),
        onTap: () {
          close(context, allDoctorCategory[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var allDoctorCategorySuggestion = doctorCategorySugestion
        .where(
          (categorySuggestion) =>
              categorySuggestion.categoryName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
        )
        .toList();

    return ListView.builder(
      itemCount: allDoctorCategorySuggestion.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allDoctorCategorySuggestion[index].categoryName!),
        onTap: () {
          close(context, allDoctorCategorySuggestion[index]);
        },
      ),
    );
  }
}

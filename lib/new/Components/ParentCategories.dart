import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakosh/main.dart';
import 'package:shakosh/new/Bloc/Categories/categories_bloc.dart';
import 'package:shakosh/new/Components/CategoriesShimmer.dart';
import 'package:shakosh/new/Components/CategoryCard.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Config/Utils/SizeConfig.dart';
import 'package:shakosh/new/Data/Models/CategoreyModel.dart';
import 'package:shakosh/new/Screens/Categories/CategoriesScreen.dart';

// ignore: must_be_immutable
class ParentCategories extends StatefulWidget {
  ParentCategories({super.key, this.parentId});

  String? parentId;

  @override
  State<ParentCategories> createState() => _ParentCategoriesState();
}

class _ParentCategoriesState extends State<ParentCategories> {
  ScrollController scrollController = ScrollController();
  double listanimate = 0;
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
            Text(
              "categories".tr,
              style: TextStyle(
                  fontSize: mySize(14, 14, 19, 19, 19),
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                expand = !expand;
                setState(() {});
              },
              child: Row(
                children: [
                  Text(
                    "see-more".tr,
                    style: TextStyle(
                        fontSize: mySize(14, 14, 19, 19, 19),
                        fontWeight: FontWeight.bold,
                        height: 1),
                  ),
                  Icon(expand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down)
                ],
              ),
            ),
            SizedBox(
              width: mySize(10, 10, 20, 20, 20),
            ),
          ],
        ),
        SizedBox(
          height: mySize(10, 10, 20, 20, 20),
        ),
        Row(
          children: [
            if (!expand && screenWidth > 768) rightScroll(context),
            Expanded(
              child: BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return categoriesShimmer();
                  } else if (state is CategoriesLoaded) {
                    List<CategoreyModel> categories = state.parentCategories;
                    return catgeoriesWidget(categories);
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Something Happened!")],
                    );
                  }
                },
              ),
            ),
            if (!expand && screenWidth > 768) leftScroll(context),
          ],
        ),
      ],
    );
  }

  SizedBox categoriesShimmer() {
    return SizedBox(
        height: 150,
        child: ListView.builder(
            controller: scrollController,
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoriesShimmer();
            }));
  }

  Widget catgeoriesWidget(List<CategoreyModel> categories) {
    if (expand) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mySize(0, 0, 10, 10, 10)!,
        ),
        child: Wrap(
          spacing: mySize(0, 0, 10, 10, 10)!,
          runSpacing: 10,
          children: [
            for (CategoreyModel category in categories)
              SizedBox(
                  height: mySize(125, 125, 150, 150, 150),
                  child: InkWell(
                    onTap: () {
                      if (widget.parentId == null) {
                        BlocProvider.of<CategoriesBloc>(context)
                            .add(SelectCategoryEvent(selectedId: category.id));
                        Navigator.of(context)
                            .pushNamed(CategoriesScreen.routeName);
                      } else {
                        widget.parentId = category.id;
                        BlocProvider.of<CategoriesBloc>(context).add(
                            SelectCategoryEvent(selectedId: widget.parentId!));
                      }
                    },
                    child: CategoryCard(
                      expand: expand,
                      category: category,
                      parentId: widget.parentId,
                    ),
                  ))
          ],
        ),
      );
    } else
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          height: mySize(100, 100, 150, 150, 150),
          child: ListView.builder(
            itemCount: categories.length <= 10 ? categories.length : 10,
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              CategoreyModel category = categories[i];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    if (widget.parentId == null) {
                      BlocProvider.of<CategoriesBloc>(context)
                          .add(SelectCategoryEvent(selectedId: category.id));
                      Navigator.of(context)
                          .pushNamed(CategoriesScreen.routeName);
                    } else {
                      widget.parentId = category.id;
                      BlocProvider.of<CategoriesBloc>(context).add(
                          SelectCategoryEvent(selectedId: widget.parentId!));
                    }
                  },
                  child: CategoryCard(
                    expand: expand,
                    category: category,
                    parentId: widget.parentId,
                  ),
                ),
              );
            },
          ),
        ),
      );
  }

  SizedBox leftScroll(BuildContext context) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () {
          if (scrollController.position.pixels <
              scrollController.position.maxScrollExtent) {
            listanimate += screenWidth * 0.9;
          } else {
            listanimate = scrollController.position.maxScrollExtent;
          }
          scrollController.animateTo(listanimate,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(end: 10),
          child: Icon(
            Icons.arrow_forward_ios,
            color: colors(context).kprimaryColor,
          ),
        ),
      ),
    );
  }

  SizedBox rightScroll(BuildContext context) {
    return SizedBox(
      height: 150,
      child: InkWell(
        onTap: () {
          if (scrollController.position.pixels >
              scrollController.position.minScrollExtent) {
            listanimate -= screenWidth * 0.9;
          } else {
            listanimate = scrollController.position.minScrollExtent;
          }
          scrollController.animateTo(listanimate,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Icon(
            Icons.arrow_back_ios,
            color: colors(context).kprimaryColor,
          ),
        ),
      ),
    );
  }
}
import 'package:fitness_app_admin/components/loading.dart';
import 'package:fitness_app_admin/repository/foods/models/food_response/food_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'select_food_bloc.dart';
import 'select_food_state.dart';
import 'update_nutrition/update_nutrition_screen.dart';

class SelectFoodScreen extends StatefulWidget {
  const SelectFoodScreen({super.key});

  @override
  State<SelectFoodScreen> createState() => _SelectFoodScreenState();
}

class _SelectFoodScreenState extends State<SelectFoodScreen> {
  late SelectFoodBloc bloc;

  final PagingController<int, FoodResponse> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 3);

  @override
  void initState() {
    super.initState();
    bloc = SelectFoodBloc()..onFetch(page: 1);
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey != 1) {
        bloc.onFetch(page: pageKey);
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectFoodBloc, SelectFoodState>(
            listenWhen: (previous, current) =>
                previous.dataList != current.dataList,
            listener: (context, state) {
              if (state.currentPage == 1) {
                _pagingController.refresh();
              }
              if (state.canLoadMore) {
                _pagingController.appendPage(
                  state.dataList ?? [],
                  state.currentPage + 1,
                );
              } else {
                _pagingController.appendLastPage(state.dataList ?? []);
              }
            },
          ),
        ],
        child: BlocBuilder<SelectFoodBloc, SelectFoodState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Select Food'),
              ),
              body: state.dataList == null
                  ? const Loading()
                  : PagedListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      pagingController: _pagingController,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        top: 16,
                        bottom: 72,
                      ),
                      physics: const ClampingScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<FoodResponse>(
                        noItemsFoundIndicatorBuilder: _empty,
                        itemBuilder: (context, item, index) {
                          return _item(
                            context,
                            item,
                            index,
                          );
                        },
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return const Empty();
  }

  Widget _item(
    BuildContext context,
    FoodResponse data,
    int index,
  ) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return UpdateNutritionScreen(
                id: data.id ?? '',
                name: data.name ?? '',
              );
            },
          ),
        );
      },
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(data.name ?? ''),
        subtitle: Text('${data.name} calories per ${data.unit}'),
      ),
    );
  }
}

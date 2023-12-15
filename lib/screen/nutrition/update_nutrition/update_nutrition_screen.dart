import 'package:fitness_app_admin/api/services/nutritions/models/update_nutrition/update_nutrition_request.dart';
import 'package:fitness_app_admin/components/button/bottom_bar_button.dart';
import 'package:fitness_app_admin/components/button/solid_button.dart';
import 'package:fitness_app_admin/components/input/form_input.dart';
import 'package:fitness_app_admin/components/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_nutrition_bloc.dart';
import 'update_nutrition_state.dart';

class UpdateNutritionScreen extends StatefulWidget {
  const UpdateNutritionScreen({
    super.key,
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  State<UpdateNutritionScreen> createState() => _UpdateNutritionScreenState();
}

class _UpdateNutritionScreenState extends State<UpdateNutritionScreen> {
  late UpdateNutritionBloc bloc;
  final ScrollController _controller = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bloc = UpdateNutritionBloc()..getData(widget.id);
  }

  void _scrollTop() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<UpdateNutritionBloc, UpdateNutritionState>(
            listenWhen: (previous, current) =>
                previous.isUpdateSuccess != current.isUpdateSuccess &&
                current.isUpdateSuccess == true,
            listener: (context, state) {
              _scrollTop();
              FocusManager.instance.primaryFocus?.unfocus();
              const snackBar = SnackBar(content: Text('Update Success'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ],
        child: BlocBuilder<UpdateNutritionBloc, UpdateNutritionState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Update ${widget.name}'),
              ),
              bottomNavigationBar: state.isLoading
                  ? null
                  : BottomBarButton(
                      button1: SizedBox(
                        child: AppSolidButton.medium(
                          'Submit',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              bloc.onSubmit();
                            } else {
                              print('Error');
                            }
                          },
                        ),
                      ),
                    ),
              body: state.data == null
                  ? const Loading()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: SingleChildScrollView(
                        controller: _controller,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              FormInput(
                                title: 'Calories',
                                initialText: state.data?.calories.toString(),
                                readOnly: true,
                                onChanged: (value) {},
                              ),
                              FormInput(
                                title: 'Protein',
                                initialText: state.data?.protein.toString(),
                                type: 1,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      protein: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'TotalFat',
                                initialText: state.data?.totalFat.toString(),
                                type: 1,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      totalFat: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Cholesterol',
                                initialText: state.data?.cholesterol.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      cholesterol: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Carbohydrate',
                                initialText:
                                    state.data?.carbohydrate.toString(),
                                type: 1,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      carbohydrate: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Sugars',
                                initialText: state.data?.sugars.toString(),
                                type: 1,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      sugars: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'DietaryFiber',
                                initialText:
                                    state.data?.dietaryFiber.toString(),
                                type: 1,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      dietaryFiber: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminA',
                                initialText: state.data?.vitaminA.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminA: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminB1',
                                initialText: state.data?.vitaminB1.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminB1: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminB2',
                                initialText: state.data?.vitaminB2.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminB2: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminB6',
                                initialText: state.data?.vitaminB6.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminB6: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminB9',
                                initialText: state.data?.vitaminB9.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminB9: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminB12',
                                initialText: state.data?.vitaminB12.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminB12: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminC',
                                initialText: state.data?.vitaminC.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminC: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminD',
                                initialText: state.data?.vitaminD.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminD: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminE',
                                initialText: state.data?.vitaminE.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminE: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'VitaminK',
                                initialText: state.data?.vitaminK.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      vitaminK: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Canxi',
                                initialText: state.data?.canxi.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      canxi: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Phospho',
                                initialText: state.data?.phospho.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      phospho: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Fe',
                                initialText: state.data?.fe.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      fe: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Magie',
                                initialText: state.data?.magie.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      magie: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Zn',
                                initialText: state.data?.zn.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      zn: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Natri',
                                initialText: state.data?.natri.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      natri: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Iod',
                                initialText: state.data?.iod.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      iod: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Omega3',
                                initialText: state.data?.omega3.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      omega3: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Omega6',
                                initialText: state.data?.omega6.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      omega6: num.tryParse(value)));
                                },
                              ),
                              FormInput(
                                title: 'Omega9',
                                initialText: state.data?.omega9.toString(),
                                type: 2,
                                onChanged: (value) {
                                  bloc.onChangeData(UpdateNutritionRequest(
                                      omega9: num.tryParse(value)));
                                },
                              ),
                              const SizedBox(height: 72)
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

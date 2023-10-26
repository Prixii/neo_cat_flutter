import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/saver/state.dart';

import '../../bloc/saver/cubit.dart';
import '../../components/saver/path_setter.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SaverCubit(),
      child: BlocBuilder<SaverCubit, SaverState>(
        builder: (context, state) => const PathSetter(),
      ),
    );
  }
}

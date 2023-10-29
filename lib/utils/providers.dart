import 'package:doggy/view_model/home/breed_view_model.dart';
import 'package:doggy/view_model/home/sub_breed_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => BreedViewModel()),
  ChangeNotifierProvider(create: (_) => SubBreedViewModel()),
];

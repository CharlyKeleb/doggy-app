import 'package:doggy/view_model/home/home_view_model.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => HomeViewModel()),
];

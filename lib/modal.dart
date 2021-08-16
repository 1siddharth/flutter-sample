import 'package:hive/hive.dart';

part 'modal.g.dart';

@HiveType(typeId: 0)
class Transection extends HiveObject {
  @HiveField(0)
  String movie;

  @HiveField(1)
  String director;
}

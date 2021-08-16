import 'package:hive/hive.dart';
import 'modal.dart';

class Boxes {
  static Box<Transection> getTransactions() =>
      Hive.box<Transection>('transactions');
}

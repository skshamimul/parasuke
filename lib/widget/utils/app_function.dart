import 'dart:math';

List<double> getMaxValueList(List<List<double>> list) {
  final List<List<double>> newList = [];
  final List<double> res = [];

  for (int i = 0; i < list[0].length; i++) {
    final List<double> a = [];
    for (List<double> l in list) {
      a.add(l[i]);
    }

    newList.add(a);
  }

  for (List<double> l in newList) {
    res.add(l.reduce(max));
  }

  return res;
}

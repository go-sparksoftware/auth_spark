String getInitials(List<String> names) {
  assert(names.isNotEmpty);

  late String name;
  final temp = names.where((name) => name.split(" ").length > 1).firstOrNull;
  if (temp != null) {
    name = temp;
  } else {
    name = names.first;
  }

  final parts = name.split(" ").map((part) => part[0]).toList();
  final x = [parts[0], if (parts.length > 1) parts[1]];
  return x.join();
}

class Item {
  final String headerText;
  final String expandedText;
  bool isExpanded;

  Item({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
}

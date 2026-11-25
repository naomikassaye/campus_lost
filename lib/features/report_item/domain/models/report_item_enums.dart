enum ReportType { lost, found }

enum ItemCategory {
  keys('Keys'),
  ids('IDs'),
  calculators('Calculators'),
  chargers('Chargers');

  const ItemCategory(this.label);

  final String label;
}

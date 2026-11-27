enum ReportType { lost, found }

extension ReportTypeLabel on ReportType {
  String get label {
    switch (this) {
      case ReportType.lost:
        return 'Lost';
      case ReportType.found:
        return 'Found';
    }
  }
}

enum ItemCategory {
  keys('Keys'),
  ids('IDs'),
  calculators('Calculators'),
  chargers('Chargers');

  const ItemCategory(this.label);

  final String label;
}
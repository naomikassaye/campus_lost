enum ItemStatus { open, held, claimed, returned }

extension ItemStatusLabel on ItemStatus {
  String get label {
    switch (this) {
      case ItemStatus.open:
        return 'Open';
      case ItemStatus.held:
        return 'Held';
      case ItemStatus.claimed:
        return 'Claimed';
      case ItemStatus.returned:
        return 'Returned';
    }
  }
}

class SubscriptionKey {
  final String key;
  final String keyType;
  final DateTime startDT;
  final DateTime endDT;
  final DateTime createDT;
  final String memo;

  const SubscriptionKey(this.key, this.keyType, this.startDT, this.endDT, this.createDT, this.memo);
}

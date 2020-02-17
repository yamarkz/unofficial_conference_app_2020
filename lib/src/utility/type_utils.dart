DateTime datetimeOrNull(Object object) {
  if (object is DateTime) return object;
  if (object is String) return DateTime.parse(object).toLocal();
  return null;
}

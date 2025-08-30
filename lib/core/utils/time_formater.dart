import 'package:intl/intl.dart';

String timeToReadableFormat(String isoTime) {
  try {
    final dateTime = DateTime.parse(isoTime).toLocal();

    final formatted = DateFormat('dd MMM yyyy, HH:mm').format(dateTime);

    return formatted;
  } catch (e) {
    print('Error parsing date: $e');
    return isoTime;
  }
}

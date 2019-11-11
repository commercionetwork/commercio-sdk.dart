import 'package:commerciosdk/export.dart';

void checkResponse(TransactionResult response) {
  if (response.success) {
    print(response.hash);
  } else {
    print(response.error.errorMessage);
  }
}

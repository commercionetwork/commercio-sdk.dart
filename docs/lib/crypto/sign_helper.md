# Sign helper
Sign helper allows to easily perform signature-related operations.

## Provided operations
Below you can find the sign helper's provided operations with some examples

1. Converts the given `data` into an alphabetically sorted JSON object and signs its content using the given `wallet`  
```dart
static Uint8List signSorted(Map<String, dynamic> data, Wallet wallet) 
```
## Usage examples

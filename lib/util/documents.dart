import 'package:image_picker/image_picker.dart';

class Documents {
  final XFile front;
  final XFile back;
  final String name;
  final String surname;

  Documents(this.front, this.back, this.name, this.surname);
}

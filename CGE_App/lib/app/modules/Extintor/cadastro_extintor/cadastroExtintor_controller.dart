import 'package:cge_app/app/data/Models/subject_data_model.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class CadastroExtintorController extends GetxController {
  var _extintor = 0.obs;
  get extintor => _extintor.value;

  void changeExtintor(int value) {
    _extintor.value = value;
  }

  List<SubjectModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];

  getSubjectData() {
    subjectData.clear();
    dropDownData.clear();

    Map<String, dynamic> apiResponse = {
      "code": 200,
      "message": "Course subject lists.",
      "data": [
        {"subject_id": "1", "subject_name": "AP 10L"},
        {"subject_id": "2", "subject_name": "AP 75L"},
        {"subject_id": "3", "subject_name": "ABC 4KG"},
        {"subject_id": "4", "subject_name": "ABC 6KG"},
        {"subject_id": "5", "subject_name": "BC 2KG"},
        {"subject_id": "6", "subject_name": "BC 4KG"},
        {"subject_id": "7", "subject_name": "BC 6KG"},
        {"subject_id": "8", "subject_name": "BC 50KG"},
        {"subject_id": "9", "subject_name": "CO2 6KG"}
      ]
    };

    if (apiResponse['code'] == 200) {
      List<SubjectModel> tempSubjectData = [];
      apiResponse['data'].forEach(
        (data) {
          tempSubjectData.add(
            SubjectModel(
              subjectId: data['subject_id'],
              subjectName: data['subject_name'],
            ),
          );
        },
      );
      print(tempSubjectData);
      subjectData.addAll(tempSubjectData);

      dropDownData = subjectData.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.subjectName);
      }).toList();

      update();
    } else if (apiResponse['code'] == 400) {
      print("Show Error model why error occurred..");
    } else {
      print("show some error model like something went worng..");
    }
  }
}
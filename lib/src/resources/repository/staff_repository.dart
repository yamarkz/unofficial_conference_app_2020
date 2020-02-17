import 'package:unofficial_conference_app_2020/src/models/staff.dart';
import 'package:unofficial_conference_app_2020/src/resources/api/staff_api.dart';

class StaffRepository {
  static StaffRepository _shared;
  static StaffRepository get shared => _shared;
  factory StaffRepository() => _shared ??= StaffRepository._();
  StaffRepository._();

  final staffs = <Staff>[];

  Future<List<Staff>> getStaffs() async {
    if (staffs.length > 0) return staffs;
    try {
      final response = await StaffsApi().execute();
      staffs.addAll(response.staffs.map((dynamic staff) {
        return Staff.fromJson(staff);
      }).toList());
      return staffs;
    } on Exception catch (error) {
      print(error);
      return staffs;
    }
  }
}

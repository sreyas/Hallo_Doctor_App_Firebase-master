import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_category.dart';
import 'package:hallo_doctor_doctor_app/app/models/doctor_model.dart';
import 'package:hallo_doctor_doctor_app/app/services/user_service.dart';

class DoctorService {
  static Doctor? doctor;
  set currentDoctor(Doctor? doctor) => DoctorService.doctor = doctor;

  Future saveDoctorDetail(
      {required String doctorName,
      required String hospital,
      required String shortBiography,
      required String pictureUrl,
      required DoctorCategory doctorCategory,
      required String academicQualification,
      required String pastExperienceInCompany,
      required String pastExperienceInConsulting,
      required int basePrice,
      required String age,
      required String recognition,
      required String valueYouBring,
       required String country,
      required String state,
      required String statecode,
      required String gstno,
        required String address,
        required String uniquekey,
        required String gstType,
        required String pan,
        required String mobile,




      bool isUpdate = false}) async {
    try {





      CollectionReference doctors =
          FirebaseFirestore.instance.collection('Doctors');
      Map<String, dynamic> doctorsData = {
        'doctorName': doctorName,
        'doctorHospital': hospital,
        'doctorBiography': shortBiography,
        'doctorPicture': pictureUrl,
        'doctorCategory': {
          'categoryId': doctorCategory.categoryId,
          'categoryName': doctorCategory.categoryName
        },
        'doctorBasePrice': basePrice,
        'accountStatus': 'nonactive',
        'academicQualification': academicQualification,
        'pastExperienceInCompany': pastExperienceInCompany,
        'pastExperienceInConsulting': pastExperienceInConsulting,
        'age': age,
        'doctorRating' :0.1,
        'totalRatingCount' :0,
        'recognition': recognition,
        'valueYouBring': valueYouBring,
        'country':country,
        'state':state,
        'statecode':statecode,
        'gstno':gstno,
        'address':address,
        'uniquekey':uniquekey,
        'gstType':gstType,
        'pan':pan,
        'mobile':mobile,


      };

      if (isUpdate) {
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        await doctors.doc(DoctorService.doctor!.doctorId).update(doctorsData);
        await getDoctor(forceGet: true);
      } else {
        doctorsData['createdAt'] = FieldValue.serverTimestamp();
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        var doctor = await doctors.add(doctorsData);
        UserService().setDoctorId(doctor.id);
      }
    } catch (e) {
      return Future.error(e);
    }

  }

  ///get doctor, if current doctor is null will get from server
  ///[forceGet] if true will force get from server even if current doctor is not null
  Future<Doctor?> getDoctor({bool forceGet = false}) async {
    try {
      if (DoctorService.doctor != null && forceGet == false) {
        return DoctorService.doctor;
      }

      var doctorId = await UserService().getDoctorId();
      print('doctor id : ' + doctorId);
      var doctorReference = await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctorId)
          .get();
      if (!doctorReference.exists) return null;
      print('data doctor : ' + doctorReference.data().toString());
      var data = doctorReference.data() as Map<String, dynamic>;
      data['doctorId'] = doctorId;
      Doctor doctor = Doctor.fromJson(data);
      DoctorService.doctor = doctor;
      DoctorService().currentDoctor = doctor;
      return doctor;
    } catch (e) {
      return null;
    }
  }

  Future updateDoctorBasePrice(int basePrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.doctorId)
          .update({'doctorBasePrice': basePrice});
      doctor!.doctorPrice = basePrice;
    } catch (e) {
      return Future.error(e.toString());
    }
  }


}

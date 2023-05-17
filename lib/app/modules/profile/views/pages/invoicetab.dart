
import 'dart:typed_data';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../services/doctor_service.dart';
import '../../../../services/user_service.dart';
import 'bizinvoice.dart';
import 'invoice.dart';


class InvoiceListTab extends StatefulWidget {
  @override
  _MyInvoice createState() => _MyInvoice();
}

class _MyInvoice extends State<InvoiceListTab> {
  DateTime now = DateTime.now();
  final CollectionReference invoicesCollection =
  FirebaseFirestore.instance.collection('Invoice');

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedendDate = DateTime.now();

  final TextEditingController _dateControllerstart = TextEditingController();
  final TextEditingController _dateControllerend = TextEditingController();
  late String startdate,enddate;

  late String ff;
  late DateTime toDate=DateTime.now();
  late DateTime fromDate=DateTime.parse(ff);
  late int year,month;


  ///nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn//

  DateTime currentDate = DateTime.now();

// Determine the financial year based on the current date










  final firestoreInstance = FirebaseFirestore.instance;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateControllerstart.text = '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
        startdate= _dateControllerstart.text;


      });
    }
  }


  Future<void> _selectDateend(BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedendDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedendDate) {
      setState(() {
        _selectedendDate = picked;

        _dateControllerend.text = '${_selectedendDate.year}-${_selectedendDate.month}-${_selectedendDate.day}';
        enddate= _dateControllerend.text;



      });
    }
  }





  Future<void> _exportData(DateTime start,DateTime end) async {
    String fromname,fromaddress,fromstate,fromstatecode;

    var languageSettingVersionRef = await FirebaseFirestore.instance
        .collection('Settings')
        .doc('withdrawSetting')
        .get();
    String bizName = languageSettingVersionRef.data()!['name'];
    String bizAddress = languageSettingVersionRef.data()!['address'];
    String bizState = languageSettingVersionRef.data()!['state'];
    String bizStatecode = languageSettingVersionRef.data()!['stateCode'];



    final QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Invoice').where('createdAt', isGreaterThanOrEqualTo:Timestamp.fromDate(start)).where('createdAt', isLessThanOrEqualTo: end).where('userId',isEqualTo:  UserService().currentUser!.uid).get();
    final List<List<dynamic>> csvData = [];
    csvData.add([
      'Invoiceno', 'Description','Invoice Date','From Name', 'From Address','From State','From State Code','From GSTNo','To Name', 'To Address','To State','To State Code','To GSTNo','HSN/SAC',
      'Price','CGST','SGST','IGST',
      'Total Tax','Total Amount',
    ]); // Header row for CSV

    snapshot.docs.forEach((doc) {
      DateTime createdAtDateTime = doc.data()['createdAt'].toDate();
      String formattedDate = DateFormat('dd-MM-yyyy').format(createdAtDateTime);
      String gsttype= doc.data()['gstType'];
      if(gsttype=='biz'){
        fromname=bizName;
        fromaddress=bizAddress;
        fromstate=bizState;
        fromstatecode=bizStatecode;

      }else{
        fromname=doc.data()['advisorName'];
        fromaddress= doc.data()['advisorAddress'];
        fromstate=   doc.data()['advisorState'];
        fromstatecode= doc.data()['advisorStatecode'];
      }
      csvData.add([

        doc.data()['invoiceno'],
        doc.data()['description'],
        formattedDate,
        fromname,
        fromaddress,
        fromstate,
        fromstatecode,
        doc.data()['advisorGstno'],
        doc.data()['userName'],
        doc.data()['userAddress'],
        doc.data()['userState'],
        doc.data()['userStatecode'],
        doc.data()['userGstno'],
        doc.data()['sac'],
        doc.data()['excludedGstamt'],
        doc.data()['cgst'],
        doc.data()['sgst'],
        doc.data()['igst'],
        doc.data()['tax'],
        doc.data()['includedGstamt'],
      ]);
    });









    //
    //  final csvString = const ListToCsvConverter().convert(csvData);
    //
    // final String currentDate = DateTime.now().toString().split(' ')[0];
    //
    // bool granted = await _requestStoragePermission();
    // if (granted) {
    //   String? folderPath = await FilePicker.platform.getDirectoryPath();
    //   if (folderPath != null) {
    //
    //     String filePath = '$folderPath/Invoice$currentDate.csv';
    //     File file = File(filePath);
    //     await file.writeAsString(csvString);
    //   } else {
    //     throw Exception('Folder selection cancelled.');
    //   }
    // } else {
    //   // Display error message
    // }

    final String currentDate = DateTime.now().toString().split(' ')[0];
    Directory? downloadDirectory = await getExternalStorageDirectory();
    String filePath = '${downloadDirectory!.path}/$currentDate.csv';
    String csv = const ListToCsvConverter().convert(csvData);
    File file = File(filePath);
    await file.writeAsString(csv);
    Share.shareFiles([filePath]);





  }




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.contacts), text: "User Invoice"),
                Tab(icon: Icon(Icons.camera_alt), text: "Biz Invoice")

              ],
            ), // TabBar
            title: const Text('Invoice'),
            backgroundColor: Colors.blue,
          ), // AppBar
          body:  TabBarView(
            children: [
             InvoiceListScreen(),
              InvoiceListScreenbiz(),

            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    ); // MaterialApp

  }


}



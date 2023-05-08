
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


class InvoiceListScreenbiz extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<InvoiceListScreenbiz> {
  DateTime now = DateTime.now();
  final CollectionReference invoicesCollection =
  FirebaseFirestore.instance.collection('Bizinvoice');

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
    String bizgstno = languageSettingVersionRef.data()!['gstno'];




    final QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('Bizinvoice').where('createdAt', isGreaterThanOrEqualTo:Timestamp.fromDate(start)).where('createdAt', isLessThanOrEqualTo: end).where('advisorId',isEqualTo:  DoctorService.doctor?.doctorId).get();
    final List<List<dynamic>> csvData = [];
    csvData.add([
      'Invoiceno', 'Invoice Date','Description','From Name', 'From Address','From State','From State Code','From GST No',
      'To Name', 'To Address','To State','To State Code','To GST No','HSN/SAC',
      'Call Amount','Bizboozt commision','IGST','CGST','SGST','TDS','TCS',
      'Net Payment',
    ]); // Header row for CSV

    snapshot.docs.forEach((doc) {
      DateTime createdAtDateTime = doc.data()['createdAt'].toDate();
      String formattedDate = DateFormat('dd-MM-yyyy').format(createdAtDateTime);


      csvData.add([

        doc.data()['invoiceNo'],
        formattedDate,
        doc.data()['description'],
        bizName,
        bizAddress,
        bizState,
        bizStatecode,
        bizgstno,
        doc.data()['advisorName'],
        doc.data()['advisorAddress'],
        doc.data()['advisorState'],
        doc.data()['advisorStatecode'],
        doc.data()['advisorGstno'],
        doc.data()['sac'],
        doc.data()['excludedGstamt'],
        doc.data()['bizCommision'],
        doc.data()['igst'],
        doc.data()['cgst'],
        doc.data()['sgst'],
        doc.data()['tds'],
        doc.data()['tcs'],
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


    year = currentDate.year;
    month = currentDate.month;
    late String endYear;
    if (month <= 3) {
      endYear = "${year-1}";
    } else {
      endYear = "${year}";
    }


    ff=(endYear+"-04-01 00:00:00.000") as String;








    return Scaffold(
      appBar: AppBar(
        title: Text('Biz Invoice'),
        actions: [

          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              _exportData(fromDate,toDate);

              // showDialog(
              //   context: context,
              //   builder: (context) => AlertDialog(
              //     title: Text('Select Date Range'),
              //     content: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children:<Widget>[
              //         TextField(
              //           controller: _dateControllerstart,
              //           readOnly: true,
              //           onTap: () => _selectDate(context),
              //           decoration: InputDecoration(
              //             labelText: 'Start Date',
              //             hintText: 'Select start date',
              //             suffixIcon: Icon(Icons.calendar_today),
              //             border: OutlineInputBorder(),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 10,
              //         ),
              //         TextField(
              //           controller: _dateControllerend,
              //           readOnly: true,
              //           onTap: () => _selectDateend(context),
              //           decoration: InputDecoration(
              //             labelText: 'End Date',
              //             hintText: 'Select end date',
              //             suffixIcon: Icon(Icons.calendar_today),
              //             border: OutlineInputBorder(),
              //           ),
              //         ),
              //       ],
              //     ),
              //     actions: [
              //       TextButton(
              //         child: Text('Cancel'),
              //         onPressed: () {
              //           Navigator.of(context).pop();
              //         },
              //       ),
              //       ElevatedButton(
              //         child: Text('Export'),
              //         onPressed: () {
              //           Navigator.of(context).pop();
              //           _exportData(_selectedDate,_selectedendDate);
              //         },
              //       ),
              //     ],
              //   ),
              // );
            },
          ),



        ],


      ),



      body: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {

                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          fromDate = value;
                          print(fromDate);
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Custom background color
                    onPrimary: Colors.white, // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Custom border radius
                    ),
                  ),
                  child: Text('Select From Date'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          toDate = value;
                        });
                      }
                    });

                  },

                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Custom background color
                    onPrimary: Colors.white,
                    // Custom text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // Custom border radius
                    ),
                  ),
                  child: Text('Select To Date') ,
                ),
              ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateFormat('yyyy-MM-dd').format(fromDate),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                'To',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(toDate),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              )
            ],
          ),
          Expanded(
            child:
            StreamBuilder<QuerySnapshot>(


              stream: FirebaseFirestore.instance
                  .collection('Bizinvoice')
                  .where('advisorId', isEqualTo: DoctorService.doctor?.doctorId)
                  .where('createdAt', isGreaterThanOrEqualTo: fromDate)
                  .where('createdAt', isLessThanOrEqualTo: toDate)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final documentSnapshots = snapshot.data!.docs;


                return ListView.builder(
                  itemCount: documentSnapshots.length,
                  itemBuilder: (context, index) {
                    final documentSnapshot = documentSnapshots[index];
                    DateTime date = documentSnapshot['createdAt'].toDate();

                    return  Card(
                      elevation: 8.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),

                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                          title: Text(documentSnapshot['invoiceNo'].toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Invoice Date: ${DateFormat('yyyy-MM-dd').format(date)}'),
                              Text(documentSnapshot['description']),



                            ],
                          ),
                          trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text((documentSnapshot['netPayment']).toStringAsFixed(2)),
                              ]),
                        ),),);
                  },
                );
              },
            ),),
        ],),
    );

  }


}



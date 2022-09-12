import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection('questionPaper');
DocumentReference questionRF(
        {required String paperID, required String questionID}) =>
    questionPaperRF.doc(paperID).collection('questions').doc(questionID);

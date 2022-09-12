import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login01/firebase.ref/loading_status.dart';
import 'package:login01/firebase.ref/references.dart';
import 'dart:convert';

import 'package:login01/models/quistion_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;
  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; //0
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifesMap = json.decode(manifestContent);
    final papersInAssets = manifesMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains('.json'))
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(jsonDecode(stringPaperContent)));
    }
    //print('Items number ${questionPapers[0].description}');
    var batch = fireStore.batch();
    for (var poper in questionPapers) {
      var paper;
      batch.set(questionPaperRF.doc(poper.id), {
        'title': paper.title,
        'image_url': paper.imageUrl,
        'description': paper.description,
        'time_seconds': paper.timeSeconds,
        'questions_count':
            paper.questions == null ? 0 : paper.questions!.lenght,
      });
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperID: paper.id, questionID: questions.id);
        batch.set(questionPath, {
          'questions': questions.question,
          'correct_answer': questions.correctAnswer,
        });
        for (var answer in questions.answers) {
          batch.set(questionPath.collection('answers').doc(answer.identifier),
              {'identifier': answer.identifier, 'answer': answer.answer});
        }
      }
      await batch.commit();
      loadingStatus.value = LoadingStatus.completed;
    }
  }
}

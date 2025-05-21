import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo_location/models/live_score_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<LiveScoreModel> _liveScoreList = [];
  final FirebaseFirestore db = FirebaseFirestore.instance;

  final bool _isProgress = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _getLiveScoreList();
  // }
  //
  // Future<void> _getLiveScoreList() async {
  //   _liveScoreList.clear();
  //   _isProgress = true;
  //   setState(() {});
  //
  //   final QuerySnapshot snapshot = await db.collection('football').get();
  //
  //   for (QueryDocumentSnapshot doc in snapshot.docs) {
  //     LiveScoreModel liveScoreModel = LiveScoreModel.fromJson(
  //       doc.id,
  //       doc.data() as Map<String, dynamic>,
  //     );
  //
  //     _liveScoreList.add(liveScoreModel);
  //   }
  //
  //   _isProgress = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Live Score",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: db.collection('football').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.hasData == false) {
            return SizedBox();
          }

          _liveScoreList.clear();
          for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
            LiveScoreModel liveScoreModel = LiveScoreModel.fromJson(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );

            _liveScoreList.add(liveScoreModel);
          }

          return ListView.builder(
            itemCount: _liveScoreList.length,
            itemBuilder: (context, index) {
              LiveScoreModel liveScore = _liveScoreList[index];

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      liveScore.isRunning ? Colors.green : Colors.grey,
                  radius: 8,
                ),
                title: Text(liveScore.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Team1: ${liveScore.team1}"),
                    Text("Team2: ${liveScore.team2}"),
                    Text("Winner Team: ${liveScore.winnerTeam}"),
                  ],
                ),
                trailing: Text(
                  "${liveScore.team1Score}:${liveScore.team2Score}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          LiveScoreModel liveScoreModel = LiveScoreModel(
            title: "gervseng",
            team1: "Germany",
            team2: "England",
            team1Score: 3,
            team2Score: 2,
            winnerTeam: "Germany",
            isRunning: true,
          );
          db
              .collection('football')
              .doc(liveScoreModel.title)
              .set(liveScoreModel.toJson());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

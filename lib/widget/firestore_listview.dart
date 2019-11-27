import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merdhamel/widget/empty.dart';

typedef FireStoreListBuilder = Widget Function(
    BuildContext context, DocumentSnapshot document);

typedef FirestoreListFilter = bool Function(DocumentSnapshot doc);

class FireStoreListView extends StatelessWidget {
  final FireStoreListBuilder itemBuilder;
  final Stream<QuerySnapshot> snapshot;
  final FirestoreListFilter filter;
  final Axis scrollDirection;
  final bool useSeparation;
  final bool shrinkWrap;
  final int crossAxisCount;
  final double gridAspectRatio;
  FireStoreListView(
      {@required this.itemBuilder,
      @required this.snapshot,
      this.filter,
      this.scrollDirection = Axis.vertical,
      this.useSeparation = true,
      this.shrinkWrap = false,
      this.gridAspectRatio = 1.0,
      this.crossAxisCount = 2});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: snapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text("Error : ${snapshot.error}"),
          );
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          default:
            final list = filter != null
                ? snapshot.data.documents.where(filter).toList()
                : snapshot.data.documents;
            return list.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: WidgetEmpty(),
                    ),
                  )
                : useSeparation
                    ? ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: scrollDirection,
                        itemCount: list.length,
                        shrinkWrap: shrinkWrap,
                        itemBuilder: (context, index) {
                          return itemBuilder(context, list[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                              height: 0.0,
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: scrollDirection,
                        itemCount: list.length,
                        shrinkWrap: shrinkWrap,
                        itemBuilder: (context, index) {
                          return itemBuilder(context, list[index]);
                        },
                      );
        }
      },
    );
  }
}

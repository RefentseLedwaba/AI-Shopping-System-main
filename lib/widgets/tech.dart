import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aishop/widgets/product_model.dart';

import '../theme.dart';
class Tech extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0,
      height: 400,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Products")
            .where("category", isEqualTo: "Tech")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: lightgrey,
              ),
            );
          } else {
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 3/2, mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                return ProductCard(
                  snapshot.data!.docs[index].id,
                  snapshot.data!.docs[index].get('url'),
                  snapshot.data!.docs[index].get('name'),
                  snapshot.data!.docs[index].get('description'),
                  snapshot.data!.docs[index].get('price').toString(),
                );
              },
              itemCount: snapshot.data!.docs.length,
            );
          }
        },
      ),
    );
  }
}

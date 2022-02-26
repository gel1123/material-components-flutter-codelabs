// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // DONE: Make a collection of cards (102)
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) {
      return <Card>[];
    }
    final ThemeData theme = Theme.of(context);

    // ロケールをもとに通貨フォーマッタを作成
    String locale = Localizations.localeOf(context).toString();
    print("locale: " + locale);
    NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: locale,
    );
    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // DONE: Adjust card heights (103)
        elevation: 0.0,
        child: Column(
          // DONE: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth, // Imageの大きさを親要素横幅に合わせる
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                // DONE: Align labels to the bottom and center (103)
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                // DONE: Change innermost Column (103)
                children: <Widget>[
                  // TODO: Handle overflowing labels (103)
                  Text(
                    product.name,
                    style: theme.textTheme.button,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    formatter.format(product.price),
                    style: theme.textTheme.caption,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }).toList();
  }

  // TODO: Add a variable for Category (104)
  @override
  Widget build(BuildContext context) {
    // TODO: DONE an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return AsymmetricView(products: ProductsRepository.loadProducts(
        Category.all
    ));
  }
}

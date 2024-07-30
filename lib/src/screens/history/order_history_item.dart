import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_can_cook/generated/l10n.dart';
import 'package:it_can_cook/src/bloc/recipe_all/recipes_all_bloc.dart';
import 'package:it_can_cook/src/models/order/history_order.dart';
import 'package:it_can_cook/src/models/weekly/recipe.dart';

class OrderHistoryItem extends StatefulWidget {
  final List<OrderDetails> orderDetails;

  const OrderHistoryItem({super.key, required this.orderDetails});
  @override
  _OrderHistoryItemState createState() => _OrderHistoryItemState();
}

class _OrderHistoryItemState extends State<OrderHistoryItem> {
  @override
  Widget build(BuildContext context) {
    var recipesAllBloc = context.watch<RecipesAllBloc>().state;
    return ListView.builder(
      itemCount: widget.orderDetails.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "dish_detail",
                              arguments: recipesAllBloc
                                  .where((element) =>
                                      element.recipeId ==
                                      widget.orderDetails[index].recipeId)
                                  .firstOrNull);
                        },
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.orderDetails[index].recipe?.img ?? "",
                          width: 80,
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderDetails[index].recipe?.name ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              (widget.orderDetails[index].recipe?.description ??
                                              "")
                                          .length >
                                      40
                                  ? "${(widget.orderDetails[index].recipe?.description ?? "").substring(0, 40)}..."
                                  : widget.orderDetails[index].recipe
                                          ?.description ??
                                      "",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: ExpansionTile(
                                  title: Text(S.current.ingredients),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  children: widget.orderDetails[index]
                                      .recipeIngredientOrderDetails
                                      .map((e) => Text(
                                          "${e.ingredient?.name} x ${e.amount} ${e.ingredient?.unit}"))
                                      .toList()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "x ${widget.orderDetails[index].quantity}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${widget.orderDetails[index].price?.toStringAsFixed(0).replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},',
                            )}đ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

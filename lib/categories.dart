import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/categorie_model.dart';
import 'package:shopapp/login.dart';
import 'package:shopapp/shared_prefrences.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopStates.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categorieModel!.data!.data![index]),
              separatorBuilder: (context, index) => SizedBox(
                    height: 10,
                  ),
              itemCount: ShopCubit.get(context).categorieModel!.data!.data!.length);
        });
  }

  Widget buildCatItem(Datum d) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          Image(
            image: NetworkImage(d.image.toString()),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            d.name.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ]),
      );
}

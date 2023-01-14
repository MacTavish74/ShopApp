import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/categorie_model.dart';
import 'package:shopapp/class_home_model.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopCubit.dart';
import 'package:shopapp/shopStates.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition :ShopCubit.get(context).homeModel != null &&  ShopCubit.get(context).categorieModel !=null,
           builder :(context) => productsBuilder(ShopCubit.get(context).homeModel, ShopCubit.get(context).categorieModel),
           fallback :(context) =>Center(child:CircularProgressIndicator() ,)    
              
             );},
    );

  }
 
}

  Widget productsBuilder(HomeModel? model,CategorieModel? categorieModel) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data?.banners! 
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                viewportFraction: 1.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
          SizedBox(
            height: 10,
          ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  
    children: [
  
          Text('Categories',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800),),
  
        SizedBox(
            height: 10,
          ),
  
      Container(height: 100,
  
      
  
        child:   ListView.separated(scrollDirection: Axis.horizontal,
  
      
  
        physics: BouncingScrollPhysics(),
  
      
  
        
  
      
  
        itemBuilder:(context, index) => buildCategorieitem(categorieModel.data!.data![index]) ,
            separatorBuilder:(context, index) => SizedBox(width: 10,) ,
             itemCount: categorieModel!.data!.data!.length
  
      
  
                    ),
  
      
  
      ),
  
        SizedBox(
            height: 30,
          ),
  
      Text('New Products',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800)),
  
    ],
  
  ),
),



          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.6,
              children: List.generate(model!.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index])),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridProduct(Product model) {
    
    return Container(color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image.toString()),
                width: double.infinity,
                height: 200,
              ),
                                          if(model.discount!=0)

              Container(color: Colors.red,
                child: Text('Discount',style: TextStyle(color: Colors.white),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  model.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text('${model.price!.round()}',style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(width: 20,),
                            if(model.discount!=0)

              Text('${model.oldPrice!.round()}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),)
            ],
          )
        ],
      ),
    );
  }

Widget buildCategorieitem(Datum d){
return Stack(
  alignment: AlignmentDirectional.bottomStart,

  children: [
Image(image: NetworkImage(d.image.toString()),height: 100,width: 100,fit: BoxFit.cover,)
,Container(
  color: Colors.black.withOpacity(0.8),
  width: 100,
  child: Text(d.name.toString(),style: TextStyle(color: Colors.white),textAlign:TextAlign.center ,),

)

  ],
);


}




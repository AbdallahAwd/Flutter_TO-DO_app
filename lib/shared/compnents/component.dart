import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:learning/modules/webview/webviewScreen.dart';
import 'package:learning/shared/Cubit/Cubit.dart';

Widget defaultButton({
  double width = 300.0,
  double radius = 20.0,
  Color BackGround = Colors.blue,
  @required String text,
  bool isUpper = true,
  @required Function onpressed,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: BackGround,
        borderRadius: BorderRadius.circular(radius),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );

Widget defaultTextFormFeild({
  @required TextEditingController controller,
  @required IconData pre,
  @required String HintText,
  Function validate,
  Function onTab,
  Function onSubmit,
  IconData suff,
  bool isObscure = false,
  @required var KeyType,
  Function suffPress,

}) =>
    TextFormField(
      keyboardType: KeyType,
      obscureText: isObscure,
      controller: controller,
      onTap: onTab,
      style: TextStyle(
        color:Colors.grey,
      ),
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        hoverColor: Colors.white,
        prefixIcon: Icon(pre),
        suffixIcon: IconButton(onPressed: suffPress, icon: Icon(suff)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: HintText,
      ),
      validator: validate,
    );

Widget ListItems(Map model, context) => Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Archive',
          color: Colors.brown,
          icon: Icons.archive,
          onTap: () {
            AppCubit.get(context).updateDB(status: 'archived', id: model['id']);
          },
        ),
        IconSlideAction(
          caption: 'Done',
          color: Colors.indigo,
          icon: Icons.check_circle_outline,
          onTap: () {
            AppCubit.get(context).updateDB(status: 'done', id: model['id']);
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete_outline,
          onTap: () {
            AppCubit.get(context).deleteDB(id: model['id']);
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Center(
                child: Text(
                  '${model['time']}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget whenEmpty() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/add-to-cart.png'),
          height: 150,
          width: 150,
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          'Add Tasks',
          style: TextStyle(
              color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

Widget listNewsItems(model, context) => InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>WebViewScreen(model['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${model['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['description']}',
                    style: Theme.of(context).textTheme.bodyText2,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

Widget ListCubitBuilder(cubit , {bool isSearch = false ,}) => ConditionalBuilder(
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => listNewsItems(cubit[index], context),
          separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 20.0,
                endIndent: 20.0,
                color: Colors.grey,
              ),
          itemCount: cubit.length),
      condition: cubit.length > 0,
      fallback: (context) => isSearch ? Container():Center(child: CircularProgressIndicator()),
    );

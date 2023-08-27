import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget DefaultFormField({
  required TextEditingController Controller,
  required TextInputType Type,
  required Validator,
  onChange,
  onSubmit,
  onTap,
  bool IsClickable = true,
  required String Label,
  required IconData Prefix,
}) =>
    TextFormField(
      controller: Controller,
      keyboardType: Type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      style: const TextStyle(fontSize: 20),
      enabled: IsClickable,
      validator: Validator,
      decoration: InputDecoration(
        labelText: Label,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: const TextStyle(fontSize: 24),
        prefixIcon: Icon(Prefix),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );

Widget buildTaskItem(Map Model, context) => Dismissible(
      key: Key(Model['Id'].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete_rounded,
          size: 80,
        ),
      ),
      onDismissed: (direction) {},
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Container(
          width: 385,
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15))),
                width: double.infinity,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 35,
                        )),
                    Text(
                      '${Model['Date']}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.archive_outlined,
                          size: 35,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Center(
                    child: Text(
                      '${Model['Title']}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    '${Model['Time']}',
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

Widget buildArticlesItem(article, context) => InkWell(
  onTap: () async{
    final url = Uri.parse(article['url']);
    if(await canLaunchUrl(url)){
       launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
    }
  },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget MyDivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );

void NavigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

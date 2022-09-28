import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_assignment6/constants/colors.dart';
import 'package:news_app_assignment6/constants/styles.dart';
import 'package:news_app_assignment6/modals/articles.dart';
import 'package:news_app_assignment6/providers/provider_data.dart';
import 'package:provider/provider.dart';

class CreateNewArticle extends StatefulWidget {
  const CreateNewArticle({Key? key}) : super(key: key);

  static const routeName = '/addNewArticle';
  @override
  State<CreateNewArticle> createState() => _CreateNewArticleState();
}

class _CreateNewArticleState extends State<CreateNewArticle> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _isInit = true;
  var time = DateFormat.yMMMd().format(DateTime.now());

  var _addedArticle = Articles(
      authorName: '',
      description: '',
      dateTime: DateFormat.yMEd().toString(),
      imageUrl: '',
      title: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    // _priceFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        //Update Product
        Provider.of<ProviderData>(context, listen: false)
            .addArticle(_addedArticle);
      } catch (error) {
        await errorDialogue();
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushNamed('/');
      }
    } else {
      return;
    }
  }

  Future<Null?> errorDialogue() {
    return showDialog<Null>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('An Error Occured!'),
              content: const Text('Something went wrong'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'))
              ],
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundcolor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: appBarThemeBackgroundColor,
        title: const Text(
          'Add a new article',
          style: appBarTitleStyle,
        ),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
            color: appBarIconColor,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'author name'),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _addedArticle = Articles(
                            title: _addedArticle.title,
                            authorName: value.toString(),
                            description: _addedArticle.description,
                            imageUrl: _addedArticle.imageUrl,
                            dateTime: time);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a author name.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'title'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLines: 3,
                      onSaved: (value) {
                        _addedArticle = Articles(
                            title: value.toString(),
                            authorName: _addedArticle.authorName,
                            description: _addedArticle.description,
                            imageUrl: _addedArticle.imageUrl,
                            dateTime: time);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'description'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLines: 3,
                      onSaved: (value) {
                        _addedArticle = Articles(
                            title: _addedArticle.title,
                            authorName: _addedArticle.authorName,
                            description: value.toString(),
                            imageUrl: _addedArticle.imageUrl,
                            dateTime: time);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter description.';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.black),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Enter URL',
                                    textAlign: TextAlign.center)
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Image Url',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {},
                            onSaved: (value) {
                              _addedArticle = Articles(
                                  title: _addedArticle.title,
                                  authorName: _addedArticle.authorName,
                                  description: _addedArticle.description,
                                  imageUrl: value.toString(),
                                  dateTime: time);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Valid Url';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

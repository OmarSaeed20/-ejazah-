import 'package:ejazah/Widgets/app_colors.dart';
import 'package:ejazah/Widgets/app_fonts.dart';
import 'package:ejazah/Widgets/customAppBar.dart';
import 'package:ejazah/model/items_for_asking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../controller/get_questions_controller.dart';
import '../../model/get_questions_model.dart';
import '../../utils/enums.dart';

class AskMeScreen extends StatefulWidget {
  const AskMeScreen({super.key});

  @override
  State<AskMeScreen> createState() => _AskMeScreenState();
}

class _AskMeScreenState extends State<AskMeScreen> {
  TextEditingController searchController = TextEditingController();
  List<Item> _data = [];
  List<Item> _search = [];
  RequestState requestState = RequestState.waiting;
  GetQuestionsModel? getQuestionsModel;

  Future<void> getData() async {
    setState(() => requestState = RequestState.loading);
    final res = await GetQuestionsController.getQuestions();
    if (res) {
      getQuestionsModel = GetQuestionsController.getQuestionsModel;
      _data = List<Item>.generate(getQuestionsModel!.data!.questions!.length,
          (index) {
        final question = getQuestionsModel!.data!.questions![index];
        return Item(
          headerText: question.title!,
          expandedText: question.answer!,
        );
      });
      setState(() => requestState = RequestState.success);
    } else {
      setState(() => requestState = RequestState.error);
    }
  }

  void search(String question) {
    _search.clear();
    _data.forEach((element) {
      if (element.headerText.contains(question)) {
        _search.add(element);
      } else {
        _search.remove(element.headerText);
      }
    });
    print(question);
    print(_search.length);
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: Stack(
        children: <Widget>[
          (Scaffold(
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                            top: size.height * 0.05,
                            bottom: size.height * 0.05,
                            left: size.height * 0.02,
                            right: size.height * 0.02,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/group45871.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                          constraints:
                              BoxConstraints.expand(height: size.height * .31),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomAppBar(pageTitle: ''),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'كيف نستطيع \n مساعدتك',
                                        style: TextStyle(
                                            fontSize: AppFonts.t1,
                                            color: AppColor.orangeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                          'إجابات للأسئله الأكثر شيوعا داخل التطبيق',
                                          style: TextStyle(
                                              fontSize: AppFonts.t3,
                                              color: Colors.white))
                                    ],
                                  ),
                                  Container(
                                    child: SvgPicture.asset(
                                      'assets/svg/group36771.svg',
                                      height: 15.h,
                                      width: 15.w,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          margin: EdgeInsets.only(
                            top: 27.h,
                          ),
                          child: Container(
                            child: getCardContainer(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Builder(builder: (context) {
                      if (requestState == RequestState.loading)
                        return Center(child: CircularProgressIndicator());
                      if (requestState == RequestState.error || _data.isEmpty)
                        return Column(
                          children: [
                            Text('تأكد من اتصالك بالانترنت'),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.amber[900])),
                                onPressed: () {
                                  getData();
                                },
                                child: Text('اعد المحاولة')),
                          ],
                        );

                      return Builder(builder: (context) {
                        if (_search.isNotEmpty &&
                            searchController.text.isNotEmpty)
                          return SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              padding:
                                  EdgeInsets.only(left: 1.5.w, right: 1.5.w),
                              child: ExpansionPanelList(
                                animationDuration: Duration(milliseconds: 600),
                                elevation: 2,
                                expandedHeaderPadding: EdgeInsets.all(3),
                                expansionCallback:
                                    (int index, bool isExpanded) {
                                  setState(() {
                                    _search[index].isExpanded = !isExpanded;
                                  });
                                },
                                children:
                                    _search.map<ExpansionPanel>((Item item) {
                                  return ExpansionPanel(
                                      headerBuilder:
                                          (context, bool isExpanded) {
                                        return ListTile(
                                          title: Text(
                                            item.headerText,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        );
                                      },
                                      body: ListTile(
                                        title: Text(item.expandedText),
                                        onTap: () {},
                                      ),
                                      isExpanded: item.isExpanded);
                                }).toList(),
                              ));
                        if (searchController.text.isNotEmpty)
                          return Text('لم يتم العثور على سؤالك');
                        print('nooooo search');
                        return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
                            child: ExpansionPanelList(
                              animationDuration: Duration(milliseconds: 600),
                              elevation: 2,
                              expandedHeaderPadding: EdgeInsets.all(3),
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  _data[index].isExpanded = !isExpanded;
                                });
                              },
                              children: _data.map<ExpansionPanel>((Item item) {
                                return ExpansionPanel(
                                    headerBuilder: (context, bool isExpanded) {
                                      return ListTile(
                                        title: Text(
                                          item.headerText,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      );
                                    },
                                    body: ListTile(
                                      title: Text(item.expandedText),
                                      onTap: () {},
                                    ),
                                    isExpanded: item.isExpanded);
                              }).toList(),
                            ));
                      });
                    })
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget getCardContainer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(8),
      width: size.width,
      height: 7.5.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 245, 245, 245),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(style: BorderStyle.none),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: searchController,
        enableInteractiveSelection: true,
        cursorHeight: 25,
        cursorWidth: 2,
        onChanged: (value) {
          search(value);
        },
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(
            'assets/svg/search-normal.svg',
            width: 50,
            height: 50,
          ),
          hintText: 'ابحث عن سؤال',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

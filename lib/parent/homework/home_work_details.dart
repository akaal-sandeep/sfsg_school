import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/controller/parent_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/button.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';
 import 'package:pdf/widgets.dart' as pw;
import '../../parent_model/home_work_uploaded_student_model.dart';

class HomeworkDetails extends StatefulWidget {
  String className;
  String classMasterId;
  String classSectionMasterId;
  String subjectMasterId;
  String subjectName;
  String homeWorkId;
  String rowVersion;
  UploadedHomeWorkStudentModel uploadedHomeWorkStudentModel;

  HomeworkDetails(
      {Key? key,
      required this.classMasterId,
      required this.subjectName,
      required this.classSectionMasterId,
      required this.className,
      required this.homeWorkId,
      required this.rowVersion,
      required this.uploadedHomeWorkStudentModel,
      required this.subjectMasterId})
      : super(key: key);

  @override

  State<HomeworkDetails> createState() => _HomeworkDetailsState();
}

class _HomeworkDetailsState extends State<HomeworkDetails> {

  final globalkey = GlobalKey<FormState>();
  TextEditingController? linkControiller;
  FocusNode? linkNode;

  File? finalImage;

  TextEditingController homeWorkController = TextEditingController();
  FocusNode homeWorkFocus = FocusNode();
  late PDFDocument doc;
  String fileSource = "";
  List<DocumentUpload> documentList = [];

  prepareDocuments() async {
    for (int i = 0;
        i < widget.uploadedHomeWorkStudentModel.data!.documentsList!.length;
        i++) {
      myLog(label: "i", value: i);
      if (widget.uploadedHomeWorkStudentModel.data!.documentsList![i].fileUrl!
              .split(".")
              .last ==
          "pdf") {
        doc = await PDFDocument.fromURL(widget
                .uploadedHomeWorkStudentModel.data!.documentsList![i].fileUrl ??
            "");
        documentList.add(DocumentUpload(
            fileSource: widget.uploadedHomeWorkStudentModel.data!
                    .documentsList![i].fileUrl ??
                "",
            doc: doc,
            fromUrl: true,
            documentsList:
                widget.uploadedHomeWorkStudentModel.data!.documentsList![i]));
      } else {
        documentList.add(DocumentUpload(
            fileSource: widget.uploadedHomeWorkStudentModel.data!
                    .documentsList![i].fileUrl ??
                "",
            fromUrl: true,
            documentsList:
                widget.uploadedHomeWorkStudentModel.data!.documentsList![i]));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    linkControiller=TextEditingController();
    linkNode=FocusNode();
    prepareDocuments();
    homeWorkController.text =
        widget.uploadedHomeWorkStudentModel.data?.remarks ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: floatingButton(),
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title: "Upload Home Work",
            hideStudentName: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  largeSpace(),
                  Text(
                    "${widget.subjectName}, ${widget.className}, ${getTimeFormat(DateTime.now())}",
                    style: CommonDecoration.subHeaderStyle,
                  ),
                  smallSpace(),
                  MyTextFieldMulti(
                      hint: "Home Work",
                      inputType: TextInputType.multiline,
                      textEditingController: homeWorkController,
                      focusNode: homeWorkFocus,
                      borderColor: Colors.blue,
                      borderRadius: 10,
                      filled: false,
                      icon: Icon(Icons.edit),
                      isValidate: true),
                  smallSpace(),
                  ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: documentList.length,
                      itemBuilder: (context, i) {
                        DocumentUpload document = documentList[i];
                      if(document.documentsList?.isActive==false){
                        return Container();
                      }
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              viewDocument(
                                  fileSource: document.fileSource,
                                  fromUrl: true);
                            },
                            child: detailsCard(
                                label: "Document(optional)",
                                content: Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child:document.isLink==true?Text("${document.fileSource}"): document.fileSource
                                                  .split(".")
                                                  .last ==
                                              "pdf"
                                          ? viewPdf(doc: document.doc!)
                                          : document.fromUrl
                                              ? myImage(
                                                  isNetwork: document.fromUrl,
                                                  source: document.fileSource)
                                              : Image.file(
                                                  File(document.fileSource)),
                                    ),
                                    if (document.fileSource.isNotEmpty)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            if(documentList[i].fromUrl){
                                              documentList[i].documentsList!.isActive=false;
                                            }else{
                                              documentList.removeAt(i);

                                            }
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.red,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Clear",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 10),
                                                ),
                                                Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: Colors.red,
                                                  size: 13,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                )),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Widget floatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            _pickerDialog();

          },
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
              boxShadow: myShadow,
              borderRadius: BorderRadius.circular(100),
              color: Colors.blue,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.attach_file_sharp,
                  color: Colors.white,
                ),
                Text(
                  "Attachment",
                  style:
                      CommonDecoration.listStyle.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            if (homeWorkController.value.text.isEmpty) {
              showMessage(msg: "Please enter home work title");
              return;
            }

            ParentController().saveUploadHomeWorkWithMultipleDocuments(
                classHomeWorkId: widget.homeWorkId,
                subjectMasterId: widget.subjectMasterId,
                documentList: documentList,
                rowVersion: widget.uploadedHomeWorkStudentModel.data!.rowVersion
                    .toString(), homeWork: homeWorkController.value.text, subjectName: widget.subjectName);
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: myShadow,
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  _pickerDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          insetPadding: EdgeInsets.zero,
          alignment: Alignment.center,
          title: Center(
            child: Text(
              "Select Attachment from",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconText(
                    title: "Camera",
                    iconImage: "assets/icons/camera.png",
                    onTab: () {
                      pickImage(
                          source: ImageSource.camera,
                          selectedImg: finalImage)
                          .then((value)async {
                        myLog(label: "file source", value: value.path.toString().isEmpty);
                        if(value.path.toString().isNotEmpty){

                          final pdf = pw.Document();
                          final image = pw.MemoryImage(
                            File(value.path).readAsBytesSync(),
                          );
                          pdf.addPage(pw.Page(build: (pw.Context context) {
                            return pw.Center(
                              child: pw.Image(image),
                            ); // Center
                          }));
                          showLoader();
                          final path = await getApplicationDocumentsDirectory();
                          final file = File("${path.path}/demo.pdf");
                          await file.writeAsBytes(await pdf.save());
                          doc = await PDFDocument.fromFile(file);
                          hideLoader();
                          documentList.add(DocumentUpload(
                              fileSource: file.path,doc: doc, fromUrl: false));
                          setState(() {});
                        }

                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                _iconText(
                    title: "Gallery",
                    iconImage: "assets/icons/gallery.png",
                    onTab: () {
                      pickImage(
                          source: ImageSource.gallery,
                          selectedImg: finalImage)
                          .then((value) async{
                        if(value.path.toString().isNotEmpty){
                          final pdf = pw.Document();
                          final image = pw.MemoryImage(
                            File(value.path).readAsBytesSync(),
                          );
                          pdf.addPage(pw.Page(build: (pw.Context context) {
                            return pw.Center(
                              child: pw.Image(image),
                            ); // Center
                          }));
                          showLoader();
                          final path = await getApplicationDocumentsDirectory();
                          final file = File("${path.path}/demo.pdf");
                          await file.writeAsBytes(await pdf.save());
                          doc = await PDFDocument.fromFile(file);
                          hideLoader();
                          documentList.add(DocumentUpload(
                              fileSource: file.path,doc: doc, fromUrl: false));
                          setState(() {});
                        }
                      });
                    }),
                SizedBox(
                  width: 10,
                ),
                _iconText(
                    title: "File",
                    iconImage: "assets/icons/document.png",
                    onTab: () async {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'pdf'],
                      );

                      if (result != null) {
                        fileSource = result.files.single.path!;

                        if (fileSource.split(".").last == "pdf") {
                          doc = await PDFDocument.fromFile(File(fileSource));
                          documentList.add(DocumentUpload(
                              fileSource: fileSource,
                              doc: doc,
                              fromUrl: false));
                          // doc = await PDFDocument.fromFile(File(fileSource));
                        } else {
                          documentList.add(DocumentUpload(
                              fileSource: fileSource, fromUrl: false));
                        }
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    }),
                SizedBox(
                  width: 10,
                ),
                _iconText(
                    title: "Link",
                    iconImage: "assets/icons/link.png",
                    onTab: () {
                      linkControiller!.clear();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return Form(
                              key: globalkey,
                              child:
                              StatefulBuilder(
                                builder: (context, setInnerState){
                                  return
                                    AlertDialog(
                                      actionsPadding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      actions: <Widget>[
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,

                                          validator: (value) {
                                            String pattern =
                                                r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?';
                                            RegExp regExp = new RegExp(pattern);
                                            if (value!.length == 0) {
                                              return 'Please enter url';
                                            } else if (!regExp.hasMatch(value)) {
                                              return 'Please enter valid url';
                                            }
                                            return null;
                                          },


                                          controller: linkControiller,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          decoration: InputDecoration(
                                            focusColor: Colors.white,
                                            //add prefix icon
                                            prefixIcon: Icon(
                                              Icons.link,
                                              color: Colors.grey,
                                            ),


                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),

                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.blue, width: 1.0),
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            fillColor: Colors.grey,
                                            hintText: "Enter Url",

                                            labelText: 'Url',
                                          ),
                                        ),
                                        smallSpace(),
                                        InkWell(
                                          child: MyButton(
                                            borderRadius: 10,
                                            color: ColorConstants.themeColor,
                                            text: "Submit Your Link",
                                          ),
                                          onTap: () {
                                            setInnerState((){
                                              if (globalkey.currentState!.validate()) {
                                                Get.back();
                                                documentList.add(DocumentUpload(fileSource: linkControiller!.value.text, fromUrl: false,isLink: true));
                                                setState(() {

                                                });

                                              }
                                            });

                                          },
                                        )
                                      ],
                                    );


                                },
                              )

                          );
                        },
                      );
                    }),
              ],
            ),
            SizedBox(height: 5),
            // Align(
            //   alignment: Alignment.center,
            //   child: _iconText(
            //       title: "Scan",
            //       iconImage: "assets/icons/scan.png",
            //       onTab: () async{
            //         final imagesPath = await CunningDocumentScanner.getPictures();
            //         myLog(label: "images path", value: imagesPath!.toList().toString());
            //         showLoader();
            //         final pdf = pw.Document();
            //         for(var u in imagesPath){
            //           final image = pw.MemoryImage(
            //             File(u).readAsBytesSync(),
            //           );
            //           pdf.addPage(pw.Page(build: (pw.Context context) {
            //             return pw.Center(
            //               child: pw.Image(image),
            //             ); // Center
            //           }));
            //         }
            //         final path = await getApplicationDocumentsDirectory();
            //         final file = File("${path.path}/demo.pdf");
            //         await file.writeAsBytes(await pdf.save());
            //         doc = await PDFDocument.fromFile(file);
            //         hideLoader();
            //         documentList.add(DocumentUpload(
            //             fileSource: file.path,doc: doc, fromUrl: false));
            //         setState(() {});
            //       }),
            // ),
          ],
        );
      },
    );
  }
}
Future<File> pickImage({source, selectedImg}) async {
  final image = await ImagePicker().pickImage(source: source,imageQuality: 10);
  File selectedImg = File(image?.path ?? "");
  return selectedImg;
}

_iconText({iconImage, title, onTab}) {
  return InkWell(
    onTap: () {
      Get.back();
      onTab();
    },
    child: Container(
      width: 74,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 1.0,
              color: Colors.grey.withOpacity(0.3))
        ],
        // shape: BoxShape.circle,
      ),
      child: Column(
        children: [
          SizedBox(
              width: 50, child: myImage(isNetwork: false, source: iconImage)),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}





class DocumentUpload {
  PDFDocument? doc;
  DocumentsList? documentsList;
  String fileSource = "";
  bool fromUrl = false;
  bool? isLink;

  DocumentUpload(
      {required this.fileSource,
      this.doc,
      required this.fromUrl,
        this.isLink,
      this.documentsList});
}

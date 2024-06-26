import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_school_manager/constants/color_constants.dart';
import 'package:web_school_manager/drawer/module/contact_us.dart';
import 'package:web_school_manager/parent/homework/home_work_details.dart';
import 'package:web_school_manager/widget/button.dart';
import '../../../teacher_model/get_class_homework_by_subject_model.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_school_manager/common-functions.dart';
import 'package:web_school_manager/controller/teacher_controller.dart';
import 'package:web_school_manager/utility/custom_decoration.dart';
import 'package:web_school_manager/utility/helper_widget.dart';
import 'package:web_school_manager/widget/header.dart';
import 'package:web_school_manager/widget/mytextfield.dart';
import 'package:pdf/widgets.dart' as pw;

class UploadHomeWork extends StatefulWidget {
  bool? student;
  bool? fromHolidayWork;
  String className;
  String classMasterId;
  String classSectionMasterId;
  String subjectMasterId;
  String subjectName;
  String title;
  List<DocumentsList> documents;
  String homeWorkId;
  String rowVersion;
  bool? filled;
  bool? fromClassWork;
  GetClassHomeWorkBySubjectDateModel? getClassHomeWorkBySubjectDateModel;

  UploadHomeWork(
      {Key? key,
      required this.classMasterId,
      required this.documents,
      required this.title,
      this.student,
        this.fromHolidayWork,
        this.fromClassWork,
      required this.subjectName,
      required this.classSectionMasterId,
      required this.className,
      required this.homeWorkId,
      required this.rowVersion,
      this.getClassHomeWorkBySubjectDateModel,
      this.filled,
      required this.subjectMasterId})
      : super(key: key);

  @override
  State<UploadHomeWork> createState() => _UploadHomeWorkState();
}

class _UploadHomeWorkState extends State<UploadHomeWork> {
  final globalkey = GlobalKey<FormState>();
  TextEditingController? linkControiller;
  FocusNode? linkNode;
  File? finalImage;

  TextEditingController homeWorkController = TextEditingController();
  FocusNode homeWorkFocus = FocusNode();
  late PDFDocument doc;
  String fileSource = "";
  List<DocumentUpload> documentList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    linkControiller!.clear();
  }

  DateTime selectedDate  = DateTime.now() ;

  @override
  void initState() {
    linkControiller = TextEditingController();
    linkNode = FocusNode();
    if (widget.student ?? false) {
      homeWorkController.text = widget.title;
    } else {
      homeWorkController.text =
          widget.getClassHomeWorkBySubjectDateModel?.data?.work ?? "";
      if(homeWorkController.value.text.isEmpty){
        homeWorkController.text =
            widget.getClassHomeWorkBySubjectDateModel?.data?.homeWork ?? "";
      }
    }
    addDocuments();

    // TODO: implement initState
    super.initState();
  }

  addDocuments() async {
    documentList = [];
    for (int i = 0; i < widget.documents.length; i++) {
      if (widget.documents[i].fileUrl.toString().split(".").last == "pdf") {
        doc = await PDFDocument.fromURL(widget.documents[i].fileUrl.toString());
        documentList.add(DocumentUpload(
            fileSource: widget.documents[i].fileUrl.toString(),
            doc: doc,
            fromUrl: true,
            id: widget.documents[i].id.toString(),
            documentFormat:
                widget.documents[i].documentName.toString().split("/").last,
            documentName: widget.documents[i].documentName.toString(),
            fileUrl: widget.documents[i].fileUrl.toString(),
            isActive: widget.documents[i].isActive.toString(),
            isApproved: widget.documents[i].isApproved.toString(),
            isLocked: "false",
            isVideoFile: widget.documents[i].isVideoFile.toString(),
            isYoutubeLink: widget.documents[i].isYoutubeLink.toString()));
        // doc = await PDFDocument.fromFile(File(fileSource));
      }else if(widget.documents[i].fileUrl.toString().split(".").last=="YOUTUBE_VIDEO_LINK"){
        documentList.add(DocumentUpload(
            fileSource: widget.documents[i].documentName.toString(),
            fromUrl: true,
            isLink: true,
            documentFormat:"YOUTUBE_VIDEO_LINK",
            id: widget.documents[i].id.toString(),
            documentName: widget.documents[i].documentName.toString(),
            fileUrl: widget.documents[i].fileUrl.toString(),
            isActive: widget.documents[i].isActive.toString(),
            isApproved: widget.documents[i].isApproved.toString(),
            isLocked: "false",
            isVideoFile: widget.documents[i].isVideoFile.toString(),
            isYoutubeLink: widget.documents[i].isYoutubeLink.toString()));
      } else {
        documentList.add(DocumentUpload(
            fileSource: widget.documents[i].fileUrl.toString(),
            fromUrl: true,
            documentFormat:
                widget.documents[i].documentName.toString().split("/").last,
            id: widget.documents[i].id.toString(),
            documentName: widget.documents[i].documentName.toString(),
            fileUrl: widget.documents[i].fileUrl.toString(),
            isActive: widget.documents[i].isActive.toString(),
            isApproved: widget.documents[i].isApproved.toString(),
            isLocked: "false",
            isVideoFile: widget.documents[i].isVideoFile.toString(),
            isYoutubeLink: widget.documents[i].isYoutubeLink.toString()));
      }
    }
    setState(() {});
  }

  Future getTime() async {
    DateTime? picker = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year,4),
      lastDate: DateTime.now(),

    );
    return picker;
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.fromHolidayWork==true?"Holiday Work": widget.fromClassWork==true?"Upload Class Work":"Upload Home Work";
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:getTimeFormat(selectedDate) == getTimeFormat(DateTime.now())? floatingButton():null,
      body: myPadding(
          child: Column(
        children: [
          CommonHeader(
            title:title,
            hideStudentName: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  largeSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.subjectName}, ${widget.className},\n ${getTimeFormat(selectedDate)}",
                        style: CommonDecoration.subHeaderStyle.copyWith(fontSize: 17),
                      ),
                      SizedBox(width: 5,),
                      if(widget.student==true&& widget.fromClassWork==null && widget.fromHolidayWork==null)
                      InkWell(
                          onTap: (){
                          getTime().then((value){
                            selectedDate = value;
                            TeacherController()
                                .getClassHomeWorkBySubjectDate(
                                navigate: false,
                                date: selectedDate,
                                classMasterId: widget.classMasterId,
                                classSectionMasterId:
                                widget.classSectionMasterId,
                                subjectMasterId:widget.subjectMasterId).then((value){
                              GetClassHomeWorkBySubjectDateModel getClassHomeWorkBySubjectDateModel = value;

                              homeWorkController.text = getClassHomeWorkBySubjectDateModel.data!.homeWork.toString();
                                  widget.documents = getClassHomeWorkBySubjectDateModel.data!.documentsList!;
                              addDocuments();
                              FocusScope.of(context).requestFocus(new FocusNode());
                              setState(() {});
                            });


                          });
                          },
                          child: Icon(Icons.calendar_month,color: Colors.blue,))
                    ],
                  ),
                  smallSpace(),
                  MyTextFieldMulti(
                      hint:widget.fromHolidayWork==true?"Holiday Work": widget.fromClassWork==true?"Class Work":"Home Work",
                      inputType: TextInputType.multiline,
                      textEditingController: homeWorkController,
                      focusNode: homeWorkFocus,
                      borderColor: Colors.blue,
                      borderRadius: 10,
                      filled: widget.filled ?? false,
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
                        if (document.isActive == "false") {
                          return Container();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: InkWell(
                            onTap: () {
                              if(document.isLink!=true){
                                viewDocument(
                                    fileSource: document.fileSource,
                                    fromUrl: document.fromUrl);
                              }else if(document.isLink==true){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUs(link: document.fileSource,upperTitle: "Web View",)));
                              }
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
                                          ? PDFViewer(
                                              document: document.doc!,
                                            )
                                          : document.fromUrl
                                              ? Image.network(
                                                  document.fileSource)
                                              : Image.file(
                                                  File(document.fileSource)),
                                    ),
                                    if (document.fileSource.isNotEmpty &&
                                        widget.filled != true)
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            if (documentList[i].fromUrl) {
                                              documentList[i].isActive =
                                                  "false";
                                              setState(() {});
                                            } else {
                                              documentList.removeAt(i);
                                              setState(() {});
                                            }
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
    if (widget.filled ?? false) {
      return Container();
    }
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
              showMessage(msg: widget.fromClassWork==true?"Please enter class work title":"Please enter home work title");
              return;
            }

            if(widget.fromClassWork==true){
              TeacherController().saveClassWorkWithMultipleDocuments(
                filePath: fileSource,
                classHomeWorkId: widget.homeWorkId,
                rowVersion: widget.rowVersion,
                homeworkTitle: homeWorkController.value.text,
                homeworkDate: DateTime.now().toString(),
                classMasterId: widget.classMasterId,
                sectionMasterId: widget.classSectionMasterId,
                subjectMasterId: widget.subjectMasterId,
                documentName: fileSource.split("/").last,
                extensionWithName: fileSource.split("/").last,
                format: fileSource.split(".").last,
                documentSize: "23",
                documentList: documentList,
              );
              return;
            }
            for(int i=0;i<documentList.length;i++){
              myLog(label: "document url", value: documentList[i].fileSource);
            }
            TeacherController().uploadHomeWork(
              filePath: fileSource,
              classHomeWorkId: widget.homeWorkId,
              rowVersion: widget.rowVersion,
              homeworkTitle: homeWorkController.value.text,
              homeworkDate: DateTime.now().toString(),
              classMasterId: widget.classMasterId,
              sectionMasterId: widget.classSectionMasterId,
              subjectMasterId: widget.subjectMasterId,
              documentName: fileSource.split("/").last,
              extensionWithName: fileSource.split("/").last,
              format: fileSource.split(".").last,
              documentSize: "23",
              documentList: documentList,
            );
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
                              final file = File("${path.path}/${DateTime.now()}.pdf");
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
                          final file = File("${path.path}/${DateTime.now()}.pdf");
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



Widget _iconText({iconImage, title, onTab}) {
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

  String? documentFormat;
  String? documentName;
  String? fileUrl;
  String? id;
  String? isActive;
  String? isApproved;
  String? isLocked;
  String? isVideoFile;
  String? isYoutubeLink;
  bool? isLink;
  String fileSource = "";

  bool fromUrl;

  DocumentUpload(
      {required this.fileSource,
      this.doc,
      required this.fromUrl,
      this.documentFormat,
      this.documentName,
      this.fileUrl,
      this.id,
      this.isActive,
      this.isApproved,
      this.isLocked,
        this.isLink,
      this.isVideoFile,
      this.isYoutubeLink});
}

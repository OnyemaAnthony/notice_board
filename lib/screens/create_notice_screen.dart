import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notice_board/blocs/notice/notice_bloc.dart';
import 'package:notice_board/models/notice_model.dart';
import 'package:notice_board/repositories/notice_repository.dart';
import 'package:intl/intl.dart';
import 'package:notice_board/utilities.dart';
import 'package:notice_board/widgets/storage.dart';
import '../models/user_model.dart';

class CreateNoticeScreen extends StatefulWidget {
  const CreateNoticeScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoticeScreen> createState() => _CreateNoticeScreenState();
}

class _CreateNoticeScreenState extends State<CreateNoticeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late NoticeBloc noticeBloc;
  File? profilePicture;


  @override
  Widget build(BuildContext context) {
    UserModel? user = Storage.user;
    return BlocProvider(
      create: (context) => NoticeBloc(repository: NoticeRepository()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Create your Notice'),
        ),
        body: Builder(builder: (BuildContext context) {
          noticeBloc = BlocProvider.of<NoticeBloc>(context);
          return BlocConsumer<NoticeBloc, NoticeState>(
            listener: (context, state) {
              if (state is NoticeAddedState) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is NoticeLoadingState) {
                return Utilities.showCircularLoader('Saving your notice...');
              }
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    profilePicture != null?
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.file(
                        profilePicture!,
                        width: 90.0,
                        height: 90.0,
                        fit: BoxFit.cover,
                      ),
                    ):
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey,width: 1.5)
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.teal.withOpacity(0.5),
                        ),
                        onPressed: pickImage,
                        padding: const EdgeInsets.all(30.0),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.grey,
                        iconSize: 30.0,
                      ),
                    ),
                    TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Title',
                      ),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Description',
                      ),
                    ),
                    pickDate('Deadline'),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      child: const Text('Save notice'),
                      onPressed: () {
                        noticeBloc.add(CreateNoticeEvent(NoticeModel(
                          createdByFullName: '${user!.lastName} ${user.firstName}',
                            createdByPicture: user.imageURL,
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                            createdBy: user.id,
                            deadline: selectedDate,
                            isVisible: false,
                            title: titleController.text,
                            updatedAt: DateTime.now(),
                        ),profilePicture!));
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2022, 1, 1),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));

    setState(() {
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        deadlineController.text =
            DateFormat("EEE, MMM d, yyyy").format(selectedDate);
      }
    });
  }

  Container pickDate(String hint) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black45)),
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: hint,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              controller: deadlineController,
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
      ),
    );
  }
  Future pickImage() async {

    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        profilePicture = File(image.path);

      });
    }
  }
}

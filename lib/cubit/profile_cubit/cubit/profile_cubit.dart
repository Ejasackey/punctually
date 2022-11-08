import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:punctually/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Box profileBox;
  ProfileCubit({required this.profileBox}) : super(ProfileInitial()) {
    getProfile();
  }

  final String _nameKey = "name";
  final String _portfolioKey = "portfolio";
  final String _departmentKey = "department";
  final String _profileUrlKey = "profileUrl";

  getProfile() {
    User user = User();
    user.name = profileBox.get(_nameKey, defaultValue: "");
    user.portfolio = profileBox.get(_portfolioKey, defaultValue: "");
    user.department = profileBox.get(_departmentKey, defaultValue: "");
    user.profileUrl = profileBox.get(_profileUrlKey, defaultValue: "");
    emit(ProfileLoaded(user: user));
  }

  saveProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileBox.put(_profileUrlKey, image.path);
      getProfile();
    }
  }

  saveProfileDetails(User user) async {
    profileBox.put(_nameKey, user.name);
    profileBox.put(_departmentKey, user.department);
    profileBox.put(_portfolioKey, user.portfolio);
    getProfile();
  }
}

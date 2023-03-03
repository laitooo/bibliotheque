import 'package:bibliotheque/blocs/profile_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Info'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProfileBloc()..add(LoadProfile()),
          ),
          // BlocProvider(
          //   create: (_) => ProfilePictureBloc(),
          // )
        ],
        child: _Body(),
      ),
    );
  }
}

class _ProfileInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _ProfileInfoItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.theme.textColor1,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 55,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: context.theme.dividerColor),
            ),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  value,
                  style: TextStyle(
                    color: context.theme.textColor1,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePhoneNumber extends StatelessWidget {
  final String title;
  final String value;
  final countryCode = '+249';

  const _ProfilePhoneNumber({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.theme.textColor1,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 55,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: context.theme.dividerColor),
                  ),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            value.split(countryCode)[1],
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: context.theme.textColor1,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      _buildCountryCode(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryCode(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(
          //   'assets/images/qatar.png',
          //   width: 24.0,
          //   height: 24.0,
          // ),
          const SizedBox(width: 6.0),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              countryCode,
              style: TextStyle(color: context.theme.input.hintColor),
            ),
          ),
          const SizedBox(width: 6.0),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.input.borderColor,
            ),
            child: const SizedBox(width: 1, height: double.infinity),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state.status == ProfileStatus.loading) {
        return const Center(
          child: AppProgressIndicator(),
        );
      }

      if (state.status == ProfileStatus.error) {
        return TryAgainWidget(
          onPressed: () {
            BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
          },
        );
      }

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleImageWidget(
              state.profile!.avatarUrl,
              size: 130,
            ),
          ),
          const SizedBox(height: 15),
          Divider(
            thickness: 0.5,
            color: context.theme.dividerColor,
          ),
          const SizedBox(height: 15),
          _ProfileInfoItem(
            title: "Full Name",
            value: state.profile!.fullName,
          ),
          const SizedBox(height: 15),
          _ProfileInfoItem(
            title: "Username",
            value: state.profile!.username,
          ),
          const SizedBox(height: 20),
          _ProfileInfoItem(
            title: "Email",
            value: state.profile!.email,
          ),
          const SizedBox(height: 20),
          _ProfilePhoneNumber(
            title: "Phone number",
            value: state.profile!.phoneNumber,
          ),
        ],
      );
    });
  }
}

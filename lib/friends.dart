import 'package:exer5/drawer.dart';
import 'form.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  final List friendsList;
  const FriendsList(this.friendsList, {super.key});
  static const routename = '/';

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;

    if(widget.friendsList.isEmpty){
      bodyWidget = NoFriendsWidget(widget.friendsList);
    }else{
      bodyWidget = WithFriends(widget.friendsList);
    }

    return Scaffold(
        drawer: DrawerWidget(widget.friendsList),
        appBar: AppBar(
          title: const Text("Friends", style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromARGB(255, 8, 3, 255),
        ),
        body: bodyWidget
      );
  }
}

class NoFriendsWidget extends StatelessWidget {
  final List friendsList;
  const NoFriendsWidget(this.friendsList, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.people),
          const Text("No friends added yet."),
          ElevatedButton(
            child: const Text("Go to Slambook"),
            onPressed: (){
              Navigator.pushNamed(context, SlambookForm.routename, arguments: friendsList);
            },
          )
        ],
      ),
    );
  }
}

class WithFriends extends StatefulWidget {
  final List friendsList;
  const WithFriends(this.friendsList, {super.key});

  @override
  State<WithFriends> createState() => WithFriendsState();
}

class WithFriendsState extends State<WithFriends> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: widget.friendsList.length,
      itemBuilder: (context, index) {
        FormAnswers friend = widget.friendsList[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 100,
            width: 100,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                const SizedBox(width: 5,),
                Text(friend.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 8, 3, 255)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendSummary(friend)));
                  },
                  child: const Text("View Details")
                ),
                const SizedBox(width: 5)
              ],)
            ),
          ),
        );
      }
    );
  }
}

class FriendSummary extends StatelessWidget {
  final FormAnswers friend;
  const FriendSummary(this.friend, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(friend.nickname, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 8, 3, 255),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 5,),
          const Text("Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 20,),
          friend.getValues(),
          const SizedBox(height: 100),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Back")),
        ],)
      )
    );
  }
}
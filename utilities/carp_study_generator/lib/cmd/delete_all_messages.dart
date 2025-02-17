part of carp_study_generator;

class DeleteAllMessagesCommand extends AbstractCommand {
  DeleteAllMessagesCommand() : super();

  @override
  Future execute() async {
    await authenticate();
    await CarpResourceManager().deleteAllMessages();
    print("All messages deleted");
  }
}

public class MergeDuplicateContactQue implements Queueable {
    public void execute(QueueableContext context) {
        if (!ContactHandler.isMerging) {
            Database.ExecuteBatch(new BatchMergeDuplicateContact('trigger'), 1);
        }
    }
}
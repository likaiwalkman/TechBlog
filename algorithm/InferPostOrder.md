```java
public class InferPostOrder {

  public Node build(int[] pre, int[] mid, int preStart, int preEnd, int midStart, int midEnd){

    int root = pre[preStart];
    Node rootNode = new Node();
    rootNode.val = root;

    int partitionIndex = midStart;
    for(int i = midStart; i < midEnd; i++) {
      if (mid[i] == root){
        partitionIndex = i;
        break;
      }
    }
    if (partitionIndex > midStart){
      Node left = build(pre, mid,
          preStart + 1, preStart + partitionIndex-midStart,
          midStart, partitionIndex-1
      );
      rootNode.left = left;
      System.out.println();
    }
    if (partitionIndex < midEnd){
      Node right = build(pre, mid,
          preEnd-midEnd+partitionIndex+1, preEnd,
          partitionIndex + 1, midEnd

      );
      rootNode.right = right;
      System.out.println();
    }
    return rootNode;
  }

  public static void main(String[] args) {
    Node root;
    root = new InferPostOrder()
        .build(
            new int[]{1, 2, 4, 7, 3, 5, 6, 8},
            new int[]{4, 7, 2, 1, 5, 3, 8, 6},
            0, 7,
            0,7
        );
    System.out.println(root);
  }
}

class Node {
  public int val;

  public Node left;
  public Node right;
}

```

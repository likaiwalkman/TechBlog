```java
//One-pass Hash Table

public int[] twoSum(int[] nums, int target) {
  HashMap<Integer, Integer> reversedIndex = new HashMap<>();
  int len = nums.length;
  for (int i = 0; i < len; i++) {
    int complement = target - nums[i];
    if (reversedIndex.containsKey(complement)) {
      int formerIndex = reversedIndex.get(complement);
      return new int[]{formerIndex, i};
    }
    reversedIndex.put(nums[i], i);
  }
  return null;
}
```

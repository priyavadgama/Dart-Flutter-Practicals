/// Practical 13:
/// Create a Set of unique hobbies for yourself and one friend (combine into separate sets),
/// then demonstrate union, intersection, and difference operations on these two sets.

void main() {
  print('=== Practical 13: Set Operations on Hobbies ===\n');

  // Set of hobbies for myself (Priya)
  Set<String> myHobbies = {
    'Coding',
    'Gaming',
    'Reading',
    'Photography',
    'Traveling',
  };

  // Set of hobbies for a friend (Alex)
  Set<String> friendHobbies = {
    'Gaming',
    'Music',
    'Traveling',
    'Cooking',
    'Drawing',
  };

  print('My Hobbies: $myHobbies');
  print('Friend\'s Hobbies: $friendHobbies');
  print('--------------------------------------------------');

  // 1. Union: All unique hobbies combined
  Set<String> allHobbies = myHobbies.union(friendHobbies);
  print('\n1. Union (All combined unique hobbies):');
  print(allHobbies);

  // 2. Intersection: Common hobbies shared by both
  Set<String> commonHobbies = myHobbies.intersection(friendHobbies);
  print('\n2. Intersection (Common hobbies shared by both):');
  print(commonHobbies);

  // 3. Difference (My hobbies not in friend's hobbies)
  Set<String> myExclusiveHobbies = myHobbies.difference(friendHobbies);
  print('\n3. Difference (My hobbies not shared with friend):');
  print(myExclusiveHobbies);

  // 4. Difference (Friend's hobbies not in my hobbies)
  Set<String> friendExclusiveHobbies = friendHobbies.difference(myHobbies);
  print('\n4. Difference (Friend\'s hobbies not shared with me):');
  print(friendExclusiveHobbies);
}

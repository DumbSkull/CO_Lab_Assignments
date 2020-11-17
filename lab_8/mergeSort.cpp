#include <bits/stdc++.h>
using namespace std;

void merge(vector<int> &a, int left, int mid, int right)
{
  vector<int> leftVector;
  vector<int> rightVector;

  for (int i = left; i <= mid; i++)
    leftVector.push_back(a[i]);

  for (int i = mid + 1; i <= right; i++)
    rightVector.push_back(a[i]);

  int countLeft = 0;
  int countRight = 0;
  int countMain = left;

  while (countLeft < leftVector.size() && countRight < rightVector.size())
  {
    if (leftVector[countLeft] <= rightVector[countRight])
      a[countMain++] = leftVector[countLeft++];

    if (leftVector[countLeft] > rightVector[countRight])
      a[countMain++] = rightVector[countRight++];
  }

  while (countLeft < leftVector.size())
    a[countMain++] = leftVector[countLeft++];

  while (countRight < rightVector.size())
    a[countMain++] = rightVector[countRight++];
}

void mergeSort(vector<int> &a, int left, int right)
{
  if (left < right)
  {
    int mid = (left + right) / 2;
    mergeSort(a, left, mid);
    mergeSort(a, mid + 1, right);
    merge(a, left, mid, right);
  }
}

int main()
{
  vector<int> arr;
  int n;

  cout << "\nEnter the number of elements in the array: ";
  cin >> n;

  cout << "\nEnter the elements in the array: ";
  for (int i = 0; i < n; i++)
  {
    int el;
    cin >> el;
    arr.push_back(el);
  }

  // vector<int> arr{3, 5, 7, 1, 4, 9};

  mergeSort(arr, 0, (arr.size() - 1));

  cout << "\nSorted array: ";
  for (auto el : arr)
    cout << el << " ";

  return 0;
}

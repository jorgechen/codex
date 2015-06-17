import java.util.*;

public class MergeSorter {

   public static void mergeSort(int[] a, int start, int end) {
      int length = end - start;

      if (length < 2) {
         //ignore
      }
      else {
         int midpoint = length / 2;
         mergeSort(a, start, midpoint);
         mergeSort(a, midpoint, end);
         merge(a, start, midpoint, end);
      }
   }

   public static void merge(int[] a, int start, int midpoint, int end) {
      int i = start;
      int j = midpoint;
      while ( i < midpoint ) {

         // TODO fix this, in-place merge is difficult, could become O(N^2)


         if ( a[i] < a[j] ) {
            // swap i and j
            int swap = a[i];
            a[i] = a[j];
            a[j] = swap;
         }
         i++;
      }
   }

   public static void main(String[] args) {
      ArrayList<int[]> cases = new ArrayList<int[]>();

      cases.add( new int[] {1});

      int[] testCase = new int[] {1,2,3,5,423,6,7123,6};

      mergeSort(testCase, 0, testCase.length);

      for (int i = 0; i < testCase.length; i++) {
         System.out.print(testCase[i] + " ");
      }

   }
}

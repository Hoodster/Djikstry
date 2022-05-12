using System;
using System.Runtime.InteropServices;

namespace Lab3Asm
{
    class Program
    {
        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe int ExercOne();
        static void Main(string[] args)
        {
            unsafe
            {
                int[] inputData = new int[]{ 1, 2, 3, 4, 5 };
                fixed(int* inputPos = &inputData[0])
                {
                    var result = ExercOne();
                    Console.WriteLine(result);
                }
            }
        }
    }
}

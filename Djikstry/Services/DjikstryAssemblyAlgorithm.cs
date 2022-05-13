using DjikstryCSHarp;
using System;
using System.Runtime.InteropServices;

namespace Djikstry.Services
{
    public struct NodeAssembly
    {
        public int Distance;
        public int isPristine;
        public int Predecessor;
    }
    public class DjikstryAssemblyAlgorithm
    {
        public void WrapSolve()
        {
            uint[] exercOneData = new uint[20] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
            var tab1 = new float[16] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 };
            var tab2 = new float[16] { 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17 };
            var result = new float[16];
          //  int[] splashedMatrix = SplashMatrix(matrix, size * size);
            
            unsafe
            {
                fixed (uint* exercOneDataAddr = &exercOneData[0])
                {
                    fixed (float* tab1Addr = &tab1[0])
                    {
                        fixed (float* tab2Addr = &tab2[0])
                        {
                            fixed (float* resultAddr = &result[0])
                            {
                              //  var resultOne = ExercOne(exercOneDataAddr);
                                exercTwo(tab1Addr, tab2Addr, resultAddr);
                                
                                //Console.WriteLine("\n /======== Zadanie 1 \n");
                                //Console.WriteLine("Tablica wejciowa: \n " + exercOneData);
                                //Console.WriteLine("\n Wynik: \n");
                                //Console.WriteLine((int)resultOne);

                                Console.WriteLine("\n /======== Zadanie 1 \n");
                                Console.WriteLine("Tablica wejciowa nr1 \n " + tab1);
                                Console.WriteLine("Tablica wejciowa nr1 \n " + tab2);
                                Console.WriteLine("\n Wynik: " + result);
                            }
                        }
                    }
                }
            }
        }

        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe uint* exercOne(uint* input);
        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe void exercTwo(float* tab1, float* tab2, float* results);
    }
}

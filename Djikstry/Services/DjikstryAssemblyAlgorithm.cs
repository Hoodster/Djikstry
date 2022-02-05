using DjikstryCSHarp;
using System.Runtime.InteropServices;

namespace Djikstry.Services
{
    public class DjikstryAssemblyAlgorithm
    {
        public Node[] WrapSolve(int[,] matrix, int startPosition)
        {
            unsafe
            {
                fixed (int* matrix_ptr = &matrix[0,0])
                {
                    return Solve(matrix_ptr, startPosition);
                }
            }
        }

        [DllImport("DjikstryAssembly.dll")]
        private static extern unsafe Node[] Solve(int* matrix, int startPosition);
    }
}

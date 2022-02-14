using DjikstryCSHarp;
using System.Runtime.InteropServices;

namespace Djikstry.Services
{
    public struct NodeAssembly
    {
        public int Distance;
        public int Predecessor;
        public int isPristine;
    }
    public class DjikstryAssemblyAlgorithm
    {
        public int WrapSolve()
        {
            var nodes = new NodeAssembly[6];
            int[,] graph= new int[6,6] {
                { 0, 1, 2, 0, 0, 0},
        { 1, 0, 0, 5, 1, 0},
        { 2, 0, 0, 2, 3, 0},
        { 0, 5, 2, 0, 2, 2},
        { 0, 1, 3, 2, 0, 1},
        { 0, 0, 0, 2, 1, 0}
            };
            unsafe
            {
                fixed (int* matrixAddress = &graph[0,0])
                {
                    fixed (NodeAssembly* nodesAddress = &nodes[0])
                    {
                        int* result = djikstryAssembly(matrixAddress, nodesAddress, 6, 0);

                        return 1;
                    }
                }
            }
        }

        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe int* djikstryAssembly(int* matrix, NodeAssembly* nodes, int size, int startPosition);
    }
}

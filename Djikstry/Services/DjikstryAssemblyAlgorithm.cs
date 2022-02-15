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
        public Node[] WrapSolve(int[,] matrix, int size, int startingPoint)
        {
            var nodes = new Node[size];
            var nodesAssembly = new NodeAssembly[6];
            
            unsafe
            {
                fixed (int* matrixAddress = &matrix[0,0])
                {
                    fixed (NodeAssembly* nodesAddress = &nodesAssembly[0])
                    {
                        
                        int* result = djikstryAssembly(matrixAddress, nodesAddress, size, startingPoint);
                        for (int i = 0; i < size; i++)
                        {
                            var node = new Node
                            {
                                Distance = nodesAddress[i].Distance,
                                IsPristine = (nodesAddress[i].isPristine == 0) ? false : true,
                                Predeccessor = nodesAddress[i].Predecessor
                            };
                            nodes[i] = node;
                        }
                        return nodes;
                    }
                }
            }
        }

        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe int* djikstryAssembly(int* matrix, NodeAssembly* nodes, int size, int startPosition);
    }
}

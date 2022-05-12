using DjikstryCSHarp;
using System;
using System.Runtime.InteropServices;

namespace Djikstry.Services
{
    public class DjikstryAssemblyAlgorithm
    {
        public void WrapSolve(InputData data, out float[] results)
        {
            var tempResults = new float[4];
            results = new float[4];
            unsafe
            {
                fixed (float* x1Addr = &data.X1[0])
                {
                    fixed (float* x2Addr = &data.X2[0])
                    {
                        fixed (float* tempResAddr = &tempResults[0])
                        {

                            var test = djikstryAssembly(x1Addr, x2Addr, tempResAddr, data.OperationType);
                            for (int i = 0; i < 4; i++)
                            {
                                results[i] = (float)tempResAddr[i];
                            }
                        }
                    }
                }
            }
        }

        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe float* djikstryAssembly(float* x1, float* x2, float* resAddress, int type);
    }
}

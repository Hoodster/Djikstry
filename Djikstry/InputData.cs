using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Djikstry
{
    public class InputData
    {
        public float[] X1 { get; set; } 
        public float[] X2 { get; set; }
        public int OperationType { get; set; }

        public InputData(float[] x1, float[] x2, int operationType)
        {
            X1 = x1;
            X2 = x2;
            OperationType = operationType;
        }
    }
}

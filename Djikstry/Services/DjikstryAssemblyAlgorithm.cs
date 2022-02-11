using DjikstryCSHarp;
using System.Runtime.InteropServices;

namespace Djikstry.Services
{
    public class DjikstryAssemblyAlgorithm
    {
        public int WrapSolve()
        {
            unsafe
            {
                return mojaFunkcjaAsm();
            }
        }

        [DllImport("DjikstryAsm.dll")]
        private static extern unsafe int mojaFunkcjaAsm();
    }
}

using System;

namespace DjikstryCSHarp
{
    public struct Node
    {
        public int Distance { get; set; }
        public int Predeccessor { get; set; }
        public bool IsPristine { get; set; }
    }
}

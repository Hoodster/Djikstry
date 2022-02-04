using System;

namespace DjikstryCSHarp
{
    public class Node
    {
        public int Distance { get; set; }
        public int Predeccessor { get; set; }
        public bool IsPristine { get; set; }
    }
}

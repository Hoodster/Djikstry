namespace DjikstryCSHarp
{
    public class DjikstryAlgorithm
    {
        public static Node[] Solve(int[,] matrix, int startPosition)
        {
            var tab = new Node[matrix.GetLength(0)];
            for (int i = 0; i < matrix.GetLength(0); i++)
            {
                tab[i].Distance = (i == startPosition) ? 0 : int.MaxValue;
                tab[i].IsPristine = false;
                tab[i].Predeccessor = -1;
            }
            int u = startPosition;
            while (u != -1)
            {
                tab[u].IsPristine = true;
                for (int i = 0; i < matrix.GetLength(0); i++)
                {
                    if (matrix[u, i] > 0 && tab[u].Distance + matrix[u, i] < tab[i].Distance)
                    {
                        tab[i].Distance = tab[u].Distance + matrix[u, i];
                        tab[i].Predeccessor = u;
                    }
                }
                u = FindMinimal(ref tab);
            }
            return tab;
        }
        private static int FindMinimal(ref Node[] tab)
        {
            int min = -1;
            int mindist = int.MaxValue;
            for (int i = 0; i < tab.Length; i++)
            {
                if (!tab[i].IsPristine && tab[i].Distance < mindist)
                {
                    min = i;
                    mindist = tab[i].Distance;
                }
            }
            return min;
        }
    }
}

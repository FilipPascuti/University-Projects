#include <stdio.h>
#include <stdlib.h>

int main()
{
    int x = 0, sign = 0, k =0;
    int result[100]={};
    char s[255];
    scanf("%s", s);
    for(int i=0;i<strlen(s);i++)
    {
        if(s[i] == ',')
        {
            if(sign == 1)
                {
                    x = 0 - x;
                    result[k] = x;
                }
            else
                result[k] = x;
            k++;
            sign = 0;
            x = 0;
        }
        if(s[i] == '-')
            sign = 1;
        if(s[i]>= '0' && s[i]<='9')
            s[i] = s[i] - 48;
            if(x != 0)
                x = x * 10 + s[i];
            else
                x = s[i];
    }
    if(sign == 1)
    {
        x = 0 - x;
        result[k] = x;
    }
    else
        result[k] = x;
    k++;
    for(int i=0;i<k;i++)
        printf("%d  ", result[i]);
    return 0;
}

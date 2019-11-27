#include <stdio.h>
#include <string.h>

int main (void) {
    char age[BUFSIZ],height[BUFSIZ], weight[BUFSIZ];
    printf("How old are you?\n");
    fgets(age, BUFSIZ, stdin); 
    int len_a=strlen(age); //where buff is your char array fgets is using
    if(age[len_a-1]=='\n')
        age[len_a-1]='\0';
    
    printf("How tall are you?\n");
    fgets(height, BUFSIZ, stdin); 
    int len_b=strlen(height); //where buff is your char array fgets is using
    if(height[len_b-1]=='\n')
        height[len_b-1]='\0';

    printf("How much do you weigh?\n");
    fgets(weight, BUFSIZ, stdin); 
    int len=strlen(weight); //where buff is your char array fgets is using
    if(weight[len-1]=='\n')
        weight[len-1]='\0';  

    printf("So, you're %s years old, %s tall, and weigh %s lbs.\n", age, height, weight); 
    return 0; 
}

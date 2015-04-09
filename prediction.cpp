#include <stdio.h>
#include <stdlib.h>
#include <iostream>

using namespace std;

#define alpha 0.001;
#define ITER 10000;

//long long int * days[8];
long long int index[8];

typedef std::vector<long long int> V;

std::vector<V> days;

V theta0(8,1);
V theta1(8,1);
double cost[8];

int main(){
	long long int i,n,d,c,pos,size,k,x;
	double co,h;
	cin>>n;



	for(i=1;i<=n;i++){
		scanf("%lld,%lld",&d,&c);
		index[d]++;
		days[d].push_back(c);
	}

	for(i=1;i<=ITER;i++){
		for(j=1;j<=7;j++){
			size=V[j].size();
			co=0;
			for(k=0;k<size;k++){
				x=k+1;
				h=theta0[j]+x*theta1[j];
				y=days[j][k];
				co+=(h-y)*(h-y);
			}
			cost[j]=co/(2*size);
			for(k=0;k<size;k++){
				x=k+1;
				h=theta0[j]+x*theta1[j];
				y=days[j][k];
				theta0[j]-=(alpha*(h-y))/size;
				theta1[j]-=(alpha*(h-y)*x)/size
			}
		}
	}
	cout<<"35\n";
	for (i = 1; i <= 5;i++)
	{
		for(j=1;j<=7;j++){
			size=V[j].size();
			x=size+i;
			h=theta0[j]+x*theta1[j];
			cout<<j<<","<<h<<endl;
		}
	}
	return 0;
}
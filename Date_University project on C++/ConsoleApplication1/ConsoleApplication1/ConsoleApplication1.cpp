
#include "stdafx.h"
#include <iostream> 

using namespace std;

int _tmain(int argc, _TCHAR* argv[])
{
	int mes[12] = { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334 }, m, d;
	do
	{
	std::cout << "Enter noumber of mounth: ";
	std::cin >> m;
	std::cout << "Enter day: ";
	std::cin >> d;
	int Day = (mes[m] + d);
	if (m < 1 || d > 31 || m > 31 || d < 1)
	{
		std::cout << "Erorr 404" << std::endl;
	}
	else
	switch (Day %7)
		{
		case 0: std::cout << "Monday" << std::endl; break;
		case 1: std::cout << "Tousday" << std::endl; break;
		case 2: std::cout << "Wensday" << std::endl; break;
		case 3: std::cout << "Foursday" << std::endl; break;
		case 4: std::cout << "Fryday" << std::endl; break;
		case 5: std::cout << "Sunday" << std::endl; break;
		case 6: std::cout << "Sutterday" << std::endl; break;
		}
	} while (m != 777);
	return 0;
}
#include <cstdio>
#include <vector>
#include <set>

#include <string.h>

/**
 * functor compare
 */
struct compare {
	bool operator() (const char* a, const char *b)
	{
		return (strcmp (a, b) < 0);
	}
};

/**
 * main
 */
int main (int argc, char *argv[])
{
	std::vector<const char *> list = { "strawberry", "apple", "olive", "kumquat", "tangerine", "fig", "banana", "papaya", "raspberry", "nectarine", "hawthorn", "guava", "wolfberry", "vanilla", "lemon", "yew", "xigua", "ilama", "damson", "quince", "mango", "ziziphus", "ugli", "jackfruit", "cherry", "elderberry" };

	std::set<const char*, compare> sorted;

	for (auto f : list) {
		sorted.insert(strdup (f));
	}

	for (auto f : sorted) {
		printf ("%s\n", f);
	}

	return 0;
}


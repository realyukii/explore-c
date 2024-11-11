#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// description: search a string with binary search tree.

struct BinaryTreeNode {
  char *key;
  struct BinaryTreeNode *left, *right;
};

// a search target
char *str = "hello";

struct BinaryTreeNode *initNode(char *value);
struct BinaryTreeNode *insertNode(struct BinaryTreeNode *node, char *value);
struct BinaryTreeNode *searchNode(struct BinaryTreeNode *root, char *target);

int main(void)
{
	struct BinaryTreeNode *root = NULL;
	// a tree will be created based on this array of string
	char *array[] = {"first", "second", "whoa", "wushh", "lorem ipsum dolor sit", "hello", "amet what need to wrote here", "no idea what, let's just do it", "alright then"};
	int array_len = sizeof(array) / sizeof(array[0]);

	for (int i = 0; i < array_len; i++) {
		if (root == NULL) root = insertNode(root, array[i]);
		else insertNode(root, array[i]);
	}

	if (searchNode(root, str) != NULL) {
		printf("String %s was found!\n", str);
	} else {
		printf("String %s was not found!\n", str);
	}

	return 0;
}

struct BinaryTreeNode *createNode(char *value)
{
	struct BinaryTreeNode *root = malloc(sizeof(*root));
	if (root == NULL) {
		puts("Not enough memory!");
		exit(EXIT_FAILURE);
	}

	root->key = value;
	root->left = root->right = NULL;

	return root;
}

struct BinaryTreeNode *insertNode(struct BinaryTreeNode *node, char *value)
{
	int ret;

	if (node == NULL) {
		return createNode(value);
	}
	
	ret = strcmp(value, node->key);
	// value greater than current visited node
	if (ret > 0) {
		node->right = insertNode(node->right, value);
	} else {
		node->left = insertNode(node->left, value);
	}

	return node;
}

struct BinaryTreeNode *searchNode(struct BinaryTreeNode *root, char *target)
{
	int ret = strcmp(target, root->key);

	if (root == NULL || ret == 0) {
		return root;
	} else if (ret > 0) {
		return searchNode(root->right, target);
	} else {
		return searchNode(root->left, target);
	}
}


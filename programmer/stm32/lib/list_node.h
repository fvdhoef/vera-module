/**
 * @file
 */

/**
 * @defgroup listnode List node
 * @ingroup lib
 * @brief Generic doubly linked list node structure
 * @{
 */

#pragma once

#include "common.h"

/**
 * @brief   List node structure
 */
struct list_node {
    struct list_node *prev; ///< Pointer to previous list node
    struct list_node *next; ///< Pointer to next list node
};

/**
 * @brief      Define and initialize list node (static)
 *
 * @param      name  Name of list node
 */
#define LIST_NODE(name) static struct list_node name = {.prev = &name, .next = &name}

/**
 * @brief      Define and initialize list node (non-static)
 *
 * @param      name  Name of list node
 */
#define LIST_NODE_NONSTATIC(name) struct list_node name = {.prev = &name, .next = &name}

/**
 * @brief      Initialize list node
 *
 * @param      node  The node
 */
static inline void list_node_init(struct list_node *node) {
    node->prev = node;
    node->next = node;
}

/**
 * @brief      Remove this node from the list it may be in.
 *
 * @param      node  The node
 */
static inline void list_node_remove(struct list_node *node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;

    node->prev = node;
    node->next = node;
}

/**
 * @brief      Insert node after prev_node.
 *
 * @param      node       The node
 * @param      prev_node  The previous node
 */
static inline void list_node_insert(struct list_node *node, struct list_node *prev_node) {
    node->next = prev_node->next;
    node->prev = prev_node;

    prev_node->next->prev = node;
    prev_node->next       = node;
}

/**
 * @brief      Determines if node is unlinked.
 *
 * @param      node  The node
 *
 * @return     true is node is not linked in a list, false otherwise
 */
static inline bool list_node_is_empty(struct list_node *node) {
    return (node == node->next);
}

/**
 * @brief      Determines number of nodes in list.
 *
 * @param      node  The node
 *
 * @return     Number of nodes in this list.
 */
static inline uint32_t list_node_count(struct list_node *node) {
    uint32_t          count     = 0;
    struct list_node *next_node = node->next;
    while (next_node != node) {
        count++;
        next_node = next_node->next;
    }
    return count;
}

/**
 * @brief      Get node by index.
 *
 * @param      list   The list
 * @param      index  The index
 *
 * @return     Node at index. Returns NULL if indexed beyond end of list.
 */
static inline struct list_node *list_node_get_by_index(struct list_node *list, uint32_t index) {
    struct list_node *node = list;
    do {
        if (node->next == list) {
            node = NULL;
        } else {
            node = node->next;
        }
    } while (node && index--);

    return node;
}

/**
 * @brief      Iterate over list
 *
 * @param      list     The list
 * @param      type     The type
 * @param      ce_name  Name of struct list_node in object
 * @param      objname  Name of object
 *
 * @return     { description_of_the_return_value }
 */
#define LIST_ITERATE(list, type, ce_name, objname)                                                                  \
    for (struct list_node *_iterNode_##objname = (list).next, *_iterNodeNext_##objname = _iterNode_##objname->next; \
         _iterNode_##objname != &(list);                                                                            \
         _iterNode_##objname = _iterNodeNext_##objname, _iterNodeNext_##objname = _iterNodeNext_##objname->next) {  \
        type *objname = GET_CONTAINER_OF(_iterNode_##objname, type, ce_name);

/**
 * @brief      Iterate over list (end tag)
 */
#define LIST_ITERATE_END }

/**
 * @brief      Gets the container of specified pointer
 *
 * @param      ptr      The pointer
 * @param      c_type   Type of structure this pointer a member of.
 * @param      ce_name  Name of member in structure.
 *
 * @return     Pointer to structure the specified pointer is a member of.
 */
#define GET_CONTAINER_OF(ptr, c_type, ce_name) ((c_type *)((uintptr_t)(ptr) - (uintptr_t)(&((c_type *)0)->ce_name)))

/** @} */

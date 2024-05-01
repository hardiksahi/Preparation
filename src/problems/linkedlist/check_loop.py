# from datastructures.ListNode import ListNode
from typing import Optional, Union, List, Dict
from datastructures.LinkedList import LinkedList, populate_list
from datastructures.CircularLinkedList import CircularLinkedList

Numeric = Union[float, int]


def check_loop(list: Union[LinkedList, CircularLinkedList]) -> bool:
    if list.count_elements() == 0:
        return False
    else:
        slow = list.head
        fast = list.head.next

        ##O(n)
        while True:
            if fast is None or fast.next is None or fast == slow:
                break
            slow = slow.next
            fast = fast.next.next

        if fast == slow:
            return True
        else:
            return False


def find_loop_start(list: Union[LinkedList, CircularLinkedList]) -> Optional[Numeric]:
    if list.count_elements() == 0:
        raise Exception("No element in the list")
    else:
        slow = list.head
        fast = list.head.next

        while True:
            if fast is None or fast.next is None or fast == slow:
                break
            slow = slow.next
            fast = fast.next.next

        if slow == fast:
            slow = list.head
            while fast.next != slow:
                slow = slow.next
                fast = fast.next

            return slow.val
        else:
            return None


def check_loop_other(list: Union[LinkedList, CircularLinkedList]) -> bool:
    if list.count_elements() == 0:
        return False
    else:
        slow = list.head
        fast = list.head.next

        while slow is not None and fast is not None and fast.next is not None:
            slow = slow.next
            fast = fast.next.next

            if slow == fast:
                return True

        return False


if __name__ == "__main__":
    list_elements = [1, 2, 3, 4, 5, 6]
    l1 = populate_list(list_elements)
    print(f"Is there loop in l1: {check_loop_other(l1)}")
    print(f"Start of loop in l1: {find_loop_start(l1)}")

    ## Create looped LL
    looped_list_elements = [100, 200, 300, 400, 500, 600]
    # l2 = populate_list(looped_list_elements)
    # l2.display_elements()
    # loop_start_node = l2.head.next.next
    # current = l2.head
    # while current.next is not None:
    #     current = current.next
    # current.next = loop_start_node
    l2 = CircularLinkedList()
    l2.populate_list(looped_list_elements, mode="end")
    print(f"Is there loop in l2: {check_loop_other(l2)}")
    print(f"Start of loop in l2: {find_loop_start(l2)}")

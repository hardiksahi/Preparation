from datastructures.ListNode import ListNode
from typing import Optional, Union, List, Dict

Numeric = Union[float, int]


class CircularLinkedList:
    def __init__(self, head=Union[None, ListNode], tail=Union[None, ListNode]):
        self.head = head
        self.tail = tail
        self.element_count = 0

    def insert_at_beginning(self, val):
        node = ListNode(val)
        if self.element_count == 0:
            self.head = node
            self.tail = node
            self.head.next = node
            self.element_count += 1
        else:
            node.next = self.head
            self.head = node
            self.tail.next = self.head
            self.element_count += 1

    def insert_at_end(self, val):
        node = ListNode(val)
        if self.element_count == 0:
            self.head = node
            self.tail = node
            self.head.next = node
            self.element_count += 1
        else:
            node.next = self.head
            self.tail.next = node
            self.tail = node
            self.element_count += 1

    def insert_at_position(self, val, pos):
        if pos > self.element_count + 1:
            raise Exception(
                f"There are only {self.element_count} elements in list. Cannot insert at {pos}"
            )
        if pos == 1:
            self.insert_at_beginning()
        elif pos == self.element_count + 1:
            self.insert_at_end()
        else:
            node = ListNode(val)
            current = self.head
            prev = None
            steps = 1
            while steps < pos:
                prev = current
                current = current.next
                steps += 1
            prev.next = node
            node.next = current
            self.element_count += 1

    def populate_list(self, element_list, mode="begin"):
        fn = self.insert_at_beginning if mode == "begin" else self.insert_at_end
        for element in element_list:
            fn(element)

    def traverse_list(self) -> List[Numeric]:
        if self.element_count == 0:
            raise Exception("There is no element in the list")
        return_list = []
        current = self.head
        while current != self.tail:
            return_list.append(current.val)
            current = current.next
        return_list.append(current.val)

        return return_list

    def count_elements(self):
        return self.element_count


if __name__ == "__main__":
    element_list = [10, 20, 30, 40, 50, 60]
    l1 = CircularLinkedList()
    l1.populate_list(element_list, mode="begin")
    print(f"Elements in l1: {l1.traverse_list()}")
    print(f"Count of Elements in l1: {l1.element_count}")

    l2 = CircularLinkedList()
    l2.populate_list(element_list, mode="end")
    print(f"Elements in l2: {l2.traverse_list()}")
    print(f"Count of Elements in l2: {l2.element_count}")

from typing import Optional, Union, List, Dict

Numeric = Union[float, int]


class DoublyListNode:
    def __init__(self, val, next=None, prev=None):
        self.val = val
        self.next = next
        self.prev = prev


class DoublyLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
        self.element_count = 0

    def insert_at_beginning(self, val):
        node = DoublyListNode(val)
        if self.head is None:
            self.head = node
            self.tail = node
            self.element_count += 1
        else:
            node.next = self.head
            self.head.prev = node
            self.head = node
            self.element_count += 1

    def insert_at_end(self, val):
        node = DoublyListNode(val)
        if self.head is None:
            self.head = node
            self.tail = node
            self.element_count += 1
        else:
            ## Case: Do not keep track of tail
            # current = self.head
            # while current.next is not None:
            #     current = current.next
            # current.next = node
            # node.prev = current
            # self.tail = node
            # self.element_count+=1

            ## Case: Keep track of tail
            self.tail.next = node
            node.prev = self.tail
            self.tail = node
            self.element_count += 1

    def insert_at_location(self, val, loc):
        if loc > self.element_count + 1:
            raise Exception(
                f"Not possible to add element at location: {loc}. List only of size: {self.element_count}"
            )

        if loc == 1:
            self.insert_at_beginning(val)
        elif loc == self.element_count + 1:
            self.insert_at_end(val)
        else:
            node = DoublyListNode(val)
            current = self.head
            prev = None
            steps = 1
            while steps < loc:
                prev = current
                current = current.next
                steps += 1
            node.next = current
            node.prev = prev
            prev.next = node
            current.prev = node
            self.element_count += 1

    def delete_at_beginning(self):
        if self.element_count == 0:
            raise Exception(
                f"Nothing to delete since list of size: {self.element_count}"
            )
        else:
            head_next = self.head.next
            del self.head
            if self.element_count == 1:
                self.head = head_next
                self.tail = None
            else:
                self.head = head_next
                self.head.prev = None
            self.element_count -= 1

    def delete_at_end(self):
        if self.element_count == 0:
            raise Exception(
                f"Nothing to delete since list of size: {self.element_count}"
            )
        else:
            tail_prev = self.tail.prev
            del self.tail
            if self.element_count == 1:
                self.head = None
                self.tail = tail_prev
            else:
                self.tail = tail_prev
                self.tail.next = None
            self.element_count -= 1

    def delete_at_location(self, loc):
        if self.element_count == 0:
            raise Exception(
                f"Nothing to delete since list of size: {self.element_count}"
            )
        if loc == 1:
            self.delete_at_beginning()
        elif loc == self.element_count:
            self.delete_at_end()
        else:
            current = self.head
            prev = None
            steps = 1

            while steps < loc:
                prev = current
                current = current.next
                steps += 1
            prev.next = current.next
            current.next.prev = prev
            del current
            self.element_count -= 1

    def iterate_list_forward(self) -> List[Numeric]:
        return_list = []
        if self.head is not None:
            current = self.head
            while current is not None:
                return_list.append(current.val)
                current = current.next

        return return_list

    def iterate_list_backward(self) -> List[Numeric]:
        return_list = []
        if self.head is not None:
            current = self.tail
            while current is not None:
                return_list.append(current.val)
                current = current.prev

        return return_list

    def get_nth_element(self, n: int, mode: str = "begin") -> Numeric:
        if self.element_count == 0:
            raise Exception("There is no list to traverse")
        elif self.element_count < n:
            raise Exception(
                f"There are only {self.element_count} elements in the list. Cannot retreive {n}th element"
            )
        else:
            if mode == "begin":
                current = self.head
                steps = 1
                while steps < n:
                    current = current.next
                    steps += 1
                return current.val
            else:
                current = self.tail
                steps = 1
                while steps < n:
                    current = current.prev
                    steps += 1
                return current.val

    def populate_list(self, element_list: List[Numeric], mode="end"):
        fn = self.insert_at_end if mode == "end" else self.insert_at_beginning
        for element in element_list:
            fn(element)

    def delete_list(self, mode="end"):
        fn = self.delete_at_end if mode == "end" else self.delete_at_beginning
        while self.element_count > 0:
            fn()


if __name__ == "__main__":
    print("Populate list by adding elements at beginning")
    begin_element_list = [10, 20, 30, 40, 50]
    l1 = DoublyLinkedList()
    l1.populate_list(begin_element_list, mode="begin")
    print(f"Elements in list in forward direction: {l1.iterate_list_forward()}")
    print(f"Elements in list in backward direction: {l1.iterate_list_backward()}")
    print(f"Count of elements in list: {l1.element_count}")

    print("Populate list by adding elements at end")
    begin_element_list = [100, 200, 300, 400, 500, 600]
    l2 = DoublyLinkedList()
    l2.populate_list(begin_element_list, mode="end")
    l2.insert_at_location(1000, 1)
    l2.insert_at_location(2000, 3)
    l2.insert_at_location(3000, 9)
    print(f"Elements in list in forward direction: {l2.iterate_list_forward()}")
    print(f"Elements in list in backward direction: {l2.iterate_list_backward()}")
    print(f"Count of elements in list: {l2.element_count}")

    print("Delete elements....")
    l2.delete_at_beginning()
    l2.delete_at_end()
    l2.delete_at_location(3)
    print(f"Elements in list in forward direction: {l2.iterate_list_forward()}")
    print(f"Count of elements in list: {l2.element_count}")
    print(f"Element at position 1 from begin: {l2.get_nth_element(1)}")
    print(f"Element at position 5 from begin: {l2.get_nth_element(5)}")

    print(f"Element at position 1 from end: {l2.get_nth_element(1, mode='end')}")
    print(f"Element at position 5 from end: {l2.get_nth_element(5, mode='end')}")

    print("Delete the entire list")
    l2.delete_list(mode="begin")
    print(f"Elements in list in forward direction: {l2.iterate_list_forward()}")
    print(f"Count of elements in list: {l2.element_count}")
    # print(f"Head value: {l2.tail.val}")

    # l3 = DoublyLinkedList()
    # l3.insert_at_end(10)
    # # l3.insert_at_beginning(20)
    # l3.delete_at_end()

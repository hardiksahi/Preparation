from src.datastructures.ListNode import ListNode
from typing import Optional, Union, List

Numeric = Union[float, int]


class LinkedList:
    def __init__(self, head: Optional[ListNode] = None):
        self.head = head
        self.count = 0

    def insert_end(self, val: Numeric):
        if self.head is None:
            node = ListNode(val)
            self.head = node
            # self.tail = node
        else:
            ## Iterate over the list
            node = ListNode(val)
            current = self.head
            while current.next is not None:
                current = current.next
            current.next = node

        self.count += 1

    def insert_start(self, val: Numeric):
        node = ListNode(val)
        if self.head is None:
            self.head = node
            self.count += 1
        else:
            node.next = self.head
            self.head = node
            self.count += 1

    def insert_position(self, val: Numeric, position: Numeric):
        if position == 1:
            self.insert_start(val)
        elif position == self.count + 1:
            self.insert_end(val)
        elif position > self.count + 1:
            raise Exception("No such position available")
        else:
            node = ListNode(val)
            current = self.head
            prev = None
            current_loc = 1

            while current_loc < position:
                prev = current
                current = current.next
                current_loc += 1

            prev.next = node
            node.next = current
            self.count += 1

    def insert_sorted_list(self, val: Numeric):

        if self.count == 0:
            self.insert_start(val)
        else:
            node = ListNode(val)
            curr = self.head
            prev = None

            while curr is not None and curr.val <= val:
                prev = curr
                curr = curr.next

            if prev is None:
                node.next = curr
                self.head = node
            else:
                prev.next = node
                node.next = curr
            self.count += 1

    def delete_end(self):
        if self.head is None:
            raise Exception("Nothing to delete since list is empty")
        elif self.head.next is None:
            del self.head
            self.head = None
            self.count -= 1
            return "Deletion successful"
        else:
            current = self.head
            prev_current = None

            while current.next is not None:
                prev_current = current
                current = current.next

            prev_current.next = None
            del current
            self.count -= 1
            return "Deletion successful"

    def delete_position(self, position: Numeric):
        if position == 1:
            return self.delete_start()
        elif position == self.count:
            return self.delete_end()
        else:
            current = self.head
            prev = None

            curr_location = 1
            while curr_location < position:
                prev = current
                current = current.next
                curr_location += 1

            ## Deletre current
            prev.next = current.next
            del current

            self.count -= 1
            return "Deletion successful"

    def delete_start(self):
        if self.head is None:
            raise Exception("Nothing to delete since list is empty")
        elif self.head.next is None:
            del self.head
            self.head = None
            self.count -= 1
            return "Deletion successful"
        else:
            head_next = self.head.next
            del self.head
            self.head = head_next
            return "Deletion successful"

    def display_elements(self):
        if self.count == 0:
            print("List is empty")
        elif self.head.next is None:
            print(self.head.val)
        else:
            current = self.head
            while current is not None:
                print(current.val)
                current = current.next

    def display_elements_in_reverse(self):
        if self.count == 0:
            print("List is empty")
        elif self.head.next is None:
            print(self.head.val)
        else:
            element_stack = []
            current = self.head
            while current is not None:
                element_stack.append(current.val)
                current = current.next

            while len(element_stack) != 0:
                print(element_stack.pop())

    def count_elements(self):
        if self.head is None:
            return 0
        elif self.head.next is None:
            return 1
        else:
            counter = 0
            current = self.head
            while current is not None:
                counter += 1
                current = current.next

            return counter

    def get_nth_element(self, pos: int, where: str = "start"):
        if where == "start":
            if pos == 1:
                return self.head.val
            elif pos > self.count:
                raise Exception(f"Position: {pos} not available")
            else:
                current = self.head
                current_position = 1
                while current_position < pos:
                    current = current.next
                    current_position += 1
                return current.val
        elif where == "end":
            if pos > self.count:
                raise Exception(f"Position: {pos} not available")
            else:
                fast = self.head
                slow = self.head

                ## Get fast to point to nth element from start
                for _ in range(pos - 1):
                    fast = fast.next
                ## Move fast ans slow one step at a time till fast reaches the last element
                while fast.next is not None:
                    slow = slow.next
                    fast = fast.next

                return slow.val

    def delete_list(self):
        if self.head is None:
            raise Exception("Nothing to delete")
        else:
            while self.head is not None:
                self.delete_start()
            print("Successfully deleted all nodes in the list")

    def reverse_list(self):
        if self.head is None or self.head.next is None:
            return self.head

        temp = None
        nxt = None

        while self.head is not None:
            nxt = self.head.next
            self.head.next = temp
            temp = self.head
            self.head = nxt

        self.head = temp


def populate_list(element_list: List[Numeric]) -> LinkedList:
    linked_list = LinkedList()

    for element in element_list:
        linked_list.insert_end(element)

    return linked_list


if __name__ == "__main__":
    list1 = LinkedList()
    print("Displaying empty list")
    print(f"Number of elements in empty list: {list1.count_elements()}")
    list1.display_elements()

    # print(f"delete_end from empty list: {list1.delete_end()}")
    # list1.display_elements()

    list1.insert_end(10)

    list1.insert_end(20)
    list1.insert_end(30)

    list1.insert_start(1)
    list1.insert_start(2)
    list1.insert_start(3)
    list1.insert_position(1, 1)
    list1.insert_position(3, 5)
    list1.insert_position(15, 9)
    print("Displaying list after adding elements:")
    list1.display_elements()

    print(f"Count of elemenst in list: {list1.count_elements()}")

    print("Delete elements:")
    list1.delete_position(1)
    list1.delete_position(5)
    list1.display_elements()

    # list1.delete_list()
    # print(f"Count of elemenst in list: {list1.count_elements()}")
    # print("Displaying list after deleting all nodes:")
    # list1.display_elements()

    print(
        f"Element at position 1 from start: {list1.get_nth_element(1, where='start')}"
    )
    print(
        f"Element at position 7 from start: {list1.get_nth_element(7, where='start')}"
    )
    print(
        f"Element at position 3 from start: {list1.get_nth_element(3, where='start')}"
    )

    print(
        f"Element at position 5 from start: {list1.get_nth_element(5, where='start')}"
    )

    print(f"Element at position 1 from end: {list1.get_nth_element(1, where='end')}")
    print(f"Element at position 7 from end: {list1.get_nth_element(7, where='end')}")
    print(f"Element at position 3 from end: {list1.get_nth_element(3, where='end')}")

    print(f"Element at position 5 from end: {list1.get_nth_element(5, where='end')}")
    print("********************************")
    ## Create a LL by adding multiple elements in one gp
    element_list = [100, 200, 300, 400]
    list2 = populate_list(element_list)
    print(f"Number of elements in list2: {list2.count_elements()}")
    list2.display_elements()
    print("********************************")

    list3 = LinkedList()
    list3.insert_sorted_list(10)
    list3.insert_sorted_list(0)
    list3.insert_sorted_list(4)
    list3.insert_sorted_list(15)
    print(f"Number of elements in list3: {list3.count_elements()}")
    list3.display_elements()
    print(f"Display elemnets in revrse....")
    list3.display_elements_in_reverse()
    print("********************************")

    list3.reverse_list()
    print(f"Number of elements in reversed list3: {list3.count_elements()}")
    list3.display_elements()
    print("********************************")

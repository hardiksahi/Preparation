from enum import Enum
from typing import Union, List
from fastapi import FastAPI
from pydantic import BaseModel
from datastructures.LinkedList import LinkedList

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float
    is_offer: Union[bool, None] = None

class ModelName(str, Enum):
    alexnet = "alexnet"
    resnet = "resnet"
    lenet = "lenet"

class ItemList(BaseModel):
    item_list: List[int]

@app.get("/")
def read_root():
    return {"Hello": "Hardik"}

# @app.get("/items")
# def read_item(item_id: int = 10, q: Union[str, None] = None):
#     return {"item_id":item_id, "query":q}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id":item_id, "query":q}

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_price": item.price, "item_id": item_id}


@app.get("/models/{model_name}")
def get_model(model_name: ModelName):
    if model_name == ModelName.alexnet:
        return {"model_name": model_name, "message": "DL FTW!"}
    if model_name == ModelName.resnet:
        return {"model_name": model_name, "message": "Images"}
    
    return {"model_name": model_name, "message": "Other!!"}

@app.post("list/insert/")
def insert_element(element_list: ItemList):
    ll = LinkedList()
    for i in element_list:
        ll.insert_start(i)
    return ll

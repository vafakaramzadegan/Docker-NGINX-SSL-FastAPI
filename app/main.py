from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from faker import Faker


app = FastAPI()

fake = Faker()
fake_items = [{"name": fake.word(), "description": fake.sentence()} for _ in range(100)]

class Item(BaseModel):
    name: str
    description: str = None

@app.get("/")
def get_homepage():
    return {"message": "Hello, world!"}

@app.get("/items/", response_model=list[Item])
def read_items(skip: int = 0, limit: int = 10):
    return fake_items[skip : skip + limit]

@app.get("/items/{item_name}", response_model=Item)
def read_item(item_name: str):
    item = next((item for item in fake_items if item["name"] == item_name), None)
    if item:
        return item
    raise HTTPException(status_code=404, detail="Item not found")

@app.post("/items/", response_model=Item)
def create_item(item: Item):
    new_item = {"name": item.name, "description": item.description}
    fake_items.append(new_item)
    return new_item

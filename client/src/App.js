import { useState } from "react";
import Web3 from "web3";
import { v4 as uuid } from "uuid";
import { shopAbis } from "./abis";
import "./App.css";

const web3 = new Web3(Web3.givenProvider);

const contractAddress = "0x9fE29B0457AAa62df8edbc9B648aD1770A614Aa0";
const ShopContract = new web3.eth.Contract(shopAbis, contractAddress);

function App() {
  const [productName, setProductName] = useState("");
  const [price, setPrice] = useState("");
  const [quantity, setQuantity] = useState(0);
  const newProduct = async (e) => {
    e.preventDefault();
    const accounts = await window.ethereum.enable();
    const account = accounts[0];
    const gas = await ShopContract.methods
      .newProduct(uuid(), productName, price, quantity)
      .estimateGas();

    const res = await ShopContract.methods
      .newProduct(uuid(), productName, price, quantity)
      .send({
        from: account,
        gas,
      });
    console.log(res);
  };
  return (
    <div className="App">
      <h1>New product</h1>
      <form onSubmit={newProduct}>
        <input
          type="text"
          placeholder="Product Name..."
          onChange={(e) => setProductName(e.target.value)}
        />
        <input
          type="text"
          placeholder="Product Price..."
          onChange={(e) => setPrice(e.target.value)}
        />
        <input
          type="text"
          placeholder="Product Quantity..."
          onChange={(e) => setQuantity(e.target.value)}
        />
        <button type="submit">save</button>
      </form>
    </div>
  );
}

export default App;

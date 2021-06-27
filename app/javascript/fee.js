function calc (){
  const price = document.getElementById("item-price");
  price.addEventListener("change", () => {
    const fee = price.value / 10 ;
    const addTax = document.getElementById("add-tax-price");
    addTax.innerHTML = `${fee}`;
    const addProfit = document.getElementById("profit");
    const profit = price.value -fee;
    addProfit.innerHTML = `${profit}`;
  });
};

window.addEventListener('load', calc);
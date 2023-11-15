function hell() {
    const arr = ["a", "b", "c", "d", "e"];
    document.getElementById("button").innerHTML = `${arr.reduce(sum)}`;
}

function sum(total, value) {
    return total + value;
}

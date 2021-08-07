const url = "https://www.random.org/integers/?";

async function getVisitorNumber() {
    const params = {
        num: 1,
        min: 1,
        max: 10,
        col: 1,
        base: 10,
        format: "plain",
        rnd: "new"
    };

    let response = await axios.get(url, { params });
    return response;
}

const incrementNumberByOne = (count) => {
    count++;
    return count;
}

const setVisitorNumber = () => { }

const writeVisitorNumber = (number) => {
    const visitorNumberElement = document.getElementById('visitor-counter');
    visitorNumberElement.innerHTML = number;
}

window.onload = function () {
    const visitorNumberPromise = getVisitorNumber();
    visitorNumberPromise.then((response) => {
        const newVisitorNumber = incrementNumberByOne(response.data);
        setVisitorNumber(newVisitorNumber);
        writeVisitorNumber(newVisitorNumber);
    });
}

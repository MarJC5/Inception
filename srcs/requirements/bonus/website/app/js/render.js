/* js function to loop /data/data.json and render it to the page index.html with the help of render.js */
document.addEventListener('DOMContentLoaded', function () {
    const container = document.getElementById('main-container');
    // fetch data from data.json
    if (container) {
        fetch('../data/data.json')
            .then(response => response.json())
            .then(data => {
                try {
                    // loop through data
                    data.forEach(function (item) {
                        // create new elements
                        const card = document.createElement('a');
                        const newDiv = document.createElement('div');
                        const newH2 = document.createElement('h2');
                        const newH3 = document.createElement('h3');
                        const newUl = document.createElement('ul');
                        // link
                        card.href = item.url;
                        // add classes to elements
                        newDiv.classList.add('card', 'flex', 'flex-col', 'justify-center', 'items-center',
                            'p-2', 'm-4', 'bg-white', 'rounded-lg', 'drop-shadow-md', 'h-full', 'transform',
                            'transition', 'duration-500', 'hover:scale-105');
                        newH2.classList.add('card-title', 'uppercase', 'font-bold', 'text-center', 'mb-4',
                            'text-2xl');
                        newH3.classList.add('card-subtitle');
                        newUl.classList.add('card-list', 'flex', 'flex-wrap', 'justify-center', 'align-center',
                            'list-reset', 'm-2', 'p-2');
                        // add text content
                        newH2.textContent = item.name;
                        newH3.textContent = `Project N° ${item.id}`;
                        // append to DOM
                        // loop topics
                        newDiv.appendChild(newH2);
                        newDiv.appendChild(newH3);
                        item.topics.forEach(function (topic) {
                            const newLi = document.createElement('li');
                            newLi.innerHTML = topic;
                            newLi.classList.add('card', 'flex', 'justify-center', 'items-center', 'm-2', 'py-1', 'px-2', 'bg-black', 'rounded-lg', 'text-white', 'text-sm');
                            newUl.appendChild(newLi);
                        });
                        newDiv.appendChild(newUl);
                        card.appendChild(newDiv);
                        container.appendChild(card);

                    });
                } catch (err) {
                    console.log(err);
                }
            });
    }
});
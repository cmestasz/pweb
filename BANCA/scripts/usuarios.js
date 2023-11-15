onload = function () {
    first_logged();
    update_timer();
    setInterval(update_timer, 1 * 1000);
};

function first_logged() {
    request("check", function (response) {
        let logged_in = response.getElementsByTagName("logged_in")[0].childNodes[0].nodeValue;
        if (logged_in == "1") {
            let welcome = document.createElement("h4");
            let user = response.getElementsByTagName("user")[0].childNodes[0].nodeValue;
            welcome.innerHTML = "Bienvenido, " + user;
            document.getElementById("content").insertBefore(welcome, document.getElementById("timer"));
        } else {
            redirect_back();
        }
    });
}

function update_timer() {
    request("check", function (response) {
        let logged_in = response.getElementsByTagName("logged_in")[0].childNodes[0].nodeValue;
        if (logged_in == "1") {
            let timer = response.getElementsByTagName("expire_time")[0].childNodes[0].nodeValue;
            document.getElementById("timer").innerHTML = "Su sesión concluirá en: " + timer + "s";
        } else {
            redirect_back();
        }
    });
}

function close_session() {
    request("close", function (response) {
        redirect_back();
    });
}

function request(action, callback) {
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            callback(xhttp.responseXML);
        }
    };
    xhttp.open("GET", "./cgi-bin/index_usuarios.pl?action=" + action, true);
    xhttp.send();
}

function redirect_back() {
    alert("Su sesión ha expirado");
    window.location = "./usuarios.html";
}


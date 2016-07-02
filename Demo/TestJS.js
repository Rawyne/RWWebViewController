var button = document.getElementById("index-bn");
button.addEventListener("click",
                        function() {
                            var msg = {"ID": "0", "Msg": "Hello"};
                            window.webkit.messageHandlers.JSMsg.postMessage(msg);
                        
                        },
                        false);



function foo(arg) {
    alert(arg);
    return arg;
}
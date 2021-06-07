// ==UserScript==
// @name MD Svelte Shim
// @namespace https://github.com/AviKav/MD-Porcelain
// @match https://*.mangadex.org/*
// @icon https://raw.githubusercontent.com/AviKav/MD-Porcelain/main/public/favicon.png
// @run-at document-end
// @noframes
__INSERT__

function populate(key) {
    return `href='${data[key].web}' integrity='${data[key].sri}'`
}

let str = `<!DOCTYPE html>
<html lang='en'>
<head>
	<meta charset='utf-8'>
	<meta name='viewport' content='width=device-width,initial-scale=1'>

	<title>MD Svelte Shim</title>

	<link rel='icon' type='image/png' ${populate("/favicon.png")}>
	<link rel='stylesheet' ${populate("/global.css")}>
	<link rel='stylesheet' ${populate("/build/bundle.css")}>
</head>

<body>
</body>
</html>
`

unsafeWindow.document.getElementsByTagName('html')[0].innerHTML = str

script = unsafeWindow.document.createElement('script');
script.src = data["/build/bundle.js"].web;
script.integrity = data["/build/bundle.js"].sri;
unsafeWindow.document.getElementsByTagName('head')[0].appendChild(script);

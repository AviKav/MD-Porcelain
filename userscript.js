// @name MD Svelte Shim
// @namespace https://github.com/AviKav/MD-Porcelain
// @match https://*.mangadex.org/*
// @icon https://raw.githubusercontent.com/AviKav/MD-Porcelain/main/public/favicon.png
// @run-at document-end
// @noframes
// @version 5027c26

let str = `<!DOCTYPE html>
<html lang='en'>
<head>
	<meta charset='utf-8'>
	<meta name='viewport' content='width=device-width,initial-scale=1'>

	<title>MD Svelte Shim</title>

	<link rel='icon' type='image/png' integrity='sha256-KQwIfMxQzs0mcFQ7k12xFsdiaiX26I9zqwBUsMXD0Wg=' href='https://example.com/foo/66d6f875f69fdf463e38fa0f1f01924379b84489c2233a0b7cd67949c1a38080/favicon.png'>
	<link rel='stylesheet' integrity='sha256-c1nuzGmx3u8Iv926ThMzpJqSPbYcxwlHG40SHKevMFE=' href='https://example.com/foo/66d6f875f69fdf463e38fa0f1f01924379b84489c2233a0b7cd67949c1a38080/global.css'>
	<link rel='stylesheet' integrity='sha256-QnsTtHDLnafmKYO+S2GC4mbGoTjxFRutGlN7Xc1wS0U=' href='https://example.com/foo/66d6f875f69fdf463e38fa0f1f01924379b84489c2233a0b7cd67949c1a38080/build/bundle.css'>

	<script defer integrity='sha256-pqdO/uHG7gFFoSRKC1HYxgnRe8T5mMfKaynKt/8Irtk=' src='https://example.com/foo/66d6f875f69fdf463e38fa0f1f01924379b84489c2233a0b7cd67949c1a38080/build/bundle.js'></script>
</head>

<body>
</body>
</html>`

window.document.getElementsByTagName('html')[0].innerHTML = str;
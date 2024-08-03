#!/usr/bin/env bash
# create a link page of LGTM images

PATH_DIR_REPO="$(dirname "$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)")"
BASE_URL="https://github.com/yoshi389111/yoshi389111/raw/main/LGTM"

(
    cat <<EOD
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>LGTM.</title>
<style>
#toast {
    visibility: hidden;
    z-index: 10;
    background-color: rgba(0, 0, 0, 0.8);
    color: white;
    padding: 1em;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
    text-align: center;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}
</style>
<script>
function copyLink(file_name) {
    const textarea = document.getElementById("work");
    textarea.value = "![LGTM]($BASE_URL/" + file_name + ")";
    textarea.select();
    document.execCommand("copy");

    const toast = document.getElementById("toast");
    toast.style.visibility = "visible";
    setTimeout(() => toast.style.visibility = "hidden", 1000)
}
</script>
</head>
<body>
<h1>Links of LGTM</h1>
EOD

    for FILE_NAME in "$PATH_DIR_REPO"/LGTM/* ; do
        IMAGE_NAME=$(basename "$FILE_NAME")
        echo "<h2>$IMAGE_NAME</h2>"
        echo "<img alt=\"LGTM\" src=\"$BASE_URL/$IMAGE_NAME\" onclick=\"copyLink('$IMAGE_NAME')\"   />"
    done

    cat <<EOD
<h2>copy area</h2>
<textarea id="work"></textarea>
<div id="toast">Copied!</div>
</body>
</html>
EOD

) > "$PATH_DIR_REPO"/docs/lgtm.html



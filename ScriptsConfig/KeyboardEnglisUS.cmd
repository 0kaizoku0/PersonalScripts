@echo off

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$tip='0409:00000409'; ^
$langs=Get-WinUserLanguageList; ^
$added=$false; ^
if($langs[0].InputMethodTips -notcontains $tip){ ^
    $langs[0].InputMethodTips.Add($tip); ^
    Set-WinUserLanguageList $langs -Force; ^
    $added=$true ^
}; ^
Start-Sleep -Seconds 3; ^
if($added){ ^
    $langs=Get-WinUserLanguageList; ^
    $langs[0].InputMethodTips.Remove($tip); ^
    Set-WinUserLanguageList $langs -Force ^
}"

echo Done.

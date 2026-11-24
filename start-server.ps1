$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Listener = New-Object System.Net.HttpListener
$Listener.Prefixes.Add("http://localhost:8000/")
try {
    $Listener.Start()
    Write-Host ""
    Write-Host "Catholic Gospel Sharing is running." -ForegroundColor Green
    Write-Host "Open: http://localhost:8000/" -ForegroundColor Cyan
    Write-Host "Keep this window open while using the app."
    Write-Host "To stop the server, press Ctrl + C."
    Start-Process "http://localhost:8000/"
    while ($Listener.IsListening) {
        $Context = $Listener.GetContext()
        try {
            $Relative = [Uri]::UnescapeDataString($Context.Request.Url.AbsolutePath.TrimStart('/'))
            if ([string]::IsNullOrWhiteSpace($Relative)) { $Relative = "index.html" }
            $FullPath = [System.IO.Path]::GetFullPath((Join-Path $Root $Relative))
            if (-not $FullPath.StartsWith([System.IO.Path]::GetFullPath($Root), [System.StringComparison]::OrdinalIgnoreCase)) {
                $Context.Response.StatusCode = 403
                $Bytes = [Text.Encoding]::UTF8.GetBytes("Forbidden")
            } elseif (Test-Path -LiteralPath $FullPath -PathType Leaf) {
                $Ext = [System.IO.Path]::GetExtension($FullPath).ToLowerInvariant()
                $Mime = switch ($Ext) {
                    ".html" { "text/html; charset=utf-8" }
                    ".js" { "application/javascript; charset=utf-8" }
                    ".css" { "text/css; charset=utf-8" }
                    ".json" { "application/json; charset=utf-8" }
                    ".webmanifest" { "application/manifest+json" }
                    ".svg" { "image/svg+xml" }
                    ".jpg" { "image/jpeg" }
                    ".jpeg" { "image/jpeg" }
                    ".png" { "image/png" }
                    ".ico" { "image/x-icon" }
                    default { "application/octet-stream" }
                }
                $Bytes = [System.IO.File]::ReadAllBytes($FullPath)
                $Context.Response.ContentType = $Mime
                $Context.Response.StatusCode = 200
            } else {
                $Context.Response.StatusCode = 404
                $Bytes = [Text.Encoding]::UTF8.GetBytes("Not found")
            }
            $Context.Response.ContentLength64 = $Bytes.Length
            $Context.Response.OutputStream.Write($Bytes, 0, $Bytes.Length)
        } catch {
            $Context.Response.StatusCode = 500
        } finally {
            $Context.Response.OutputStream.Close()
        }
    }
} catch {
    Write-Host "Could not start the local server: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "If port 8000 is busy, tell me the error and I will change the port."
    Read-Host "Press Enter to close"
} finally {
    if ($Listener.IsListening) { $Listener.Stop() }
    $Listener.Close()
}

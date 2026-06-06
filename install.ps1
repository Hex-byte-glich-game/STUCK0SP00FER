# Install.ps1 - STUCK COMMUNITY Installer

$downloadUrl = "hhttps://stuck-community.f00ycyber.workers.dev/api/download/c5e3df17-3429-496d-bcc4-d8a12f97baa7"

function Show-Menu {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host "       STUCK COMMUNITY INSTALLER        " -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "  1. Install" -ForegroundColor Green
    Write-Host "  2. Exit" -ForegroundColor Red
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Magenta
    Write-Host ""
}

function Install-Application {
    Write-Host ""
    Write-Host "[+] Starting installation..." -ForegroundColor Yellow
    
    # Get temp folder path
    $tempFolder = [System.IO.Path]::GetTempPath()
    $exePath = Join-Path $tempFolder "STUCK_SPOOFER.exe"
    
    #Write-Host "[+] Checkout The Cheating -ForegroundColor Cyan
    
    try {
        # Download the file
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($downloadUrl, $exePath)
        
        Write-Host "[+] Checkout completed!" -ForegroundColor Green
        #Write-Host "[+] File saved to: $exePath" -ForegroundColor Gray
        
        # Check if file exists
        if (Test-Path $exePath) {
            $fileSize = [math]::Round((Get-Item $exePath).Length / 1MB, 2)
            #Write-Host "[+] File size: $fileSize MB" -ForegroundColor Gray
            
            Write-Host ""
            Write-Host "[+] Running installer as administrator..." -ForegroundColor Yellow
            
            # Run as administrator
            Start-Process -FilePath $exePath -Verb RunAs -Wait
            
            Write-Host ""
            Write-Host "[+] Installation completed successfully!" -ForegroundColor Green
            
            # Cleanup - delete temp file after installation
            $cleanup = Read-Host "Delete temporary installer file? (Y/N)"
            if ($cleanup -eq 'Y' -or $cleanup -eq 'y') {
                Remove-Item $exePath -Force
                Write-Host "[+] Temporary file deleted." -ForegroundColor Gray
            }
        } else {
            Write-Host "[!] Error: File not found after download" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "[!] Error: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "[!] Please check your internet connection and try again." -ForegroundColor Red
    }
    
    Write-Host ""
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "Select an option (1 or 2)"
    
    switch ($choice) {
        "1" {
            Install-Application
        }
        "2" {
            Write-Host ""
            Write-Host "[+] Exiting installer. Goodbye!" -ForegroundColor Green
            exit 0
        }
        default {
            Write-Host ""
            Write-Host "[!] Invalid option. Please select 1 or 2." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "2")
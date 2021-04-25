Function Download-Source
{
    Clear-Host
    if (-Not (Test-Path -Path "$root\source"))
    {
        Write-Host -ForegroundColor Green "Cloning the source repository"
        git clone --recursive --branch master --depth 1 https://github.com/azerothcore/azerothcore-wotlk.git $root\source

        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }
    }
    else
    {
        Write-Host -ForegroundColor Green "Pulling the source repository"

        cd $root\source

        git fetch --all
        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }

        git reset --hard origin/master
        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }

        git submodule update
        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }
    }

    cd $root
}

Function Compile-Source
{
    Clear-Host
    Write-Host -ForegroundColor Green "Generating project files"
    New-Item -ItemType Directory -Force -Path "$root\source\build" | Out-Null
    cd $root\source\build
    cmake ../ -DCMAKE_INSTALL_PREFIX=$root\source -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++ -DWITH_WARNINGS=1 -DSCRIPTS=1
    if (-not $?)
    {
        cd $root
        Print-Error("Make sure to fix any errors listed above before trying again")
    }

    Clear-Host
    Write-Host -ForegroundColor Green "Cleaning solution"
    MSBuild.exe AzerothCore.sln /t:Clean
    if (-not $?)
    {
        cd $root
        Print-Error("Make sure to fix any errors listed above before trying again")
    }

    Clear-Host
    Write-Host -ForegroundColor Green "Building solution"
    MSBuild.exe AzerothCore.sln /p:Configuration=Release
    if (-not $?)
    {
        cd $root
        Print-Error("Make sure to fix any errors listed above before trying again")
    }

    cd $root
}

Function Copy-Binaries($type)
{
    Clear-Host
    Write-Host -ForegroundColor Green "Copying files"

    New-Item -ItemType Directory -Force -Path "$root\bin" | Out-Null
    New-Item -ItemType Directory -Force -Path "$root\bin\configs" | Out-Null

    if (($type -eq "auth") -or ($type -eq "all"))
    {
        if (Test-Path -Path "$root\source\build\bin\release\configs\authserver.conf.dist")
        {
            Write-Host -ForegroundColor Yellow "Copying authserver.conf.dist"
            Copy-Item -Path "$root\source\build\bin\release\configs\authserver.conf.dist" -Destination "$root\bin\configs\authserver.conf.dist" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }

        if (Test-Path -Path "$root\source\build\bin\release\authserver.exe")
        {
            Write-Host -ForegroundColor Yellow "Copying authserver.exe"
            Copy-Item -Path "$root\source\build\bin\release\authserver.exe" -Destination "$root\bin\authserver.exe" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }
    }

    if (($type -eq "world") -or ($type -eq "all"))
    {
        if (Test-Path -Path "$root\source\build\bin\release\configs\worldserver.conf.dist")
        {
            Write-Host -ForegroundColor Yellow "Copying worldserver.conf.dist"
            Copy-Item -Path "$root\source\build\bin\release\configs\worldserver.conf.dist" -Destination "$root\bin\configs\worldserver.conf.dist" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }

        if (Test-Path -Path "$root\source\build\bin\release\worldserver.exe")
        {
            Write-Host -ForegroundColor Yellow "Copying worldserver.exe"
            Copy-Item -Path "$root\source\build\bin\release\worldserver.exe" -Destination "$root\bin\worldserver.exe" -Force

            if (-not $?)
            {
                cd $root
                Print-Error("Make sure to fix any errors listed above before trying again")
            }
        }
    }

    if (Test-Path -Path "C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.dll")
    {
        Write-Host -ForegroundColor Yellow "Copying libmysql.dll"
        Copy-Item -Path "C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.dll" -Destination "$root\bin\libmysql.dll" -Force

        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }
    }

    if (Test-Path -Path "C:\Program Files\OpenSSL-Win64\bin\libcrypto-1_1-x64.dll")
    {
        Write-Host -ForegroundColor Yellow "Copying libcrypto-1_1-x64.dll"
        Copy-Item -Path "C:\Program Files\OpenSSL-Win64\bin\libcrypto-1_1-x64.dll" -Destination "$root\bin\libcrypto-1_1-x64.dll" -Force

        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }
    }

    if (Test-Path -Path "C:\Program Files\OpenSSL-Win64\bin\libssl-1_1-x64.dll")
    {
        Write-Host -ForegroundColor Yellow "Copying libssl-1_1-x64.dll"
        Copy-Item -Path "C:\Program Files\OpenSSL-Win64\bin\libssl-1_1-x64.dll" -Destination "$root\bin\libssl-1_1-x64.dll" -Force

        if (-not $?)
        {
            cd $root
            Print-Error("Make sure to fix any errors listed above before trying again")
        }
    }

    cd $root
}

Function Download-Data($type)
{
    if (($type -eq "world") -or ($type -eq "all"))
    {
        if ((-Not (Test-Path -Path "$root\bin\Cameras")) -and (-Not (Test-Path -Path "$root\bin\dbc")) -and (-Not (Test-Path -Path "$root\bin\maps")) -and (-Not (Test-Path -Path "$root\bin\mmaps")) -and (-Not (Test-Path -Path "$root\bin\vmaps")))
        {
            Clear-Host
            Write-Host -ForegroundColor Green "Downloading client data files"

            if (-Not (Test-Path -Path "$root\bin\data.zip"))
            {
                Write-Host -ForegroundColor Yellow "Downloading version 10 of the data files"
                Invoke-WebRequest -Uri "https://github.com/wowgaming/client-data/releases/download/v10/data.zip" -OutFile "$root\bin\data.zip"
            }

            Write-Host -ForegroundColor Yellow "Extracting the data files"
            Expand-Archive -LiteralPath "$root\bin\data.zip" -DestinationPath "$root\bin"

            Remove-Item "$root\bin\data.zip"
        }
    }    
}

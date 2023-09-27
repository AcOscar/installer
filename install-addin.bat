chcp 65001

cd /D %AppData%\Autodesk\Revit\Addins

for /D %%i in (2017 2018 2019 2020 2021 2022 2023 2024) do (

    echo Removing legacy pyRevit addin for Revit %%i ...
    del "%CD%\%%i\pyRevit.addin"
    
)

rmdir /q /s "%AppData%\pyRevit"

cd /D %ProgramData%\Autodesk\Revit\Addins

for /D %%i in (2017 2018 2019 2020 2021 2022 2023 2024) do (

	del "%CD%\%%i\rpm.addin"

	echo Adding addin description file to Revit %%i ...
	(
		echo ^<?xml version="1.0" encoding="utf-8" standalone="no"?^>
		echo ^<RevitAddIns^>
		echo   ^<AddIn Type="Application"^>
		echo     ^<Name^>PyRevitLoader^</Name^>
		echo     ^<Assembly^>%bin%\engines\IPY2710\pyRevitLoader.dll^</Assembly^>
		echo     ^<AddInId^>B39107C3-A1D7-47F4-A5A1-532DDF6EDB5E^</AddInId^>
		echo     ^<FullClassName^>PyRevitLoader.PyRevitLoaderApplication^</FullClassName^>
		echo   ^<VendorId^>eirannejad^</VendorId^>
		echo   ^</AddIn^>
		echo ^</RevitAddIns^>
	) > "%CD%\%%i\pyRevit.addin"

)

echo Clearing caches ...
%bin%\pyrevit caches clear --all

cd /D %pwd%

pause

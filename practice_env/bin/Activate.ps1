<#
.Synopsis
Activate a Python virtual environment for the current PowerShell session.

.Description
Pushes the python executable for a virtual environment to the front of the
$Env:PATH environment variable and sets the prompt to signify that you are
in a Python virtual environment. Makes use of the command line switches as
well as the `pyvenv.cfg` file values present in the virtual environment.

.Parameter VenvDir
Path to the directory that contains the virtual environment to activate. The
default value for this is the parent of the directory that the Activate.ps1
script is located within.

.Parameter Prompt
The prompt prefix to display when this virtual environment is activated. By
default, this prompt is the name of the virtual environment folder (VenvDir)
surrounded by parentheses and followed by a single space (ie. '(.venv) ').

.Example
Activate.ps1
Activates the Python virtual environment that contains the Activate.ps1 script.

.Example
Activate.ps1 -Verbose
Activates the Python virtual environment that contains the Activate.ps1 script,
and shows extra information about the activation as it executes.

.Example
Activate.ps1 -VenvDir C:\Users\MyUser\Common\.venv
Activates the Python virtual environment located in the specified location.

.Example
Activate.ps1 -Prompt "MyPython"
Activates the Python virtual environment that contains the Activate.ps1 script,
and prefixes the current prompt with the specified string (surrounded in
parentheses) while the virtual environment is active.

.Notes
On Windows, it may be required to enable this Activate.ps1 script by setting the
execution policy for the user. You can do this by issuing the following PowerShell
command:

PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

For more information on Execution Policies: 
https://go.microsoft.com/fwlink/?LinkID=135170

#>
Param(
    [Parameter(Mandatory = $false)]
    [String]
    $VenvDir,
    [Parameter(Mandatory = $false)]
    [String]
    $Prompt
)

<# Function declarations --------------------------------------------------- #>

<#
.Synopsis
Remove all shell session elements added by the Activate script, including the
addition of the virtual environment's Python executable from the beginning of
the PATH variable.

.Parameter NonDestructive
If present, do not remove this function from the global namespace for the
session.

#>
function global:deactivate ([switch]$NonDestructive) {
    # Revert to original values

    # The prior prompt:
    if (Test-Path -Path Function:_OLD_VIRTUAL_PROMPT) {
        Copy-Item -Path Function:_OLD_VIRTUAL_PROMPT -Destination Function:prompt
        Remove-Item -Path Function:_OLD_VIRTUAL_PROMPT
    }

    # The prior PYTHONHOME:
    if (Test-Path -Path Env:_OLD_VIRTUAL_PYTHONHOME) {
        Copy-Item -Path Env:_OLD_VIRTUAL_PYTHONHOME -Destination Env:PYTHONHOME
        Remove-Item -Path Env:_OLD_VIRTUAL_PYTHONHOME
    }

    # The prior PATH:
    if (Test-Path -Path Env:_OLD_VIRTUAL_PATH) {
        Copy-Item -Path Env:_OLD_VIRTUAL_PATH -Destination Env:PATH
        Remove-Item -Path Env:_OLD_VIRTUAL_PATH
    }

    # Just remove the VIRTUAL_ENV altogether:
    if (Test-Path -Path Env:VIRTUAL_ENV) {
        R[7mpython3 -m venv practice_env[27m
[K[A[70C[27mp[27my[27mt[27mh[27mo[27mn[27m3[27m [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mp[27mr[27ma[27mc[27mt[27mi[27mc[27me[27m_[27me[27mn[27mv[1B[K[?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd practice_env[1m/[0m[0m             c  ssource
[Jsource         sourcekit-lsp[A[0m[27m[24m[70Csource[K e b
[J[A[78C practice_env[1m/[0m[0m/bin[1m/[0m[0m/A activate[?2004l
[J[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hppyrhont     p  ppython ..v   --version[?2004l
Python 3.11.5
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hssl[?2004l
zsh: command not found: sl
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd ..[?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004h[7mpython3.8 -m venv myenv[27m
[K[A[64C[27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[27m8[27m [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mm[27my[27me[27mn[27mv[1B[K[A[87C[?2004l[1B
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hpython3.8 -m venv myenv
[K[K[A[87C[1C[1C[1C[?2004l[1B
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hpython3.8 -m venv myenv
[K[K[?2004l
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004h[7mls /usr/bin/python*[27m
[K[A[64C[27ml[27ms[27m [27m/[27mu[27ms[27mr[27m/[27mb[27mi[27mn[27m/[27mp[27my[27mt[27mh[27mo[27mn[27m*[1B[K[?2004l
/usr/bin/python3
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hññsñ  k lls[?2004l
100daysofCode	etl_con_python	practica1_1
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hccd etl_con_python[1m/[0m[0m [?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004h[7mpython3.8 -m venv myenv[27m[23D[27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[27m8[27m [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mm[27my[27me[27mn[27mv[?2004l
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3.8 -m venv myenv[?2004l
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd ,,  ..  c  ddeactivate[1m [0m[0m [?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004h[7m(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % python3.8[7m [7m-m venv myenv[27m[K
[7mzsh: command not found: python3.8[27m[K[A[A[22C[27m([27mp[27mr[27ma[27mc[27mt[27mi[27mc[27me[27m_[27me[27mn[27mv[27m)[27m [27m([27mb[27ma[27ms[27me[27m)[27m [27mo[27ms[27mc[27ma[27mr[27mi[27my[27ma[27mn[27me[27mz[27m@[27mo[27ms[27mc[27ma[27mr[27ms[27m-[27mM[27ma[27mc[27mB[27mo[27mo[27mk[27m-[27mA[27mi[27mr[27m [27me[27mt[27ml[27m_[27mc[27mo[27mn[27m_[27mp[27my[27mt[27mh[27mo[27mn[27m [27m%[27m [27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[27m8 [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mm[27my[27me[27mn[27mv[1B[27mz[27ms[27mh[27m:[27m [27mc[27mo[27mm[27mm[27ma[27mn[27md[27m [27mn[27mo[27mt[27m [27mf[27mo[27mu[27mn[27md[27m:[27m [27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[K                          z [K[K[A[14C            [K[A[133C[K[1B[K[A[133C                                                                       (  lsdeactivate[10Dls        [8D  [7mpython3.8 -m venv myenv[27m[23D[27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[27m8[27m [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mm[27my[27me[27mn[27mv[1C[?2004l[1Bzsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3.8 -m venv myenv[?2004l
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3.8 -m venv myenv[1C[?2004l
zsh: command not found: python3.8
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004h[7mpython3.9 -m venv myenv[27m
[K[A[55C[27mp[27my[27mt[27mh[27mo[27mn[27m3[27m.[27m9[27m [27m-[27mm[27m [27mv[27me[27mn[27mv[27m [27mm[27my[27me[27mn[27mv[1B[K[?2004l
zsh: command not found: python3.9
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3.9 -m venv myenv
[K[A[55C                       [1B[K[A[55Clls[?2004l[1Bpractica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd practic       c  ccd practic       c  ssource pa ractice_env[1m/[0m[0m [?2004l
source: no such file or directory: practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hllsl  ssource pora    practice_env[1m/[0m[0m/bin[1m/[0m[0m/a
[Jactivate       activate.csh   activate.fish  alembic*       apprise*[A[0m[27m[24m[55Csource practice_env/bin/a[Kct
[J[A[82Civate[?2004l
[J[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd ..[?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hlls[?2004l
100daysofCode	etl_con_python	practica1_1
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hccd el   el tl_con_python[1m/[0m[0m [?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpprp  ppython2 3 practica_1_helloworld.py[1m [0m[0m [?2004l
Traceback (most recent call last):
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practica_1_helloworld.py", line 8, in <module>
    with Flow("P1.1 - Hello World") as flow:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/context.py", line 185, in __register_init__
    __init__(__self__, *args, **kwargs)
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/flows.py", line 251, in __init__
    raise TypeError("'fn' must be callable")
TypeError: 'fn' must be callable
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3 practica_1_helloworld.py[?2004l
Traceback (most recent call last):
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practica_1_helloworld.py", line 8, in <module>
    with Flow("P1.1 - Hello World") as flow:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/context.py", line 185, in __register_init__
    __init__(__self__, *args, **kwargs)
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/flows.py", line 251, in __init__
    raise TypeError("'fn' must be callable")
TypeError: 'fn' must be callable
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hpython3 practica_1_helloworld.py[1C[P[25C [26D[?2004l
Traceback (most recent call last):
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practica_1_helloworld.py", line 8, in <module>
    with Flow("P1.1 - Hello World") as flow:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/context.py", line 185, in __register_init__
    __init__(__self__, *args, **kwargs)
  File "/Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/flows.py", line 251, in __init__
    raise TypeError("'fn' must be callable")
TypeError: 'fn' must be callable
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004h[7mpip uninstall prefect[27m
[7mpip install 'prefect==0.14.10'[27m[K[A[40C[27mp[27mi[27mp[27m [27mu[27mn[27mi[27mn[27ms[27mt[27ma[27ml[27ml[27m [27mp[27mr[27me[27mf[27me[27mc[27mt[1B[27mp[27mi[27mp[27m [27mi[27mn[27ms[27mt[27ma[27ml[27ml[27m [27m'[27mp[27mr[27me[27mf[27me[27mc[27mt[27m=[27m=[27m0[27m.[27m1[27m4[27m.[27m1[27m0[27m'[?2004l
Found existing installation: prefect 2.14.10
Uninstalling prefect-2.14.10:
  Would remove:
    /Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/bin/prefect
    /Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect-2.14.10.dist-info/*
    /Users/oscariyanez/Documents/Udemy/projects/etl_con_python/practice_env/lib/python3.11/site-packages/prefect/*
Proceed (Y/n)? Y
  Successfully uninstalled prefect-2.14.10
Collecting prefect==0.14.10
  Downloading prefect-0.14.10-py3-none-any.whl (488 kB)
[?25l     [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/488.8 kB[0m [31m?[0m eta [36m-:--:--[0m[2K     [38;5;197m━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m30.7/488.8 kB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K     [38;5;197m━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m112.6/488.8 kB[0m [31m1.8 MB/s[0m eta [36m0:00:01[0m[2K     [38;5;197m━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━[0m [32m204.8/488.8 kB[0m [31m1.9 MB/s[0m eta [36m0:00:01[0m[2K     [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━[0m [32m307.2/488.8 kB[0m [31m2.0 MB/s[0m eta [36m0:00:01[0m[2K     [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━[0m [32m399.4/488.8 kB[0m [31m2.1 MB/s[0m eta [36m0:00:01[0m[2K     [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m488.8/488.8 kB[0m [31m2.2 MB/s[0m eta [36m0:00:00[0m
[?25hRequirement already satisfied: click>=7.0 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (8.1.7)
Requirement already satisfied: cloudpickle>=1.3.0 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (3.0.0)
Collecting croniter<1.0,>=0.3.24 (from prefect==0.14.10)
  Downloading croniter-0.3.37-py2.py3-none-any.whl (13 kB)
Collecting dask>=2.17.0 (from prefect==0.14.10)
  Downloading dask-2023.12.0-py3-none-any.whl.metadata (3.7 kB)
Collecting distributed>=2.17.0 (from prefect==0.14.10)
  Downloading distributed-2023.12.0-py3-none-any.whl.metadata (3.4 kB)
Requirement already satisfied: docker>=3.4.1 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (6.1.3)
Collecting marshmallow>=3.0.0b19 (from prefect==0.14.10)
  Downloading marshmallow-3.20.1-py3-none-any.whl.metadata (7.8 kB)
Collecting marshmallow-oneofschema>=2.0.0b2 (from prefect==0.14.10)
  Downloading marshmallow_oneofschema-3.0.1-py2.py3-none-any.whl (5.8 kB)
Collecting msgpack>=0.6.0 (from prefect==0.14.10)
  Downloading msgpack-1.0.7-cp311-cp311-macosx_11_0_arm64.whl.metadata (9.1 kB)
Collecting mypy-extensions>=0.4.0 (from prefect==0.14.10)
  Downloading mypy_extensions-1.0.0-py3-none-any.whl (4.7 kB)
Requirement already satisfied: pendulum>=2.0.4 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (2.1.2)
Requirement already satisfied: python-dateutil>=2.7.0 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (2.8.2)
Requirement already satisfied: pyyaml>=3.13 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (6.0.1)
Collecting python-box>=5.1.0 (from prefect==0.14.10)
  Downloading python_box-7.1.1-cp311-cp311-macosx_10_9_universal2.whl.metadata (7.8 kB)
Requirement already satisfied: python-slugify>=1.2.6 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (8.0.1)
Requirement already satisfied: pytz>=2018.7 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (2023.3.post1)
Requirement already satisfied: requests>=2.20 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (2.31.0)
Collecting tabulate>=0.8.0 (from prefect==0.14.10)
  Downloading tabulate-0.9.0-py3-none-any.whl (35 kB)
Requirement already satisfied: toml>=0.9.4 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (0.10.2)
Requirement already satisfied: urllib3>=1.24.3 in ./practice_env/lib/python3.11/site-packages (from prefect==0.14.10) (1.26.18)
Collecting natsort (from croniter<1.0,>=0.3.24->prefect==0.14.10)
  Downloading natsort-8.4.0-py3-none-any.whl.metadata (21 kB)
Requirement already satisfied: fsspec>=2021.09.0 in ./practice_env/lib/python3.11/site-packages (from dask>=2.17.0->prefect==0.14.10) (2023.12.2)
Requirement already satisfied: packaging>=20.0 in ./practice_env/lib/python3.11/site-packages (from dask>=2.17.0->prefect==0.14.10) (23.2)
Collecting partd>=1.2.0 (from dask>=2.17.0->prefect==0.14.10)
  Downloading partd-1.4.1-py3-none-any.whl.metadata (4.6 kB)
Collecting toolz>=0.10.0 (from dask>=2.17.0->prefect==0.14.10)
  Downloading toolz-0.12.0-py3-none-any.whl (55 kB)
[?25l     [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/55.8 kB[0m [31m?[0m eta [36m-:--:--[0m[2K     [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m55.8/55.8 kB[0m [31m3.1 MB/s[0m eta [36m0:00:00[0m
[?25hCollecting importlib-metadata>=4.13.0 (from dask>=2.17.0->prefect==0.14.10)
  Downloading importlib_metadata-7.0.0-py3-none-any.whl.metadata (4.9 kB)
Requirement already satisfied: jinja2>=2.10.3 in ./practice_env/lib/python3.11/site-packages (from distributed>=2.17.0->prefect==0.14.10) (3.1.2)
Collecting locket>=1.0.0 (from distributed>=2.17.0->prefect==0.14.10)
  Downloading locket-1.0.0-py2.py3-none-any.whl (4.4 kB)
Requirement already satisfied: psutil>=5.7.2 in ./practice_env/lib/python3.11/site-packages (from distributed>=2.17.0->prefect==0.14.10) (5.9.6)
Collecting sortedcontainers>=2.0.5 (from distributed>=2.17.0->prefect==0.14.10)
  Downloading sortedcontainers-2.4.0-py2.py3-none-any.whl (29 kB)
Collecting tblib>=1.6.0 (from distributed>=2.17.0->prefect==0.14.10)
  Downloading tblib-3.0.0-py3-none-any.whl.metadata (25 kB)
Requirement already satisfied: tornado>=6.0.4 in ./practice_env/lib/python3.11/site-packages (from distributed>=2.17.0->prefect==0.14.10) (6.4)
Collecting zict>=3.0.0 (from distributed>=2.17.0->prefect==0.14.10)
  Downloading zict-3.0.0-py2.py3-none-any.whl (43 kB)
[?25l     [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/43.3 kB[0m [31m?[0m eta [36m-:--:--[0m[2K     [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m43.3/43.3 kB[0m [31m1.7 MB/s[0m eta [36m0:00:00[0m
[?25hRequirement already satisfied: websocket-client>=0.32.0 in ./practice_env/lib/python3.11/site-packages (from docker>=3.4.1->prefect==0.14.10) (1.7.0)
Requirement already satisfied: pytzdata>=2020.1 in ./practice_env/lib/python3.11/site-packages (from pendulum>=2.0.4->prefect==0.14.10) (2020.1)
Requirement already satisfied: six>=1.5 in ./practice_env/lib/python3.11/site-packages (from python-dateutil>=2.7.0->prefect==0.14.10) (1.16.0)
Requirement already satisfied: text-unidecode>=1.3 in ./practice_env/lib/python3.11/site-packages (from python-slugify>=1.2.6->prefect==0.14.10) (1.3)
Requirement already satisfied: charset-normalizer<4,>=2 in ./practice_env/lib/python3.11/site-packages (from requests>=2.20->prefect==0.14.10) (3.3.2)
Requirement already satisfied: idna<4,>=2.5 in ./practice_env/lib/python3.11/site-packages (from requests>=2.20->prefect==0.14.10) (3.6)
Requirement already satisfied: certifi>=2017.4.17 in ./practice_env/lib/python3.11/site-packages (from requests>=2.20->prefect==0.14.10) (2023.11.17)
Collecting zipp>=0.5 (from importlib-metadata>=4.13.0->dask>=2.17.0->prefect==0.14.10)
  Downloading zipp-3.17.0-py3-none-any.whl.metadata (3.7 kB)
Requirement already satisfied: MarkupSafe>=2.0 in ./practice_env/lib/python3.11/site-packages (from jinja2>=2.10.3->distributed>=2.17.0->prefect==0.14.10) (2.1.3)
Downloading dask-2023.12.0-py3-none-any.whl (1.2 MB)
[?25l   [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/1.2 MB[0m [31m?[0m eta [36m-:--:--[0m[2K   [38;5;197m━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.1/1.2 MB[0m [31m2.7 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.2/1.2 MB[0m [31m2.6 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.3/1.2 MB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.3/1.2 MB[0m [31m2.3 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.4/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.5/1.2 MB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━[0m [32m0.6/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━[0m [32m0.7/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━[0m [32m0.8/1.2 MB[0m [31m2.3 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━[0m [32m0.9/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━[0m [32m1.0/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━[0m [32m1.1/1.2 MB[0m [31m2.3 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━[0m [32m1.2/1.2 MB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m1.2/1.2 MB[0m [31m2.3 MB/s[0m eta [36m0:00:00[0m
[?25hDownloading distributed-2023.12.0-py3-none-any.whl (997 kB)
[?25l   [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/997.8 kB[0m [31m?[0m eta [36m-:--:--[0m[2K   [38;5;197m━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m92.2/997.8 kB[0m [31m3.7 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m174.1/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m245.8/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m358.4/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━[0m [32m419.8/997.8 kB[0m [31m2.3 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━[0m [32m522.2/997.8 kB[0m [31m2.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━[0m [32m634.9/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━[0m [32m747.5/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━[0m [32m870.4/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━[0m [32m972.8/997.8 kB[0m [31m2.6 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m997.8/997.8 kB[0m [31m2.5 MB/s[0m eta [36m0:00:00[0m
[?25hDownloading marshmallow-3.20.1-py3-none-any.whl (49 kB)
[?25l   [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/49.4 kB[0m [31m?[0m eta [36m-:--:--[0m[2K   [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m49.4/49.4 kB[0m [31m2.8 MB/s[0m eta [36m0:00:00[0m
[?25hDownloading msgpack-1.0.7-cp311-cp311-macosx_11_0_arm64.whl (231 kB)
[?25l   [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/232.0 kB[0m [31m?[0m eta [36m-:--:--[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━[0m [32m112.6/232.0 kB[0m [31m3.0 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━[0m [32m204.8/232.0 kB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m232.0/232.0 kB[0m [31m2.7 MB/s[0m eta [36m0:00:00[0m
[?25hDownloading python_box-7.1.1-cp311-cp311-macosx_10_9_universal2.whl (1.8 MB)
[?25l   [38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.0/1.8 MB[0m [31m?[0m eta [36m-:--:--[0m[2K   [38;5;197m━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.1/1.8 MB[0m [31m4.4 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.2/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.3/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.4/1.8 MB[0m [31m2.7 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.5/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.6/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━━━━[0m [32m0.7/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━━━━━━[0m [32m0.9/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━━━━━━━━[0m [32m1.0/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━━━[0m [32m1.1/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━━━[0m [32m1.2/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━━━━[0m [32m1.3/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━━━━━━[0m [32m1.4/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━[0m [32m1.6/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;197m╸[0m[38;5;237m━━━[0m [32m1.7/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;197m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m [32m1.8/1.8 MB[0m [31m2.9 MB/s[0m eta [36m0:00:01[0m[2K   [38;5;70m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m1.8/1.8 MB[0m [31m2.8 MB/s[0m eta [36m0:00:00[0m
[?25hDownloading importlib_metadata-7.0.0-py3-none-any.whl (23 kB)
Downloading partd-1.4.1-py3-none-any.whl (18 kB)
Downloading tblib-3.0.0-py3-none-any.whl (12 kB)
Downloading natsort-8.4.0-py3-none-any.whl (38 kB)
Downloading zipp-3.17.0-py3-none-any.whl (7.4 kB)
Installing collected packages: sortedcontainers, zipp, zict, toolz, tblib, tabulate, python-box, natsort, mypy-extensions, msgpack, marshmallow, locket, partd, marshmallow-oneofschema, importlib-metadata, croniter, dask, distributed, prefect
  Attempting uninstall: croniter
    Found existing installation: croniter 2.0.1
    Uninstalling croniter-2.0.1:
      Successfully uninstalled croniter-2.0.1
Successfully installed croniter-0.3.37 dask-2023.12.0 distributed-2023.12.0 importlib-metadata-7.0.0 locket-1.0.0 marshmallow-3.20.1 marshmallow-oneofschema-3.0.1 msgpack-1.0.7 mypy-extensions-1.0.0 natsort-8.4.0 partd-1.4.1 prefect-0.14.10 python-box-7.1.1 sortedcontainers-2.4.0 tabulate-0.9.0 tblib-3.0.0 toolz-0.12.0 zict-3.0.0 zipp-3.17.0
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hppython 2 3 practice_env[1m/[0m[0m      a_1_helloworld.py[1m [0m[0m [?2004l
[2023-12-13 22:44:27-0600] INFO - prefect.FlowRunner | Beginning Flow run for 'P1.1 - Hello World'
[2023-12-13 22:44:27-0600] INFO - prefect.FlowRunner | Flow run SUCCESS: all reference tasks succeeded
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccode .[?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd ..[?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hlls[?2004l
100daysofCode	etl_con_python	practica1_1
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air projects % [K[?2004hccd etl_con_python[1m/[0m[0m [?2004l
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hlls[?2004l
practica_1_helloworld.py	practice_env
[1m[7m%[27m[1m[0m                                                                                                                                      ]7;file://oscars-MacBook-Air.local/Users/oscariyanez/Documents/Udemy/projects/etl_con_python[0m[27m[24m[J(practice_env) (base) oscariyanez@oscars-MacBook-Air etl_con_python % [K[?2004hccd pra   c  
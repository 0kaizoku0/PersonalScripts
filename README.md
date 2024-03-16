# PersonalScripts
This repo has useful scripts for configuring PC and files for tools.

If error:
.ps1 cannot be loaded because running
scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.

Run:
Set-ExecutionPolicy RemoteSigned
  Restricted    – No scripting allowed
  Unrestricted  – You can run any script, No signing is required.
  RemoteSigned  – Good for Test and dev environments. Only files from the internet need to be signed. Otherwise, you’ll see .ps1 is not digitally signed error. This is the default setting on servers.
  AllSigned     – local or remote script – A trusted publisher should sign it; only digitally signed PowerShell scripts are allowed.

 0
0
  1
  1
    2
    2
      3
      3
        4
        4
          5
          5
            6
            6
              7
              7
                8
                8
                  9
                  9
                    10
                    10
                      11
                      11
                        12
                        12
                          13
                          13
                            14
                            14
                              15
                              15
                                16
                                16
# HashiCorp Nomad Packer Quickstarts

_Just to note: this registry is heavily a work in progress._

This repository contains quickstart Packer templates and Ansible playbooks to build HashiCorp Nomad images for various cloud providers. 

This is intended to be a forkable repository to help get you started with building your own Nomad images using Packer and Ansible, tailored to your specific needs and environment.

## Cloud Providers Supported

Each of these have their own Packer templates. 

- AWS
- GCP
- Azure
- IBM Cloud

## Ansible Playbooks Supported

Using a shared set of Ansible playbooks to configure the Nomad agents after Packer builds the base images.

- Nomad Client Configuration (nomad-client.yml)
- Nomad Server Configuration (nomad-server.yml)

## Nomad Version Support
- Versioning: Built with Nomad 1.10.x
- Nomad CE
- Nomad Enterprise

## Nomad Task Drivers Supported
- Podman


## Vault Integration
- Staged if using Vault for secrets management and TLS certificates

## Spooky Ascii Art
- Temporary Spooky Ascii Art to liven up the README. 


```

                               Jgy__                        
                            jWW  `""9Wf
                          _#WWW     IW
                         jWWWWW     IW
                 __,yyyyyWWWWW     IWyyyy___
            _jyWWP"^``"`.C"9*,J _.mqD:^^"WWWWWWQg__
          jgW"^.C/"    .C'     I    `D.     'D._"WQg_
        jWP` .C"       C'      I     `D._     `D._ "Qg_
      jQP`  .C    ,d^^b._      I      _.d^^b.   `D._ "Qg
     jQ^  .C"   /`   .+" \     I     / "+.   `\   `D.  XQ
    jQ'  .C'   |`  ."    )    _I    (     ".  |    `D.  4#
    Qf  .C     (   (    /    / /\    \     )  )     `D.  Qg
   jW   C'      \__\_.+'    / /  \    `+._/__/       `D  jQ
   Qf   C         C        /_/    \         D         D   Qk
   Qf   C      _  C        \_\____/         D  _      D   QF
   QL   C      \`+.__     _______     ______.+'/      D   QF
   B&   C.      \   \|    ||     |    ||      /       D   Qf
   jQ   `C.      \   |____|/     |____|/__   /      .D'   jW
    TQ   `C.      \._   `+.__________/___/|_/      .D'   jQ`
     9Q   `C.      C.`+._           |   |/.D'     .D'   jQ'
      "Qg  `C.     `C.   `"+-------'   ' .D'     .D'   pW`
       ^WQy `C.     `C.        I        .D'    _.D' yW"
         ^9Qy_`C.    `C.       I       .D'   _.D jgW"
            `9WQgC.__ `C.      I      .D'  _.Dp@@"`
               `""9WQQggyyyyyygyyyyyQggQWQH""
```

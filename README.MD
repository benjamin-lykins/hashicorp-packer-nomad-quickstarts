# Spooky Project Incoming

_Just to note: repository name is temporary and will to change._

This is still heavily WIP, but the goal of this repository is to provide a collection of Packer templates, Ansible playbooks, and related resources to streamline the creation and management of secure, production-ready images and infrastructure components.

The focus of this project is to be a quickstart to accelrate your building of Nomad Packer-Built images across multiple cloud providers.

I rather fit the needs of many users than try to make this a one-size-fits-all solution or a highly opinionated project - although there are certainly opinions baked in here.

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


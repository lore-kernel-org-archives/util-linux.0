Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51821 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab3C0WIE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:04 -0400
Received: by mail-wi0-f172.google.com with SMTP id hr17so2775048wib.17
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/10] [pull] bash-completion
Date: Wed, 27 Mar 2013 22:07:42 +0000
Message-Id: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here is a pull request, which does two things; an introduction of bash
completetion to util-linux, and most FIXME items ever sent to review in
single batch (26).

Most of the brokenness in this batch series has got to do with a comma
separate value list, e.g., 'value1,another,foobar', which one would
expect to continue filling with 'value1,<tab>' but that does not work.  I
am almost sure that one might achieve continue the list by setting comma
to COMP_WORDBREAKS, and check if $prev is in known words list, but I
simply did not get that to work (I suspect PEBKAC).

Some FIXME's are slightly more difficult to fix.  For example I do not
know how to get list of possible TERM values distribution agnostic way. 
And with 'wdctl' I have no how to determine flags.  Same goes for SELinux
labels & Apparmor provilles for setpriv.  Anyhow, if someone wants to
help, give hints, or even directly fix something feel free to reply the
later patches what could be done to an instance of a problem.

Of course any other sort of feedback is also welcome.


The following changes since commit 4cd271adc1dd3231e705c9e074491a7f49a721b8:

  libmount: make mnt_table_find_* more robust [coverity scan] (2013-03-27 16:47:46 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git shell-completion

for you to fetch changes up to e8b90f9baffd36a95bab408a3859b04543577a1b:

  bash-completion: add completion files to Makefile.am (2013-03-27 21:31:25 +0000)

----------------------------------------------------------------
Sami Kerola (10):
      bash-completion: add bash completetion configure option
      bash-completion: disk-utils
      bash-completion: fdisks
      bash-completion: login-utils
      bash-completion: misc-utils
      bash-completion: schedutils
      bash-completion: sys-utils
      bash-completion: term-utils
      bash-completion: text-utils
      bash-completion: add completion files to Makefile.am

 Documentation/TODO             |   6 -
 Makefile.am                    |   5 +
 configure.ac                   |  13 +++
 shell-completion/Makemodule.am | 260 +++++++++++++++++++++++++++++++++++++++++
 shell-completion/addpart       |  25 ++++
 shell-completion/agetty        |  70 +++++++++++
 shell-completion/blkdiscard    |  25 ++++
 shell-completion/blkid         |  62 ++++++++++
 shell-completion/blockdev      |  44 +++++++
 shell-completion/cal           |  15 +++
 shell-completion/cfdisk        |  31 +++++
 shell-completion/chcpu         |  44 +++++++
 shell-completion/chfn          |  31 +++++
 shell-completion/chrt          |  32 +++++
 shell-completion/chsh          |  23 ++++
 shell-completion/col           |  24 ++++
 shell-completion/colcrt        |  20 ++++
 shell-completion/colrm         |  23 ++++
 shell-completion/column        |  34 ++++++
 shell-completion/ctrlaltdel    |  11 ++
 shell-completion/cytune        |  37 ++++++
 shell-completion/delpart       |  19 +++
 shell-completion/dmesg         |  53 +++++++++
 shell-completion/eject         |  61 ++++++++++
 shell-completion/fallocate     |  24 ++++
 shell-completion/fdformat      |  11 ++
 shell-completion/fdisk         |  41 +++++++
 shell-completion/findmnt       | 114 ++++++++++++++++++
 shell-completion/flock         |  42 +++++++
 shell-completion/fsck          |  36 ++++++
 shell-completion/fsck.cramfs   |  18 +++
 shell-completion/fsck.minix    |  11 ++
 shell-completion/fsfreeze      |  18 +++
 shell-completion/fstrim        |  25 ++++
 shell-completion/getopt        |  34 ++++++
 shell-completion/hexdump       |  32 +++++
 shell-completion/hwclock       |  53 +++++++++
 shell-completion/ionice        |  34 ++++++
 shell-completion/ipcrm         |  52 +++++++++
 shell-completion/ipcs          |  30 +++++
 shell-completion/isosize       |  17 +++
 shell-completion/last          |  38 ++++++
 shell-completion/ldattach      |  54 +++++++++
 shell-completion/logger        |  43 +++++++
 shell-completion/login         |  27 +++++
 shell-completion/look          |  24 ++++
 shell-completion/losetup       |  64 ++++++++++
 shell-completion/lsblk         |  60 ++++++++++
 shell-completion/lscpu         |  39 +++++++
 shell-completion/lslocks       |  43 +++++++
 shell-completion/mcookie       |  23 ++++
 shell-completion/mesg          |  16 +++
 shell-completion/mkfs          |  25 ++++
 shell-completion/mkfs.bfs      |  28 +++++
 shell-completion/mkfs.cramfs   |  40 +++++++
 shell-completion/mkfs.minix    |  33 ++++++
 shell-completion/mkswap        |  36 ++++++
 shell-completion/more          |  22 ++++
 shell-completion/mountpoint    |  24 ++++
 shell-completion/namei         |  17 +++
 shell-completion/newgrp        |  16 +++
 shell-completion/nsenter       |  47 ++++++++
 shell-completion/partx         |  37 ++++++
 shell-completion/pg            |  29 +++++
 shell-completion/pivot_root    |  14 +++
 shell-completion/prlimit       |  55 +++++++++
 shell-completion/raw           |  17 +++
 shell-completion/readprofile   |  33 ++++++
 shell-completion/rename        |  27 +++++
 shell-completion/renice        |  38 ++++++
 shell-completion/resizepart    |  22 ++++
 shell-completion/rev           |  17 +++
 shell-completion/rtcwake       |  40 +++++++
 shell-completion/script        |  38 ++++++
 shell-completion/scriptreplay  |  28 +++++
 shell-completion/setarch       |  42 +++++++
 shell-completion/setpriv       |  82 +++++++++++++
 shell-completion/setsid        |  17 +++
 shell-completion/setterm       | 109 +++++++++++++++++
 shell-completion/sfdisk        |  72 ++++++++++++
 shell-completion/su            |  45 +++++++
 shell-completion/sulogin       |  24 ++++
 shell-completion/swaplabel     |  28 +++++
 shell-completion/swapon        |  48 ++++++++
 shell-completion/tailf         |  24 ++++
 shell-completion/taskset       |  38 ++++++
 shell-completion/tunelp        |  48 ++++++++
 shell-completion/ul            |  25 ++++
 shell-completion/unshare       |  24 ++++
 shell-completion/utmpdump      |  17 +++
 shell-completion/uuidd         |  33 ++++++
 shell-completion/uuidgen       |  15 +++
 shell-completion/wall          |  24 ++++
 shell-completion/wdctl         |  48 ++++++++
 shell-completion/whereis       |  24 ++++
 shell-completion/wipefs        |  38 ++++++
 shell-completion/write         |  19 +++
 97 files changed, 3512 insertions(+), 6 deletions(-)
 create mode 100644 shell-completion/Makemodule.am
 create mode 100644 shell-completion/addpart
 create mode 100644 shell-completion/agetty
 create mode 100644 shell-completion/blkdiscard
 create mode 100644 shell-completion/blkid
 create mode 100644 shell-completion/blockdev
 create mode 100644 shell-completion/cal
 create mode 100644 shell-completion/cfdisk
 create mode 100644 shell-completion/chcpu
 create mode 100644 shell-completion/chfn
 create mode 100644 shell-completion/chrt
 create mode 100644 shell-completion/chsh
 create mode 100644 shell-completion/col
 create mode 100644 shell-completion/colcrt
 create mode 100644 shell-completion/colrm
 create mode 100644 shell-completion/column
 create mode 100644 shell-completion/ctrlaltdel
 create mode 100644 shell-completion/cytune
 create mode 100644 shell-completion/delpart
 create mode 100644 shell-completion/dmesg
 create mode 100644 shell-completion/eject
 create mode 100644 shell-completion/fallocate
 create mode 100644 shell-completion/fdformat
 create mode 100644 shell-completion/fdisk
 create mode 100644 shell-completion/findmnt
 create mode 100644 shell-completion/flock
 create mode 100644 shell-completion/fsck
 create mode 100644 shell-completion/fsck.cramfs
 create mode 100644 shell-completion/fsck.minix
 create mode 100644 shell-completion/fsfreeze
 create mode 100644 shell-completion/fstrim
 create mode 100644 shell-completion/getopt
 create mode 100644 shell-completion/hexdump
 create mode 100644 shell-completion/hwclock
 create mode 100644 shell-completion/ionice
 create mode 100644 shell-completion/ipcrm
 create mode 100644 shell-completion/ipcs
 create mode 100644 shell-completion/isosize
 create mode 100644 shell-completion/last
 create mode 100644 shell-completion/ldattach
 create mode 100644 shell-completion/logger
 create mode 100644 shell-completion/login
 create mode 100644 shell-completion/look
 create mode 100644 shell-completion/losetup
 create mode 100644 shell-completion/lsblk
 create mode 100644 shell-completion/lscpu
 create mode 100644 shell-completion/lslocks
 create mode 100644 shell-completion/mcookie
 create mode 100644 shell-completion/mesg
 create mode 100644 shell-completion/mkfs
 create mode 100644 shell-completion/mkfs.bfs
 create mode 100644 shell-completion/mkfs.cramfs
 create mode 100644 shell-completion/mkfs.minix
 create mode 100644 shell-completion/mkswap
 create mode 100644 shell-completion/more
 create mode 100644 shell-completion/mountpoint
 create mode 100644 shell-completion/namei
 create mode 100644 shell-completion/newgrp
 create mode 100644 shell-completion/nsenter
 create mode 100644 shell-completion/partx
 create mode 100644 shell-completion/pg
 create mode 100644 shell-completion/pivot_root
 create mode 100644 shell-completion/prlimit
 create mode 100644 shell-completion/raw
 create mode 100644 shell-completion/readprofile
 create mode 100644 shell-completion/rename
 create mode 100644 shell-completion/renice
 create mode 100644 shell-completion/resizepart
 create mode 100644 shell-completion/rev
 create mode 100644 shell-completion/rtcwake
 create mode 100644 shell-completion/script
 create mode 100644 shell-completion/scriptreplay
 create mode 100644 shell-completion/setarch
 create mode 100644 shell-completion/setpriv
 create mode 100644 shell-completion/setsid
 create mode 100644 shell-completion/setterm
 create mode 100644 shell-completion/sfdisk
 create mode 100644 shell-completion/su
 create mode 100644 shell-completion/sulogin
 create mode 100644 shell-completion/swaplabel
 create mode 100644 shell-completion/swapon
 create mode 100644 shell-completion/tailf
 create mode 100644 shell-completion/taskset
 create mode 100644 shell-completion/tunelp
 create mode 100644 shell-completion/ul
 create mode 100644 shell-completion/unshare
 create mode 100644 shell-completion/utmpdump
 create mode 100644 shell-completion/uuidd
 create mode 100644 shell-completion/uuidgen
 create mode 100644 shell-completion/wall
 create mode 100644 shell-completion/wdctl
 create mode 100644 shell-completion/whereis
 create mode 100644 shell-completion/wipefs
 create mode 100644 shell-completion/write



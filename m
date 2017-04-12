Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36472 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdDLLxJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 12 Apr 2017 07:53:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so5897773wmd.3
        for <util-linux@vger.kernel.org>; Wed, 12 Apr 2017 04:53:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/42] pull: updates to bash completion files
Date: Wed, 12 Apr 2017 12:53:04 +0100
Message-Id: <20170412115304.8313-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

I sent couple bash completion file updates to mailing list, before realizing
there is more to do what is exactly the idea of this pull request.  I went
through all completion files, checked what has changed and updated nearly
half of them.  Sending this many patches by email to everyone is probably
not appriciated by anyone so please see the changes from my remote
repository instead.

https://github.com/kerolasa/lelux-utiliteetit/commits/bash-completion

----------------------------------------------------------------
The following changes since commit dddbfa4e9ba63fb731dd04f3b9c1ba18c57f5f69:
  agetty: various man-page fixes (2017-04-10 15:46:26 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git bash-completion
for you to fetch changes up to 85f435a601aabef8e1ef1f7c5f92c4d897b65461:
  bash-completion: new tool findfs (2017-04-12 12:39:51 +0100)
----------------------------------------------------------------

Sami Kerola (42):
  bash-completion: update hwclock
  bash-completion: update fincore
  bash-completion: update setterm
  bash-completion: update nsenter
  bash-completion: update fallocate
  bash-completion: new tool lsmem
  bash-completion: update lscpu
  bash-completion: update partx
  bash-completion: update blkdiscard
  bash-completion: update dmesg
  bash-completion: update fdformat
  bash-completion: update fdisk
  bash-completion: update flock
  bash-completion: fix fsck.cramfs
  bash-completion: update hexdump
  bash-completion: update ionice
  bash-completion: fix last
  bash-completion: update ldattach
  bash-completion: update logger
  bash-completion: update losetup
  bash-completion: update lsblk
  bash-completion: update lscpu
  bash-completion: update lsipc
  bash-completion: update lslocks
  bash-completion: update lsns
  bash-completion: update mcookie
  bash-completion: improve mkswap
  bash-completion: improve mount
  bash-completion: update mountpoint
  bash-completion: update nsenter
  bash-completion: update rtcwake
  bash-completion: update scriptreplay
  bash-completion: update setarch
  bash-completion: update setsid
  bash-completion: update sfdisk
  bash-completion: improve umount
  bash-completion: update unshare
  bash-completion: update wipefs
  bash-completion: improve write
  bash-completion: update zramctl
  bash-completion: new tool chmem
  bash-completion: new tool findfs

 bash-completion/Makemodule.am |  9 ++++++
 bash-completion/blkdiscard    | 13 ++++++--
 bash-completion/chmem         | 29 +++++++++++++++++
 bash-completion/dmesg         |  6 ++++
 bash-completion/fallocate     | 16 +++++++---
 bash-completion/fdformat      | 14 +++++++-
 bash-completion/fdisk         | 47 ++++++++++++++++++++++++---
 bash-completion/fincore       |  2 +-
 bash-completion/findfs        | 34 ++++++++++++++++++++
 bash-completion/flock         |  1 +
 bash-completion/fsck.cramfs   |  6 +++-
 bash-completion/hexdump       |  5 +++
 bash-completion/hwclock       |  4 +--
 bash-completion/ionice        | 14 +++++++-
 bash-completion/last          | 34 ++++++++++++++------
 bash-completion/ldattach      | 10 ++++++
 bash-completion/logger        |  6 ++++
 bash-completion/losetup       | 10 ++++--
 bash-completion/lsblk         | 20 ++++++------
 bash-completion/lscpu         |  4 ++-
 bash-completion/lsipc         | 74 +++++++++++++++++++++++--------------------
 bash-completion/lslocks       | 30 ++++++++----------
 bash-completion/lsmem         | 52 ++++++++++++++++++++++++++++++
 bash-completion/lsns          |  2 +-
 bash-completion/mcookie       |  6 +++-
 bash-completion/mkswap        |  6 +++-
 bash-completion/mount         | 31 ++++++++----------
 bash-completion/mountpoint    |  4 ---
 bash-completion/nsenter       | 19 +++++++++--
 bash-completion/partx         | 22 ++++++++++++-
 bash-completion/rtcwake       | 15 +++++++--
 bash-completion/scriptreplay  |  3 +-
 bash-completion/setarch       | 17 ++++++----
 bash-completion/setsid        |  2 +-
 bash-completion/setterm       |  1 +
 bash-completion/sfdisk        | 34 ++++++++++++++++++--
 bash-completion/umount        | 19 ++---------
 bash-completion/unshare       | 14 ++++++++
 bash-completion/wipefs        | 13 +++++++-
 bash-completion/write         |  8 ++---
 bash-completion/zramctl       |  4 ++-
 41 files changed, 503 insertions(+), 157 deletions(-)
 create mode 100644 bash-completion/chmem
 create mode 100644 bash-completion/findfs
 create mode 100644 bash-completion/lsmem

-- 
2.12.2


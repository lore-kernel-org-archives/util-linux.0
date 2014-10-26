Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:62611 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaJZWHP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 18:07:15 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so2494158wgh.19
        for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 15:07:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/4] pull: couple corrections and bash completion fixes
Date: Sun, 26 Oct 2014 22:07:05 +0000
Message-Id: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Weekends are too short.  When I were checking the bash completion for
swapoff works as expected I found the completion part works, but the
command does not, so the commit message is a little misleading; swap
files still cannot be turned off using uuids or labels.

# swapon --show=name,uuid,label
NAME                           UUID                                 LABEL
/dev/sda2                      37156738-8821-45cf-b3c2-4b884d58f08c foobar
/home/src/util-linux/test-swap bf6237f4-db89-4761-a1a3-275cfc68b114 xyzzy

# swapoff -U bf6237f4-db89-4761-a1a3-275cfc68b114 
swapoff: cannot find the device for bf6237f4-db89-4761-a1a3-275cfc68b114
# swapoff -L xyzzy 
swapoff: cannot find the device for xyzzy

The problem seems to come from swapoff.c function do_swapoff() call to
mnt_resolve_spec() that performs uuid and label matching only against
block devices.  Unfortunately this was as far I got with an attempt to
fix the issue.  Either someone else is quicker with the fix, or I'll have
a look of this sometime after next 5 days.

----------------------------------------------------------------
The following changes since commit 819d9a2975de6869f2ae12d551881bb9b732f2e4:

  include/debug: fix typo (2014-10-24 11:19:23 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk42

for you to fetch changes up to 1502d7e71f3385f3e358dd26cd22c4cd3eb7b35e:

  bash-completion: use swapon label and uuid listing support (2014-10-26 21:09:24 +0000)
----------------------------------------------------------------
Sami Kerola (4):
  sfdisk: return deterministic value from sfdisk_deinit()
  fstrim: initialize path variable
  bash-completion: stop being clever when listing block devices
  bash-completion: use swapon label and uuid listing support

 bash-completion/addpart    |  4 +---
 bash-completion/blkdiscard |  4 +---
 bash-completion/blkid      |  6 +-----
 bash-completion/blockdev   |  2 +-
 bash-completion/cfdisk     |  6 +-----
 bash-completion/delpart    |  6 +-----
 bash-completion/fdisk      | 12 ++----------
 bash-completion/fsck       |  3 +--
 bash-completion/fsck.minix |  3 +--
 bash-completion/lsblk      |  3 +--
 bash-completion/mkfs       |  3 +--
 bash-completion/mkfs.bfs   |  3 +--
 bash-completion/mkfs.minix |  3 +--
 bash-completion/partx      |  6 +-----
 bash-completion/resizepart |  6 +-----
 bash-completion/sfdisk     |  6 +-----
 bash-completion/swapoff    | 22 +++-------------------
 bash-completion/swapon     |  2 +-
 bash-completion/wipefs     |  4 +---
 disk-utils/sfdisk.c        |  3 +--
 sys-utils/fstrim.c         |  2 +-
 21 files changed, 24 insertions(+), 85 deletions(-)

-- 
2.1.2


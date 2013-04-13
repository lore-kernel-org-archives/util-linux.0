Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46768 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMTzI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:08 -0400
Received: by mail-wg0-f42.google.com with SMTP id k13so516118wgh.5
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/33] pull: bash completions, help screens, and file writing
Date: Sat, 13 Apr 2013 20:54:28 +0100
Message-Id: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel, and all,

I feel a bit like traitor.  Earlier the week I mentioned in irc I would
not send (much) changes before next release.  Then things changed.

There is the {u,}mount bash completion, which I promised to cover if
necessary.  Then some usage() long option changes which I found from my
earlier notes being missing, and few other small mostly harmless changes
and fixes.

The only 'feature' looking changes I recognize are the 0003 and 0006 so
spare a second of thinking whether that should be part of the next
release or not.

Same consideration is true for the write checks (0010 - 0033).  I am
pretty sure they work, but do have rc2 after all so perhaps such changes
should be postponed to next release.

Righty-ho, off I go for a week.  While feed back is welcome I cannot do
anything to these patches before Apr 22.  If changes are needed feel free
to mangle.


The following changes since commit 2d87a7dc844572a60648aa6c71a2c15240ba7ffc:

  libmount: add debug message to guess FS function (2013-04-12 15:04:57 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk14

for you to fetch changes up to daf6b7c168fd13d1737fd701671438f15f45dc6c:

  wall: check writing to a file descriptor was successful (2013-04-13 19:36:47 +0100)

----------------------------------------------------------------
Sami Kerola (33):
      bash-completion: add mount and umount
      blkid, hwclock, ldattach: use program_invocation_short_name
      utmpdump: add option to write to a file
      cfdisk: add long options to the command
      bash-completion: prefer bash 3.x 'here string' syntax
      setpriv: allow login and group name option arguments
      build-sys: add --disable-setterm to ./configure
      hexdump: add long options to the command
      setsid: exit when control terminal cannot be set
      cfdisk: check writing to a file was successful
      setpriv: check writing to a file was successful
      agetty: check writing to a file was successful
      pg: check writing to a file was successful
      libblkid: check writing to a file was successful
      libmount: check writing to a file was successful
      include: add close_fd() for noticing write errors before close()
      fdformat: check writing to a file descriptor was successful
      partx: check writing to a file descriptor was successful
      resizepart: check writing to a file descriptor was successful
      cfdisk: check writing to a file descriptor was successful
      sfdisk: check writing to a file descriptor was successful
      wdctl: check writing to a file descriptor was successful
      fsck.cramfs: check writing to a file descriptor was successful
      fsck.minix: check writing to a file descriptor was successful
      mkfs.bfs: check writing to a file descriptor was successful
      mkfs.cramfs: unify write check to a file descriptor
      mkfs.minix: check writing to a file descriptor was successful
      mkswap: unify write check to a file descriptor
      swaplabel: check writing to a file descriptor was successful
      fallocate: check writing to a file descriptor was successful
      setpriv: check writing to a file descriptor was successful
      swapon: check writing to a file descriptor was successful
      wall: check writing to a file descriptor was successful

 bash-completion/addpart    |  2 +-
 bash-completion/blkdiscard |  2 +-
 bash-completion/blkid      |  2 +-
 bash-completion/blockdev   |  2 +-
 bash-completion/cfdisk     | 24 +++++++++---
 bash-completion/delpart    |  2 +-
 bash-completion/fdisk      |  4 +-
 bash-completion/findmnt    |  2 +-
 bash-completion/fsck       |  2 +-
 bash-completion/fsck.minix |  2 +-
 bash-completion/hexdump    | 22 ++++++++---
 bash-completion/lsblk      |  2 +-
 bash-completion/mkfs       |  2 +-
 bash-completion/mkfs.bfs   |  2 +-
 bash-completion/mkfs.minix |  2 +-
 bash-completion/mount      | 87 +++++++++++++++++++++++++++++++++++++++++
 bash-completion/partx      |  2 +-
 bash-completion/resizepart |  2 +-
 bash-completion/sfdisk     |  2 +-
 bash-completion/umount     | 60 ++++++++++++++++++++++++++++
 bash-completion/utmpdump   |  2 +-
 bash-completion/wipefs     |  2 +-
 configure.ac               |  6 +++
 disk-utils/fdformat.c      |  3 +-
 disk-utils/fsck.cramfs.c   |  3 +-
 disk-utils/fsck.minix.c    |  2 +
 disk-utils/mkfs.bfs.c      |  2 +-
 disk-utils/mkfs.cramfs.c   |  5 +--
 disk-utils/mkfs.minix.c    |  3 +-
 disk-utils/mkswap.c        | 16 ++++----
 disk-utils/partx.c         |  4 +-
 disk-utils/resizepart.c    |  5 +++
 disk-utils/swaplabel.c     |  5 ++-
 fdisks/cfdisk.8            | 18 ++++-----
 fdisks/cfdisk.c            | 97 ++++++++++++++++++++++++++++++----------------
 fdisks/sfdisk.c            | 30 ++++++++++----
 include/closestream.h      | 19 +++++++++
 libblkid/src/evaluate.c    |  4 +-
 libblkid/src/save.c        |  7 +++-
 libmount/src/lock.c        |  4 +-
 login-utils/utmpdump.1     |  4 +-
 login-utils/utmpdump.c     | 92 +++++++++++++++++++++++++------------------
 misc-utils/blkid.c         |  4 +-
 sys-utils/fallocate.c      |  3 +-
 sys-utils/hwclock.h        |  1 -
 sys-utils/ldattach.c       |  3 --
 sys-utils/setpriv.1        |  6 ++-
 sys-utils/setpriv.c        | 51 +++++++++++++++++-------
 sys-utils/setsid.c         |  2 +-
 sys-utils/swapon.c         |  5 ++-
 sys-utils/wdctl.c          |  6 ++-
 term-utils/Makemodule.am   |  3 +-
 term-utils/agetty.c        | 11 +++++-
 term-utils/ttymsg.c        |  4 +-
 text-utils/hexdump.1       | 24 ++++++------
 text-utils/hexsyntax.c     | 61 +++++++++++++++++++----------
 text-utils/pg.c            |  9 ++++-
 57 files changed, 547 insertions(+), 206 deletions(-)
 create mode 100644 bash-completion/mount
 create mode 100644 bash-completion/umount



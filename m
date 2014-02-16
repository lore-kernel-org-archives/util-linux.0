Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44026 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaBPPXD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 10:23:03 -0500
Received: by mail-wg0-f43.google.com with SMTP id a1so1595926wgh.10
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 07:23:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/4] pull: allow disabling command builds
Date: Sun, 16 Feb 2014 15:22:52 +0000
Message-Id: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and distribution maintainers,

This pull request has four patches that will allow a builder to disable
all commands.  The Documentation/howto-build-sys.txt is telling
distribution package maintainers are not supposed to run config-gen.
IMHO it might be best to ignore that advice when only library build is
needed, and run the following.

  tools/config-gen libs-only

The last patch makes the tests not to fail when commands are not
compiled.  That said there the tests are currently broken (at least in my
laptop).  Commit c367cda9 did not take effect, something again ate
trailing white spaces again, and 'blkid/lowprobe-pt sgi' has two extra
lines in output.

I hope these changes make bootstraping nicer, but if not let me know how
to improve this.


The following changes since commit 24b2a479fd5ba138e9b836fa2115939eb3b59dfe:

  fallocate: Add "--dig-holes" option (2014-02-14 11:31:12 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git disable-most

for you to fetch changes up to dc8ba4a3d89355761bf321af0d877f70d3afbd5a:

  tests: check commands needed for running a test exist (2014-02-16 15:07:13 +0000)

----------------------------------------------------------------
Sami Kerola (4):
      build-sys: allow per directory build targets
      build-sys: add libs-only to config-gen.d
      tools: make config-gen to require build target argument
      tests: check commands needed for running a test exist

 configure.ac                          | 65 ++++++++++++++++++++++++++++++-----
 disk-utils/Makemodule.am              |  3 ++
 fdisks/Makemodule.am                  |  3 ++
 login-utils/Makemodule.am             |  3 ++
 misc-utils/Makemodule.am              |  3 ++
 sys-utils/Makemodule.am               |  3 ++
 term-utils/Makemodule.am              |  3 ++
 tests/functions.sh                    | 10 ++++--
 tests/ts/bitops/swapbytes             |  2 ++
 tests/ts/blkid/low-probe              |  4 +--
 tests/ts/blkid/lowprobe-pt            |  4 +--
 tests/ts/blkid/md-raid0-whole         |  4 +++
 tests/ts/blkid/md-raid1-part          |  4 +++
 tests/ts/blkid/md-raid1-whole         |  4 +++
 tests/ts/cal/1m                       |  2 ++
 tests/ts/cal/1mw                      |  2 ++
 tests/ts/cal/3m                       |  2 ++
 tests/ts/cal/3mw                      |  2 ++
 tests/ts/cal/bigyear                  |  2 ++
 tests/ts/cal/bigyearw                 |  2 ++
 tests/ts/cal/color                    |  2 ++
 tests/ts/cal/colorw                   |  2 ++
 tests/ts/cal/sep1752                  |  2 ++
 tests/ts/cal/sep1752w                 |  2 ++
 tests/ts/cal/weekarg                  |  2 ++
 tests/ts/cal/weeknum                  |  4 ++-
 tests/ts/cal/year                     |  2 ++
 tests/ts/cal/yearw                    |  2 ++
 tests/ts/col/multibyte                |  2 ++
 tests/ts/colrm/rm2-2                  |  2 ++
 tests/ts/column/fillrow               |  2 ++
 tests/ts/column/multi-file            |  4 ++-
 tests/ts/column/separator_table       |  2 ++
 tests/ts/cramfs/doubles               |  5 +++
 tests/ts/cramfs/fsck-endianness       |  4 +++
 tests/ts/cramfs/mkfs                  |  6 ++++
 tests/ts/cramfs/mkfs-endianness       |  3 ++
 tests/ts/dmesg/console-levels         |  2 ++
 tests/ts/dmesg/decode                 |  2 ++
 tests/ts/dmesg/delta                  |  2 ++
 tests/ts/dmesg/facilities             |  2 ++
 tests/ts/eject/umount                 |  8 +++--
 tests/ts/fdisk/align-512-4K           |  3 ++
 tests/ts/fdisk/align-512-4K-63        |  3 ++
 tests/ts/fdisk/align-512-4K-md        |  3 ++
 tests/ts/fdisk/align-512-512          |  3 ++
 tests/ts/fdisk/align-512-512-topology |  3 ++
 tests/ts/fdisk/bsd                    |  4 ++-
 tests/ts/fdisk/gpt                    |  4 ++-
 tests/ts/fdisk/id                     |  2 ++
 tests/ts/fdisk/mbr-dos-mode           |  2 ++
 tests/ts/fdisk/mbr-nondos-mode        |  6 ++--
 tests/ts/fdisk/oddinput               |  2 ++
 tests/ts/fdisk/sunlabel               |  2 ++
 tests/ts/fsck/ismounted               |  4 +++
 tests/ts/hexdump/format-strings       |  2 +-
 tests/ts/hwclock/systohc              |  3 ++
 tests/ts/ipcs/headers                 |  2 ++
 tests/ts/ipcs/limits                  |  3 ++
 tests/ts/ipcs/limits2                 |  3 ++
 tests/ts/ipcs/mk-rm-msg               |  4 +++
 tests/ts/ipcs/mk-rm-sem               |  4 +++
 tests/ts/ipcs/mk-rm-shm               |  4 +++
 tests/ts/isosize/print-size           |  2 ++
 tests/ts/last/ipv6                    |  2 +-
 tests/ts/last/last                    |  2 +-
 tests/ts/libmount/context             |  7 +++-
 tests/ts/libmount/context-py          |  6 ++++
 tests/ts/libmount/context-utab        |  4 +++
 tests/ts/libmount/context-utab-py     |  5 +++
 tests/ts/login/islocal                |  2 ++
 tests/ts/login/logindefs              |  2 ++
 tests/ts/look/separator               |  2 ++
 tests/ts/losetup/losetup              |  3 ++
 tests/ts/lscpu/lscpu                  |  4 ++-
 tests/ts/minix/fsck                   |  5 +--
 tests/ts/minix/mkfs                   |  5 +--
 tests/ts/misc/fallocate               |  2 ++
 tests/ts/misc/getopt                  |  2 ++
 tests/ts/misc/ionice                  |  2 ++
 tests/ts/misc/line                    |  4 +--
 tests/ts/misc/mcookie                 |  2 ++
 tests/ts/misc/rev                     |  2 ++
 tests/ts/misc/setarch                 |  2 ++
 tests/ts/misc/setsid                  |  2 ++
 tests/ts/misc/ul                      |  2 ++
 tests/ts/misc/whereis                 |  2 ++
 tests/ts/more/regexp                  |  2 ++
 tests/ts/more/squeeze                 |  2 ++
 tests/ts/mount/devname                |  4 +++
 tests/ts/mount/fstab-broken           |  5 +++
 tests/ts/mount/fstab-devname          |  4 +++
 tests/ts/mount/fstab-devname2label    |  4 +++
 tests/ts/mount/fstab-devname2uuid     |  4 +++
 tests/ts/mount/fstab-label            |  4 +++
 tests/ts/mount/fstab-label2devname    |  4 +++
 tests/ts/mount/fstab-label2uuid       |  4 +++
 tests/ts/mount/fstab-none             |  5 +++
 tests/ts/mount/fstab-symlink          |  4 +++
 tests/ts/mount/fstab-uuid             |  4 +++
 tests/ts/mount/fstab-uuid2devname     |  4 +++
 tests/ts/mount/fstab-uuid2label       |  4 +++
 tests/ts/mount/label                  |  4 +++
 tests/ts/mount/move                   |  5 +++
 tests/ts/mount/noncanonical           |  3 ++
 tests/ts/mount/paths                  |  3 ++
 tests/ts/mount/regfile                |  4 +++
 tests/ts/mount/remount                |  4 +++
 tests/ts/mount/rlimit                 |  4 +++
 tests/ts/mount/shared-subtree         |  5 +++
 tests/ts/mount/special                |  3 ++
 tests/ts/mount/umount-alltargets      |  5 +++
 tests/ts/mount/umount-recursive       |  5 +++
 tests/ts/mount/uuid                   |  4 +++
 tests/ts/namei/logic                  |  2 ++
 tests/ts/partx/partx                  |  7 ++--
 tests/ts/schedutils/cpuset            |  2 ++
 tests/ts/script/race                  |  2 ++
 tests/ts/swapon/devname               |  5 +++
 tests/ts/swapon/fixpgsz               |  5 +++
 tests/ts/swapon/fixsig                |  5 +++
 tests/ts/swapon/label                 |  5 +++
 tests/ts/swapon/uuid                  |  5 +++
 tests/ts/tailf/simple                 |  2 ++
 tests/ts/utmpdump/ipv6tobin           |  2 ++
 tests/ts/utmpdump/ipv6totxt           |  2 ++
 tests/ts/utmpdump/to-binary           |  2 ++
 tests/ts/utmpdump/to-text             |  2 ++
 tests/ts/wipefs/wipefs                |  2 ++
 text-utils/Makemodule.am              |  2 ++
 tools/config-gen                      |  9 +++++
 tools/config-gen.d/libs-only.conf     | 10 ++++++
 132 files changed, 470 insertions(+), 38 deletions(-)
 create mode 100644 tools/config-gen.d/libs-only.conf

-- 
Sami Kerola
http://www.iki.fi/kerolasa/


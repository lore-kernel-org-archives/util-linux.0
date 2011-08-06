Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52371 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab1HFR5z convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Aug 2011 13:57:55 -0400
Received: by qyk34 with SMTP id 34so948955qyk.19
        for <util-linux@vger.kernel.org>; Sat, 06 Aug 2011 10:57:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sat, 6 Aug 2011 19:57:53 +0200
Message-ID: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
Subject: [git pull] documentation directory
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit d1a1e0b71601d88a6157c35caf9184a5aa7b978c:

  docs: remove README.namei (2011-08-02 14:30:52 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit docs-dir

I would not be surprised that these changes would require a bit of
discussion, and few rejects, before the Documentation/ is done to
upstream. For instance you might disagree with contents of
00-about-docs.txt, and perhaps example.files/ should be deleted.

Sami Kerola (4):
      docs: remove README.clear
      docs: Documentation directory added
      docs: add usage() howto for contributors
      docs: tell what the Documentation/ is about

 Documentation/00-about-docs.txt                    |   29 ++++++++
 README.devel => Documentation/README.devel         |    0
 .../ReleaseNotes}/v2.13-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.14-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.15-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.16-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.17-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.18-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.19-ReleaseNotes               |    0
 .../ReleaseNotes}/v2.20-ReleaseNotes               |    0
 TODO => Documentation/TODO                         |    3 +-
 libblkid/README.blkid => Documentation/blkid.txt   |    0
 misc-utils/README.cal => Documentation/cal.txt     |    0
 fdisk/README.cfdisk => Documentation/cfdisk.txt    |    0
 text-utils/README.col => Documentation/col.txt     |    0
 misc-utils/README.ddate => Documentation/ddate.txt |    0
 DEPRECATED => Documentation/deprecated.txt         |    0
 .../example.files}/filesystems                     |    0
 .../example.files}/fstab                           |    0
 .../example.files}/inittab                         |    0
 .../example.files}/issue                           |    0
 .../example.files}/issue0                          |    0
 .../example.files}/motd                            |    0
 .../example.files}/securetty                       |    0
 .../example.files}/shells                          |    0
 .../example.files}/udev-raw.rules                  |    0
 fdisk/README.fdisk => Documentation/fdisk.txt      |    0
 getopt/README => Documentation/getopt.txt          |    0
 .../getopt_changelog.txt                           |    0
 .../README.hwclock => Documentation/hwclock.txt    |    0
 {licenses => Documentation/licenses}/COPYING.GPL   |    0
 {licenses => Documentation/licenses}/COPYING.UCB   |    0
 .../licenses/COPYING.getopt                        |    0
 .../licenses}/COPYING.libblkid                     |    0
 .../licenses}/COPYING.libmount                     |    0
 .../licenses}/COPYING.libuuid                      |    0
 {text-utils => Documentation/licenses}/LICENSE.pg  |    0
 README.licensing => Documentation/licensing.txt    |    0
 .../modems-with-agetty.txt                         |    0
 mount/README.mount => Documentation/mount.txt      |    0
 text-utils/README.pg => Documentation/pg.txt       |    0
 .../README.poeigl => Documentation/poeigl.txt      |    0
 fdisk/sfdisk.examples => Documentation/sfdisk.txt  |    0
 tests/README => Documentation/tests.txt            |    0
 Documentation/usage-howto.txt                      |   73 ++++++++++++++++++++
 Makefile.am                                        |    8 +--
 fdisk/Makefile.am                                  |    2 +-
 getopt/Makefile.am                                 |    3 -
 hwclock/Makefile.am                                |    2 -
 libblkid/Makefile.am                               |    2 +-
 libmount/Makefile.am                               |    2 +-
 libuuid/Makefile.am                                |    2 +-
 login-utils/Makefile.am                            |    2 -
 misc-utils/Makefile.am                             |    2 -
 mount/Makefile.am                                  |    2 -
 term-utils/Makefile.am                             |    4 +-
 tests/Makefile.am                                  |    1 -
 text-utils/Makefile.am                             |    4 -
 text-utils/README.clear                            |    7 --
 59 files changed, 109 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/00-about-docs.txt
 rename README.devel => Documentation/README.devel (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.13-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.14-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.15-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.16-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.17-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.18-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.19-ReleaseNotes (100%)
 rename {docs => Documentation/ReleaseNotes}/v2.20-ReleaseNotes (100%)
 rename TODO => Documentation/TODO (99%)
 rename libblkid/README.blkid => Documentation/blkid.txt (100%)
 rename misc-utils/README.cal => Documentation/cal.txt (100%)
 rename fdisk/README.cfdisk => Documentation/cfdisk.txt (100%)
 rename text-utils/README.col => Documentation/col.txt (100%)
 rename misc-utils/README.ddate => Documentation/ddate.txt (100%)
 rename DEPRECATED => Documentation/deprecated.txt (100%)
 rename {example.files => Documentation/example.files}/filesystems (100%)
 rename {example.files => Documentation/example.files}/fstab (100%)
 rename {example.files => Documentation/example.files}/inittab (100%)
 rename {example.files => Documentation/example.files}/issue (100%)
 rename {example.files => Documentation/example.files}/issue0 (100%)
 rename {example.files => Documentation/example.files}/motd (100%)
 rename {example.files => Documentation/example.files}/securetty (100%)
 rename {example.files => Documentation/example.files}/shells (100%)
 rename {example.files => Documentation/example.files}/udev-raw.rules (100%)
 rename fdisk/README.fdisk => Documentation/fdisk.txt (100%)
 rename getopt/README => Documentation/getopt.txt (100%)
 rename getopt/Changelog => Documentation/getopt_changelog.txt (100%)
 rename hwclock/README.hwclock => Documentation/hwclock.txt (100%)
 rename {licenses => Documentation/licenses}/COPYING.GPL (100%)
 rename {licenses => Documentation/licenses}/COPYING.UCB (100%)
 rename getopt/COPYING => Documentation/licenses/COPYING.getopt (100%)
 rename {libblkid => Documentation/licenses}/COPYING.libblkid (100%)
 rename {libmount => Documentation/licenses}/COPYING.libmount (100%)
 rename {libuuid => Documentation/licenses}/COPYING.libuuid (100%)
 rename {text-utils => Documentation/licenses}/LICENSE.pg (100%)
 rename README.licensing => Documentation/licensing.txt (100%)
 rename term-utils/README.modems-with-agetty =>
Documentation/modems-with-agetty.txt (100%)
 rename mount/README.mount => Documentation/mount.txt (100%)
 rename text-utils/README.pg => Documentation/pg.txt (100%)
 rename login-utils/README.poeigl => Documentation/poeigl.txt (100%)
 rename fdisk/sfdisk.examples => Documentation/sfdisk.txt (100%)
 rename tests/README => Documentation/tests.txt (100%)
 create mode 100644 Documentation/usage-howto.txt
 delete mode 100644 text-utils/README.clear

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

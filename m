Return-Path: mtk.manpages@gmail.com
Cc: mtk.manpages@gmail.com, util-linux@vger.kernel.org
To: Karel Zak <kzak@redhat.com>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [pull request] trivial fixes
Message-ID: <8036e422-1456-9db7-68db-53a6fa5a4c87@gmail.com>
Date: Wed, 7 Dec 2016 14:30:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

These are trivial patches, so I submit them as a pull request.
Some changes are individual fixes to pages. Others ("various pages")
are global fixes, to achieve greater consistency.

Two further patches to renice(1) follow. These make substantive
changes to content, and I will post the patches to the list.

Thanks,

Michael

The following changes since commit 1c4b2d43926e2a7032310cd18b411d8d872cb4ed:

  sulogin: bail out from getpasswd(...) on timeout (2016-12-07 13:32:42 +0100)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/mtk/util-linux.git doc_fixes

for you to fetch changes up to f7667ba788f2600c75abc3eec7963b5f51ad4b46:

  docs: renice(1): Typo fix (2016-12-07 14:22:41 +0100)

----------------------------------------------------------------
Michael Kerrisk (16):
      docs: various pages: Format pathnames as italic (.I)
      docs: various pages: Use consistent terminology (set-user-ID and set-group-ID)
      docs: various pages: Use "ID" not "id" in man pages
      docs: various pages: Use "PID" not "pid" in man-pages
      docs: various pages: Use 'UID" and "GID", not "uid" and "gid" in man pages
      docs: kill(1): Wording fix
      docs: namei(1): SEE ALSO: add symlink(7)
      docs: taskset(1): Wording fix
      docs: last(1): SEE ALSO: add reference to wtmp(5)
      docs: last(1): Eliminate oddball formatting
      docs: lsns(8): SEE ALSO: add namespaces(7)
      docs: ionice(1): SEE ALSO: add ioprio_set(2)
      docs: mount(8): Wording fix
      docs: renice(1): Add SEE ALSO entry for sched(7)
      docs: renice(1): Add credentials(7) to SEE ALSO
      docs: renice(1): Typo fix

 disk-utils/cfdisk.8     |  2 +-
 disk-utils/fsck.8       | 12 ++++++------
 lib/terminal-colors.d.5 |  6 +++---
 login-utils/chfn.1      |  2 +-
 login-utils/last.1      | 13 +++++++------
 login-utils/login.1     |  6 +++---
 login-utils/runuser.1   |  2 +-
 login-utils/su.1        |  3 ++-
 login-utils/sulogin.8   |  2 +-
 misc-utils/getopt.1     |  4 ++--
 misc-utils/kill.1       | 16 ++++++++--------
 misc-utils/lsblk.8      |  2 +-
 misc-utils/namei.1      |  3 ++-
 misc-utils/whereis.1    |  6 +++---
 schedutils/ionice.1     |  2 ++
 schedutils/taskset.1    |  2 +-
 sys-utils/fstab.5       |  2 +-
 sys-utils/lsns.8        |  3 ++-
 sys-utils/mount.8       | 40 +++++++++++++++++++++-------------------
 sys-utils/prlimit.1     |  2 +-
 sys-utils/readprofile.8 | 14 +++++++-------
 sys-utils/renice.1      |  8 +++++---
 sys-utils/setpriv.1     | 10 ++++++----
 sys-utils/umount.8      |  6 +++---
 sys-utils/unshare.1     |  2 +-
 term-utils/agetty.8     | 10 +++++-----
 term-utils/wall.1       |  5 +++--
 27 files changed, 99 insertions(+), 86 deletions(-)


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

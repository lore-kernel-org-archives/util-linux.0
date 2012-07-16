Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:56052 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752199Ab2GPRoN (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 13:44:13 -0400
Subject: Re: [pull] static analysis, and help to translator
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Jul 2012 19:44:09 +0200
Message-ID: <1342460649.2643.3.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2012-07-15 at 22:40 +0200, Sami Kerola wrote:
> Hello,
> 
> Next release is apparently just round corner.  This series of changes
> are results of running clang, smatch and cppcheck.  Last four patches
> has tons of message changes, which translators hopefully appreciate,
> but made sending a diff feel bit extensive (more than 1000 lines long).
> If you are interested to check an individual patch quickly have a look
> of the github web gui.
> 
> https://github.com/kerolasa/lelux-utiliteetit/commits/2012wk28
> 
> 
> The following changes since commit 2e7035646eb85851171cc2e989bfa858a4f00cd4:
> 
>   login: close tty before vhangup() (2012-07-12 16:35:01 +0200)
> 
> are available in the git repository at:
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git 2012wk28
> 
> for you to fetch changes up to 8b59a0c3764fa23aa66cf71bb5334cc23d736c60:
> 
>   translation: unify file open error messages (2012-07-15 10:39:57 +0200)
> 

Sami, this breaks regression test scripts; please be sure to always run
them when making general changes across all utils.

Thanks,
Davidlohr

> ----------------------------------------------------------------
> Sami Kerola (13):
>       build-sys: reduce warning noise when compiling with clang
>       libblkid: remove duplicate entries in symbols
>       lib/pager: minor compiler warning fixes
>       findmnt: add missing initializer
>       lib/loopdev: minor bug fix: add missing semicolon
>       swapon: remove unused variables
>       utmpdump: remove unused variable
>       look: remove extra semicolon
>       fdisk: make if clause easier to read
>       su: align with howto-usage-function
>       utmpdump: use help and version output macros
>       translation: unify stat error messages
>       translation: unify file open error messages
> 
>  configure.ac              | 28 +++++++++++++++++++++++---
>  disk-utils/addpart.c      |  2 +-
>  disk-utils/delpart.c      |  2 +-
>  disk-utils/fdformat.c     |  6 +++---
>  disk-utils/fsck.c         |  2 +-
>  disk-utils/fsck.cramfs.c  |  6 +++---
>  disk-utils/fsck.minix.c   |  2 +-
>  disk-utils/isosize.c      |  2 +-
>  disk-utils/mkfs.bfs.c     |  2 +-
>  disk-utils/mkfs.cramfs.c  |  6 +++---
>  disk-utils/mkfs.minix.c   |  4 ++--
>  disk-utils/partx.c        |  4 ++--
>  disk-utils/swaplabel.c    |  2 +-
>  fdisks/cfdisk.c           |  6 +++---
>  fdisks/fdisk.c            | 41 +++++++++++++++++++------------------
>  lib/at.c                  |  2 +-
>  lib/loopdev.c             |  2 +-
>  lib/pager.c               |  4 +++-
>  lib/path.c                |  4 ++--
>  libblkid/src/blkid.sym    |  2 --
>  login-utils/islocal.c     |  3 +--
>  login-utils/last.c        |  2 +-
>  login-utils/su.c          | 51 +++++++++++++++++++++++------------------------
>  login-utils/sulogin.c     |  8 ++++----
>  login-utils/utmpdump.c    | 13 ++++++------
>  login-utils/vipw.c        |  2 +-
>  misc-utils/findmnt.c      | 42 +++++++++++++++++++-------------------
>  misc-utils/look.c         |  2 +-
>  misc-utils/mcookie.c      |  4 ++--
>  misc-utils/namei.c        |  2 +-
>  sys-utils/dmesg.c         |  4 ++--
>  sys-utils/eject.c         |  4 ++--
>  sys-utils/fallocate.c     |  2 +-
>  sys-utils/fsfreeze.c      |  4 ++--
>  sys-utils/fstrim.c        |  4 ++--
>  sys-utils/hwclock-cmos.c  |  2 +-
>  sys-utils/hwclock-rtc.c   | 10 +++++-----
>  sys-utils/hwclock.c       |  2 +-
>  sys-utils/losetup.c       |  2 +-
>  sys-utils/rtcwake.c       |  6 +++---
>  sys-utils/swapon.c        |  7 +++----
>  sys-utils/switch_root.c   |  6 +++---
>  sys-utils/wdctl.c         |  2 +-
>  term-utils/mesg.c         |  2 +-
>  term-utils/script.c       |  6 +++---
>  term-utils/scriptreplay.c |  4 ++--
>  term-utils/wall.c         |  4 ++--
>  text-utils/pg.c           |  2 +-
>  text-utils/rev.c          |  2 +-
>  text-utils/tailf.c        |  8 ++++----
>  text-utils/ul.c           |  2 +-
>  51 files changed, 180 insertions(+), 163 deletions(-)
> 



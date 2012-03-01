Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55260 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965724Ab2CAVvG convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 1 Mar 2012 16:51:06 -0500
Received: by obbuo6 with SMTP id uo6so892559obb.19
        for <util-linux@vger.kernel.org>; Thu, 01 Mar 2012 13:51:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk1kMB9Mw46T3Lb0DBttqDOrHU0JBTkSERd7rfL8ikvH8A@mail.gmail.com>
References: <20120229154420.GD8471@x2.net.home>
	<CAG27Bk1kMB9Mw46T3Lb0DBttqDOrHU0JBTkSERd7rfL8ikvH8A@mail.gmail.com>
Date: Thu, 1 Mar 2012 22:51:05 +0100
Message-ID: <CAG27Bk0ZtUj0-7Jr4VKaQ++YzKzeqhVQsOQzYwkBPGWV1pan-A@mail.gmail.com>
Subject: Re: v2.22 wish list
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: mail list.

<sigh> why gmail does not alarm before sending, something like with
attachments, 'it seems you are replying only to person who send the
mail, did you mean replying to all?'

On Thu, Mar 1, 2012 at 22:47, Sami Kerola <kerolasa@iki.fi> wrote:
> On Wed, Feb 29, 2012 at 16:44, Karel Zak <kzak@redhat.com> wrote:
>> This is my v2.22 wish list. The list contains large/invasive tasks only.
>> Comments, volunteers, .... ? ;-)
> [snip]
>>  * non-recursive build-system (now many files from lib/ are compileted
>>   more than once), see:
>>   http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
>
> Hi Karel,
>
> I gave a try to non-recursive build, and getting it to work took a bit
> work meaning changes here and there. I think the preview version below
> does what was asked, but in all honesty it is not ready be merged. The
> change needs to be split to reasonable chunks (now single big commit).
> Consider this as preview version. Please let me know if this looks
> good, and comments from also other than Karel are welcome. Assuming
> I'm on right track I'll finalize the patches before May.
>
>
> The following changes since commit 04f087eced451ba00ac0cf1d9b101e3c6c7a322d:
>
>  mountpoint: fix a minor bug with 0:0 devno (2012-02-29 14:53:31 +0100)
>
> are available in the git repository at:
>
>  git://github.com/kerolasa/lelux-utiliteetit.git non-rec-build
>
> for you to fetch changes up to c016b9e1bd300d6346c31e524de7b73455289aa4:
>
>  build-sys: make build non-recursive (2012-03-01 22:36:40 +0100)
>
> ----------------------------------------------------------------
> Sami Kerola (1):
>      build-sys: make build non-recursive
>
>  Makefile.am                  |    5 +-
>  config/include-Makefile.am   |    8 ---
>  configure.ac                 |    2 +-
>  disk-utils/Makefile.am       |   82 ++++++++++-------------
>  fdisk/Makefile.am            |   29 ++++----
>  fsck/Makefile.am             |    5 +-
>  hwclock/Makefile.am          |    5 +-
>  lib/.gitignore               |   14 +++-
>  lib/Makefile.am              |   81 +++++++++++++++--------
>  lib/at.c                     |   43 ------------
>  lib/blkdev.c                 |   38 -----------
>  lib/canonicalize.c           |   16 -----
>  lib/cpuset.c                 |   77 ----------------------
>  lib/ismounted.c              |   25 -------
>  lib/loopdev.c                |  149 ------------------------------------------
>  lib/mangle.c                 |   34 ----------
>  lib/procutils.c              |   28 --------
>  lib/strutils.c               |   28 --------
>  lib/sysfs.c                  |   58 ----------------
>  lib/test_at.c                |   43 ++++++++++++
>  lib/test_blkdev.c            |   39 +++++++++++
>  lib/test_canonicalize.c      |   15 +++++
>  lib/test_cpuset.c            |   78 ++++++++++++++++++++++
>  lib/test_ismounted.c         |   25 +++++++
>  lib/test_loopdev.c           |  145 ++++++++++++++++++++++++++++++++++++++++
>  lib/test_mangle.c            |   33 ++++++++++
>  lib/test_procutils.c         |   27 ++++++++
>  lib/test_strutils.c          |   26 ++++++++
>  lib/test_sysfs.c             |   56 ++++++++++++++++
>  lib/test_tt.c                |   92 ++++++++++++++++++++++++++
>  lib/test_wholedisk.c         |   13 ++++
>  lib/tt.c                     |   90 -------------------------
>  lib/wholedisk.c              |   14 ----
>  libblkid/docs/Makefile.am    |    2 +-
>  libblkid/samples/Makefile.am |    2 +-
>  libblkid/src/Makefile.am     |   24 +++----
>  libmount/docs/Makefile.am    |    2 +-
>  libmount/src/Makefile.am     |   22 +++----
>  login-utils/Makefile.am      |   12 ++--
>  misc-utils/Makefile.am       |   72 +++++++-------------
>  mount/Makefile.am            |   24 ++-----
>  partx/Makefile.am            |   14 +---
>  schedutils/Makefile.am       |   14 ++--
>  sys-utils/Makefile.am        |   77 +++++++---------------
>  term-utils/Makefile.am       |    4 +-
>  tests/helpers/Makefile.am    |    3 +-
>  text-utils/Makefile.am       |   16 +++--
>  47 files changed, 820 insertions(+), 891 deletions(-)
>  create mode 100644 lib/test_at.c
>  create mode 100644 lib/test_blkdev.c
>  create mode 100644 lib/test_canonicalize.c
>  create mode 100644 lib/test_cpuset.c
>  create mode 100644 lib/test_ismounted.c
>  create mode 100644 lib/test_loopdev.c
>  create mode 100644 lib/test_mangle.c
>  create mode 100644 lib/test_procutils.c
>  create mode 100644 lib/test_strutils.c
>  create mode 100644 lib/test_sysfs.c
>  create mode 100644 lib/test_tt.c
>  create mode 100644 lib/test_wholedisk.c

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/

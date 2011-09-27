Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60429 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738Ab1I0NuF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 09:50:05 -0400
Date: Tue, 27 Sep 2011 15:49:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] misc: use %m in format string instead of %s and
	strerror(errno)
Message-ID: <20110927134941.GH19994@nb.net.home>
References: <1316686357-19893-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316686357-19893-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 22, 2011 at 12:12:37PM +0200, Petr Uzel wrote:
>  Documentation/TODO      |    3 ---
>  disk-utils/fsck.minix.c |    2 +-
>  disk-utils/raw.c        |   14 ++++++--------
>  fdisk/fdisk.c           |    4 ++--
>  fdisk/gpt.c             |    3 +--
>  hwclock/cmos.c          |   16 ++++++++--------
>  include/c.h             |    2 +-
>  libblkid/src/devname.c  |    3 +--
>  libblkid/src/verify.c   |    8 ++++----
>  libmount/src/context.c  |    2 +-
>  login-utils/login.c     |    3 +--
>  login-utils/vipw.c      |    3 +--
>  misc-utils/blkid.c      |    2 +-
>  misc-utils/uuidd.c      |   25 +++++++++----------------
>  mount/fstab.c           |    2 +-
>  mount/lomount.c         |    3 +--
>  mount/mount.c           |    7 +++----
>  mount/umount.c          |   10 ++++------
>  sys-utils/chcpu.c       |   12 ++++--------
>  sys-utils/ipcrm.c       |    3 +--
>  sys-utils/readprofile.c |    8 ++++----
>  term-utils/ttymsg.c     |    2 +-
>  22 files changed, 56 insertions(+), 81 deletions(-)

 Applied (and small conflict in chcpu.c resolved), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2FSLRW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Jun 2012 07:17:22 -0400
Date: Tue, 19 Jun 2012 13:17:18 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] exclusive options, compiler warnings and more regression
 fix
Message-ID: <20120619111718.GE13108@x2.net.home>
References: <CAG27Bk2mmG2JrsSLyGzuLwW=4M5hCY76r++BObc2MmTDghyT-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2mmG2JrsSLyGzuLwW=4M5hCY76r++BObc2MmTDghyT-g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 17, 2012 at 06:30:00PM +0200, Sami Kerola wrote:
>  disk-utils/fsck.cramfs.c  |    2 ++
>  disk-utils/mkfs.cramfs.c  |    2 ++
>  hwclock/hwclock.c         |   66 ++++++++++++++++++++++++++++-----------------
>  include/optutils.h        |   19 +++++++++++++
>  lib/mbsalign.c            |    2 ++
>  misc-utils/blkid.c        |   20 ++++++++------
>  misc-utils/findmnt.c      |   38 +++++++++++++++-----------
>  misc-utils/lsblk.c        |   32 +++++++++++++---------
>  misc-utils/wipefs.c       |   13 ++++++---
>  partx/partx.c             |   51 +++++++++++++----------------------
>  sys-utils/chcpu.c         |   22 ++++++++++++---
>  sys-utils/dmesg.c         |   24 ++++++++++++-----
>  sys-utils/losetup.c       |   26 +++++++++++++-----
>  sys-utils/lscpu.c         |   31 ++++++++++++++-------
>  sys-utils/mount.c         |   35 +++++++++++++++++++-----
>  sys-utils/prlimit.c       |   16 ++++++-----
>  sys-utils/setarch.c       |    7 ++++-
>  sys-utils/wdctl.c         |   15 ++++++++---
>  term-utils/scriptreplay.c |    3 +--
>  text-utils/display.c      |    5 ++++
>  text-utils/more.c         |   22 ++++++++++-----
>  21 files changed, 303 insertions(+), 148 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

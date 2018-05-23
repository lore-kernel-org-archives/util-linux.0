Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754186AbeEWIpg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 May 2018 04:45:36 -0400
Date: Wed, 23 May 2018 10:45:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] man: Use the correct macro for a font change of one
 argument
Message-ID: <20180523084533.pkvksmbeq4yfayar@ws.net.home>
References: <20180518192142.GA22534@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180518192142.GA22534@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 18, 2018 at 07:21:42PM +0000, Bjarni Ingi Gislason wrote:
>  disk-utils/fsck.8    |  2 +-
>  disk-utils/partx.8   |  4 ++--
>  disk-utils/sfdisk.8  |  2 +-
>  login-utils/last.1   |  2 +-
>  login-utils/login.1  | 18 +++++++++---------
>  login-utils/su.1     |  4 ++--
>  misc-utils/cal.1     |  2 +-
>  misc-utils/findfs.8  |  6 +++---
>  misc-utils/findmnt.8 | 30 +++++++++++++++---------------
>  misc-utils/kill.1    | 10 +++++-----
>  misc-utils/logger.1  |  2 +-
>  misc-utils/lsblk.8   |  2 +-
>  misc-utils/rename.1  |  4 ++--
>  misc-utils/whereis.1 |  6 +++---
>  misc-utils/wipefs.8  | 12 ++++++------
>  schedutils/chrt.1    |  8 ++++----
>  schedutils/taskset.1 | 14 +++++++-------
>  sys-utils/chcpu.8    |  6 +++---
>  sys-utils/chmem.8    |  6 +++---
>  sys-utils/choom.1    | 14 +++++++-------
>  sys-utils/dmesg.1    |  2 +-
>  sys-utils/flock.1    |  4 ++--
>  sys-utils/fsfreeze.8 |  2 +-
>  sys-utils/mount.8    | 20 ++++++++++----------
>  sys-utils/nsenter.1  | 18 +++++++++---------
>  sys-utils/setpriv.1  |  8 ++++----
>  sys-utils/swapon.8   |  6 +++---
>  sys-utils/unshare.1  | 28 ++++++++++++++--------------
>  term-utils/setterm.1 |  2 +-
>  text-utils/column.1  |  6 +++---
>  text-utils/hexdump.1 |  2 +-
>  31 files changed, 126 insertions(+), 126 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55950 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab1HQQIw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 12:08:52 -0400
Date: Wed, 17 Aug 2011 18:08:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] tests: grammar fixes
Message-ID: <20110817160848.GE699@nb.net.home>
References: <1313596375.2653.2.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313596375.2653.2.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 11:52:55AM -0400, Davidlohr Bueso wrote:
>  tests/ts/blkid/md-raid1-part          |    2 +-
>  tests/ts/cramfs/mkfs                  |    4 ++--
>  tests/ts/fdisk/align-512-4K           |    2 +-
>  tests/ts/fdisk/align-512-4K-63        |    2 +-
>  tests/ts/fdisk/align-512-4K-md        |    2 +-
>  tests/ts/fdisk/align-512-512-topology |    2 +-
>  tests/ts/fsck/ismounted               |    2 +-
>  tests/ts/libmount/tabfiles-tags       |    4 ++--
>  tests/ts/minix/mkfs                   |    2 +-
>  tests/ts/mount/fstab-broken           |    4 ++--
>  tests/ts/mount/fstab-devname          |    6 +++---
>  tests/ts/mount/fstab-devname2label    |    4 ++--
>  tests/ts/mount/fstab-devname2uuid     |    4 ++--
>  tests/ts/mount/fstab-label            |    8 ++++----
>  tests/ts/mount/fstab-label2devname    |    6 +++---
>  tests/ts/mount/fstab-label2uuid       |    8 ++++----
>  tests/ts/mount/fstab-symlink          |    6 +++---
>  tests/ts/mount/fstab-uuid             |    8 ++++----
>  tests/ts/mount/fstab-uuid2devname     |    6 +++---
>  tests/ts/mount/fstab-uuid2label       |    8 ++++----
>  tests/ts/mount/label                  |    6 +++---
>  tests/ts/mount/move                   |    4 ++--
>  tests/ts/mount/regfile                |    2 +-
>  tests/ts/mount/remount                |    4 ++--
>  tests/ts/mount/uuid                   |    6 +++---
>  tests/ts/swapon/devname               |    4 ++--
>  tests/ts/swapon/label                 |    4 ++--
>  tests/ts/swapon/uuid                  |    4 ++--
>  28 files changed, 62 insertions(+), 62 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

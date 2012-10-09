Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab2JILtj (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 9 Oct 2012 07:49:39 -0400
Date: Tue, 9 Oct 2012 13:49:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] fix bold style of man page references
Message-ID: <20121009114936.GA28457@x2.net.home>
References: <1349400874-6163-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349400874-6163-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 04, 2012 at 09:34:34PM -0400, Mike Frysinger wrote:
>  disk-utils/fsck.8         | 2 +-
>  fdisks/cfdisk.8           | 4 ++--
>  misc-utils/blkid.8        | 2 +-
>  misc-utils/ddate.1        | 4 ++--
>  mount-deprecated/mount.8  | 4 ++--
>  mount-deprecated/umount.8 | 2 +-
>  sys-utils/eject.1         | 2 +-
>  sys-utils/losetup.8       | 2 +-
>  sys-utils/mount.8         | 6 +++---
>  sys-utils/swapon.8        | 2 +-
>  sys-utils/umount.8        | 2 +-
>  sys-utils/unshare.1       | 5 +++--
>  12 files changed, 19 insertions(+), 18 deletions(-)

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

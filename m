Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53857 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbaEZJrv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 05:47:51 -0400
Date: Mon, 26 May 2014 11:47:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: umount --all-targets vs /etc/mtab
Message-ID: <20140526094744.GA2968@x2.net.home>
References: <201405250216.47401.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405250216.47401.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 25, 2014 at 02:16:47AM +0200, Ruediger Meier wrote:
> Hi,
> 
> umount --all-targets does not work if /etc/mtab is a regular file and not a 
> link to /proc/mounts.
> 
> reproduce:
> $ sudo mv /etc/mtab  /etc/mtab.orig 
> $ sudo cp /proc/mounts /etc/mtab
> $ sudo make check TS_OPTS="--parallel=1 mount" 

 I have added a hint to the error message and umount man page that this
 feature is supported on systems with mtab symlink only.

> Test mount/umount-alltargets fails.

 fixed by:

    [ -L /etc/mtab ] || ts_skip "regular mtab"

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

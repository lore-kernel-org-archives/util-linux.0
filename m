Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbaGNOIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 10:08:36 -0400
Date: Mon, 14 Jul 2014 16:08:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/14] pull: some minor fixes
Message-ID: <20140714140824.GJ30288@x2.net.home>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 13, 2014 at 09:24:39PM +0100, Sami Kerola wrote:
>  disk-utils/cfdisk.c        | 2 +-
>  disk-utils/fdformat.c      | 4 ++--
>  disk-utils/fdisk.c         | 9 ++++-----
>  disk-utils/mkfs.cramfs.c   | 6 ++----
>  lib/strutils.c             | 2 +-
>  libfdisk/src/dos.c         | 2 +-
>  libfdisk/src/partition.c   | 2 +-
>  libmount/src/tab.c         | 2 +-
>  libsmartcols/src/line.c    | 2 +-
>  libsmartcols/src/version.c | 2 +-
>  login-utils/last.c         | 2 +-
>  misc-utils/cal.c           | 5 -----
>  misc-utils/whereis.c       | 3 +--
>  sys-utils/dmesg.c          | 3 ++-
>  sys-utils/fstrim.c         | 2 +-
>  sys-utils/lscpu-dmi.c      | 2 +-
>  sys-utils/lscpu.c          | 2 +-
>  sys-utils/setpriv.c        | 4 +++-
>  term-utils/setterm.c       | 3 +--
>  19 files changed, 26 insertions(+), 33 deletions(-)

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

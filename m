Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbbAGJKC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Jan 2015 04:10:02 -0500
Date: Wed, 7 Jan 2015 10:09:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] maint: fix shadow declaration
Message-ID: <20150107090949.GB15715@x2.net.home>
References: <1420066881-16797-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420066881-16797-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 31, 2014 at 11:01:21PM +0000, Sami Kerola wrote:
>  disk-utils/cfdisk.c            |  6 +++---
>  disk-utils/fsck.cramfs.c       | 40 ++++++++++++++++++++--------------------
>  libfdisk/src/sun.c             |  8 +++++---
>  libfdisk/src/table.c           |  6 +++---
>  libmount/src/tab_parse.c       |  6 +++---
>  libsmartcols/src/table_print.c |  6 +++---
>  login-utils/lslogins.c         | 32 ++++++++++++++++----------------
>  misc-utils/findmnt.c           |  4 ++--
>  misc-utils/lslocks.c           |  4 ++--
>  sys-utils/swapon.c             | 14 +++++++-------
>  sys-utils/zramctl.c            |  2 +-
>  11 files changed, 65 insertions(+), 63 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

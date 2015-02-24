Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826AbbBXLrS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 06:47:18 -0500
Date: Tue, 24 Feb 2015 12:47:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/16] rpmatch: use symbolic value when evaluation return
 codes
Message-ID: <20150224114705.GL19430@ws.net.home>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
 <1424616106-580-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616106-580-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:41:40PM +0000, Sami Kerola wrote:
>  disk-utils/fdisk.c      | 2 +-
>  disk-utils/fsck.minix.c | 6 +++---
>  disk-utils/sfdisk.c     | 2 +-
>  include/rpmatch.h       | 4 ++++
>  login-utils/vipw.c      | 2 +-
>  term-utils/mesg.c       | 6 +++---
>  6 files changed, 13 insertions(+), 9 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

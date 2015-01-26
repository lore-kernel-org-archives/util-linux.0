Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60809 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755790AbbAZKTV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 05:19:21 -0500
Date: Mon, 26 Jan 2015 11:19:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: fix spellos and inconsistencies in several
 program messages
Message-ID: <20150126101918.GE6354@x2.net.home>
References: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421612229-5535-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 18, 2015 at 09:17:09PM +0100, Benno Schulenberg wrote:
>  disk-utils/cfdisk.c     |    4 ++--
>  disk-utils/fdisk-list.c |    6 +++---
>  disk-utils/fdisk-menu.c |    6 +++---
>  disk-utils/sfdisk.c     |   28 ++++++++++++++--------------
>  libfdisk/src/gpt.c      |    2 +-
>  misc-utils/logger.c     |    2 +-
>  sys-utils/swapon.c      |    6 +++---
>  sys-utils/unshare.c     |    4 ++--
>  term-utils/agetty.c     |    6 +++---
>  9 files changed, 32 insertions(+), 32 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

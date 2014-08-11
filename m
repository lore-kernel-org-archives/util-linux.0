Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56149 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaHKM5a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Aug 2014 08:57:30 -0400
Date: Mon, 11 Aug 2014 14:57:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: remove some inconsistent periods from error
 messages
Message-ID: <20140811125725.GF17719@x2.net.home>
References: <1407357306-3207-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407357306-3207-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 06, 2014 at 10:35:06PM +0200, Benno Schulenberg wrote:
>  disk-utils/sfdisk.c    |    6 +++---
>  include/optutils.h     |    8 ++++----
>  login-utils/lslogins.c |    2 +-
>  login-utils/sulogin.c  |    4 ++--
>  misc-utils/findmnt.c   |    2 +-
>  misc-utils/logger.c    |    2 +-
>  misc-utils/lsblk.c     |    4 ++--
>  sys-utils/fallocate.c  |    2 +-
>  sys-utils/fstrim.c     |    2 +-
>  term-utils/agetty.c    |    2 +-
>  text-utils/hexdump.c   |    2 +-
>  11 files changed, 18 insertions(+), 18 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

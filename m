Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57869 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448AbaGWG5K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Jul 2014 02:57:10 -0400
Date: Wed, 23 Jul 2014 08:57:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] textual: fix some typos and inconsistencies in various
 messages
Message-ID: <20140723065705.GE26781@x2.net.home>
References: <1406062587-2183-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406062587-2183-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 10:56:27PM +0200, Benno Schulenberg wrote:
>  disk-utils/cfdisk.c      |    6 +++---
>  disk-utils/fdisk.c       |    2 +-
>  disk-utils/fsck.cramfs.c |    2 +-
>  libfdisk/src/bsd.c       |    2 +-
>  libfdisk/src/gpt.c       |    6 +++---
>  libfdisk/src/sgi.c       |    2 +-
>  login-utils/chfn.c       |    2 +-
>  login-utils/chsh.c       |    4 ++--
>  login-utils/last.c       |    6 +++---
>  login-utils/lslogins.c   |    2 +-
>  login-utils/su-common.c  |    6 +++---
>  misc-utils/kill.c        |    2 +-
>  misc-utils/logger.c      |    4 ++--
>  misc-utils/mcookie.c     |    7 ++++---
>  misc-utils/namei.c       |    2 +-
>  misc-utils/rename.c      |    4 ++--
>  misc-utils/whereis.c     |    2 +-
>  misc-utils/wipefs.c      |    4 ++--
>  18 files changed, 33 insertions(+), 32 deletions(-)

 Applied, thanks.
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

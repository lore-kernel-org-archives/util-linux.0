Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62195 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437Ab2EOJeu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 05:34:50 -0400
Date: Tue, 15 May 2012 11:34:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] include: rename writeall.h to all-io.h
Message-ID: <20120515093423.GI8268@x2.net.home>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 15, 2012 at 10:49:01AM +0200, Petr Uzel wrote:
>  disk-utils/fsck.minix.c |    2 +-
>  disk-utils/mkfs.minix.c |    2 +-
>  disk-utils/mkswap.c     |    2 +-
>  disk-utils/swaplabel.c  |    2 +-
>  include/Makefile.am     |    2 +-
>  include/all-io.h        |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/writeall.h      |   47 -----------------------------------------------
>  lib/path.c              |    2 +-
>  libblkid/src/probe.c    |    2 +-
>  login-utils/login.c     |    2 +-
>  misc-utils/uuidd.c      |    2 +-
>  misc-utils/wipefs.c     |    2 +-
>  sys-utils/dmesg.c       |    2 +-
>  term-utils/agetty.c     |    2 +-
>  text-utils/pg.c         |    2 +-
>  15 files changed, 60 insertions(+), 60 deletions(-)
>  create mode 100644 include/all-io.h
>  delete mode 100644 include/writeall.h

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

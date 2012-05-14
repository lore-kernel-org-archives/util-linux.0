Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16024 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755179Ab2ENJq0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 May 2012 05:46:26 -0400
Date: Mon, 14 May 2012 11:46:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libuuid,uuidd: move read_all to include/readall.h
Message-ID: <20120514094601.GC16926@x2.net.home>
References: <1336894676-25586-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336894676-25586-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 13, 2012 at 09:37:56AM +0200, Petr Uzel wrote:
>  include/Makefile.am    |    1 +
>  include/readall.h      |   33 +++++++++++++++++++++++++++++++++
>  libuuid/src/gen_uuid.c |   26 +-------------------------
>  misc-utils/uuidd.c     |   25 +------------------------
>  4 files changed, 36 insertions(+), 49 deletions(-)
>  create mode 100644 include/readall.h

 Good idea, but do we really need writeall.h and readall.h ? ;-) What
 about to merge both files? (all-io.h ?)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

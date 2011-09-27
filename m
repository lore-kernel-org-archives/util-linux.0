Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51780 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab1I0KvZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Sep 2011 06:51:25 -0400
Date: Tue, 27 Sep 2011 12:51:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mount: use common libs
Message-ID: <20110927105121.GA19994@nb.net.home>
References: <1315926455.3703.2.camel@offbook> <20110914144539.GA1829@nb.net.home> <1316023626.2771.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316023626.2771.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 14, 2011 at 03:07:06PM -0300, Davidlohr Bueso wrote:
>  mount/Makefile.am |    2 +-
>  mount/fstab.c     |    2 +-
>  mount/lomount.c   |    1 -
>  mount/mount.c     |    1 -
>  mount/sundries.c  |    1 -
>  mount/sundries.h  |    6 ++++--
>  mount/umount.c    |    1 +
>  mount/xmalloc.c   |   48 ------------------------------------------------
>  mount/xmalloc.h   |   14 --------------
>  9 files changed, 7 insertions(+), 69 deletions(-)
>  delete mode 100644 mount/xmalloc.c
>  delete mode 100644 mount/xmalloc.h

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

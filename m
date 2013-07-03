Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754047Ab3GCKxs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Jul 2013 06:53:48 -0400
Date: Wed, 3 Jul 2013 12:53:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] findmnt: avoid unused parameter warning
Message-ID: <20130703105343.GB722@x2.net.home>
References: <1372776149-20214-1-git-send-email-mail@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372776149-20214-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 02, 2013 at 04:42:29PM +0200, Bernhard Voelker wrote:
>  misc-utils/findmnt.c | 2 ++
>  1 file changed, 2 insertions(+)

 Fixed, I have added __attribute__((__unused__)).

 Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

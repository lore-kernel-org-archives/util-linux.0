Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58636 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934045AbaGXH3y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 24 Jul 2014 03:29:54 -0400
Date: Thu, 24 Jul 2014 09:29:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Timofey Titovets <nefelim4ag@gmail.com>, util-linux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [RFC] [Patch] Created zramctl
Message-ID: <20140724072950.GH26781@x2.net.home>
References: <53CAAAB6.6020607@gmail.com>
 <53CFF0CC.4000608@gmail.com>
 <20140723174348.GA519@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140723174348.GA519@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 23, 2014 at 01:43:48PM -0400, Dave Reisner wrote:
> > +	char *table = "%6s %12s %10s %10s %4s %4s \n";
> > +	printf(table, "NAME","DISKSIZE","ORIG","COMPRES","ALG","THR");
> 
> Not really extensible. You really ought to adopt the style used in utils
> like lsblk or findmnt to make this dynamic.

 Dave is talking about libsmartcols, see losetup.c: show_table(), it's
 probably the most simple example for the same thing like zramctl.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

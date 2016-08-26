Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753112AbcHZLDt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 26 Aug 2016 07:03:49 -0400
Date: Fri, 26 Aug 2016 13:03:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: Util linux <util-linux@vger.kernel.org>
Subject: Re: listing fdisk partition tyles
Message-ID: <20160826110347.owpfzwvaynvzy3ib@ws.net.home>
References: <57BBBCFD.9090502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57BBBCFD.9090502@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2016 at 10:03:25PM -0500, Bruce Dubbs wrote:
> I have a request.  When I try to install Debian from an iso, I like to drop
> to the command line to run fdisk to partition the disk drive.  When
> selecting GPT, I have a problem with listing the partition types.
> 
> The screen is running at about 80x25 and I have no control over that.
> The l command lists all the 81 types and there is no way to scroll back to
> see the first 55 entries in the list.
> 
> There is no problem when listing partition types when the partition table is
> the old MSDOS type,
> 
> I would like to request a pager, possibly as an option, for the partition
> type list when using a GPT partition table.

Implemented. Try it. 

It's enabled for strings based partition types (=GPT) only.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

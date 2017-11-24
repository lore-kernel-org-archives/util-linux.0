Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdKXJ2J (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 04:28:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF837A63E0
        for <util-linux@vger.kernel.org>; Fri, 24 Nov 2017 09:28:08 +0000 (UTC)
Date: Fri, 24 Nov 2017 10:28:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] lsns: add netnsid column
Message-ID: <20171124092805.4d7gfojeogjgxi7s@ws.net.home>
References: <20171121111641.dt3vodjsuwwnna6g@ws.net.home>
 <20171121.203633.949035400852899096.yamato@redhat.com>
 <20171122090613.ltcuaehwbum7apes@ws.net.home>
 <20171124.020128.28825211426388397.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171124.020128.28825211426388397.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 24, 2017 at 02:01:28AM +0900, Masatake YAMATO wrote:
> Hi,
> 
> > I do not have any changes yet ;-) So, you can start, or if you're busy
> > with something else I can do that.
> 
> It works:

Cool!

> # ./lsns --type=net
>         NS TYPE NPROCS   PID USER     NETNSID NSFS           COMMAND
> 4026531993 net     405     1 root  unassigned                /usr/lib/systemd/systemd --switched-root --system --deserialize 25
> 4026532433 net       1  1515 rtkit unassigned                /usr/libexec/rtkit-daemon
> 4026532579 net       1 10432 root  unassigned /run/netns/QWE bash
>                                               /tmp/RTY
> 
> > This feature should be probably disabled for --raw, maybe add --nowrap
> > and in this case use "," as separator and remove SCOLS_FL_WRAP for the
> > column in init_scols_table().
> 
> It seems that nsfs is still not so popular.
> So I think enabling the column only when --type net is given, as
> you suggested about netnsid.

Yes.

> I would like to make clarify what you meant.
> 
> If both --raw and -o NSFS are given, what I should do?
> Hidden NSFS anyway? or Use ',' as separator instead of '\n'?
 
I prefer ',' as separator and add to the man page a note that NSFS
uses multi-line cells (to DESCRIPTION where we already have soemthing
about --output).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

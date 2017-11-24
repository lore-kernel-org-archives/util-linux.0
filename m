Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753644AbdKXMEz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 07:04:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4F54A1433
        for <util-linux@vger.kernel.org>; Fri, 24 Nov 2017 12:04:55 +0000 (UTC)
Date: Fri, 24 Nov 2017 13:04:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add netnsid and nsfs columns to lsns
Message-ID: <20171124120452.fxzgpnenugbr6k6e@ws.net.home>
References: <20171124103110.17077-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 24, 2017 at 07:31:02PM +0900, Masatake YAMATO wrote:
> This patch-set adds netnsid and nsfs columns to lsns command.
> 
> The new columns are useful to understand namespaces information
> printed in the output of "ip link" and "ip netns".  The new columns
> are visible only when --type net is specified.
> 
> Masatake YAMATO (7):
>   lsns: add netnsid column
>   lsns: disable netnsid column by default
>   lsns: add a case for testing netnsid column
>   lsns: add nsfs column
>   lsns: add --nowrap(-W) option
>   lsns: add a case for testing nsfs column
>   man: write about using multi-line in NSFS cell of lsns

Cool, I'll merge it next week. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

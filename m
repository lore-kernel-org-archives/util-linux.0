Return-Path: <SRS0=j1+t=VM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7C1C76190
	for <util-linux@archiver.kernel.org>; Mon, 15 Jul 2019 08:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3DC214DA
	for <util-linux@archiver.kernel.org>; Mon, 15 Jul 2019 08:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfGOIAW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfGOIAW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Jul 2019 04:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F4672F8BF3;
        Mon, 15 Jul 2019 08:00:22 +0000 (UTC)
Received: from ws.net.home (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 582315D71B;
        Mon, 15 Jul 2019 08:00:21 +0000 (UTC)
Date:   Mon, 15 Jul 2019 10:00:18 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Yousong Zhou <yszhou4tech@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Yousong Zhou <zhouyousong@yunionyun.com>
Subject: Re: [PATCH] column: fix outputing empty column at the end of line
Message-ID: <20190715080018.tjfvon3vfpsp4uca@ws.net.home>
References: <20190627092235.36888-1-zhouyousong@yunionyun.com>
 <CAECwjAhM1FmCoxZnxUxJcE+vCN5=uBd_SuMZEQ6qj8OKfCf3oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAECwjAhM1FmCoxZnxUxJcE+vCN5=uBd_SuMZEQ6qj8OKfCf3oA@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 15 Jul 2019 08:00:22 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jul 13, 2019 at 01:30:27PM +0800, Yousong Zhou wrote:
> On Thu, 27 Jun 2019 at 17:22, Yousong Zhou <yszhou4tech@gmail.com> wrote:
> >
> > The following commands manifests the problem.  In old versions before
> > commit 4762ae9d60 ("column: use libsmartcols for --table"), both of them
> > should output with 2 "|"
> >
> >         echo '||'  | column -o '|' -s '|' -t
> >         echo '|| ' | column -o '|' -s '|' -t
> >
> > Fixes: 4762ae9d60 ("column: use libsmartcols for --table")
> > Signed-off-by: Yousong Zhou <zhouyousong@yunionyun.com>
> > ---
> 
> Hi, do you think this is a real bug and the fix a proper one?  should
> I post a pull request through the github project page?


Sorry for delay, I had vacation last weekend.

I think your patch seems fine at first glance and send it to mailing
list is good enough. You do not have to use github PR. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

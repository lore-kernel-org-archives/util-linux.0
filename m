Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966DEC282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764BB2085A
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 18:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfAVSzS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:55:18 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60835 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAVSzS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2019 13:55:18 -0500
X-Originating-IP: 134.134.139.76
Received: from localhost (unknown [134.134.139.76])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F199B1BF20C;
        Tue, 22 Jan 2019 18:55:14 +0000 (UTC)
Date:   Tue, 22 Jan 2019 10:55:10 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] libuuid: Make the uuid_unparse functions inline
Message-ID: <20190122185509.GB1922@localhost>
References: <20190121024510.GA22370@localhost>
 <20190122120401.4bppg5ikgi6svren@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122120401.4bppg5ikgi6svren@ws.net.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 22, 2019 at 01:04:01PM +0100, Karel Zak wrote:
> On Sun, Jan 20, 2019 at 06:45:16PM -0800, Josh Triplett wrote:
> > Various libraries, including libblkid, depend on libuuid solely to call
> > uuid_unparse, which just prints a UUID.
> 
> It seems only libblkid requires solely uuid_unparse() :-) So, I guess
> all we need is to use already implemented blkid_unparse_uuid() where
> is the magic snprintf. I have applied this change:
> 
>  https://github.com/karelzak/util-linux/commit/c2435b946f574880201cb41d989d8d63d4bbf87d

Alright; that certainly solves the primary issue I observed. Thank you!

Looking across a large chunk of Debian, I don't see any other users of
solely uuid_unparse.

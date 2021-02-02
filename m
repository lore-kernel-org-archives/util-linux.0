Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF8EC433E0
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F1064EE4
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 08:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhBBIDK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Feb 2021 03:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231358AbhBBIDI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2021 03:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612252900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9nEzRV1NlspD5r3yFD9+Iw6wawLiOX71WZYlUV4rsU0=;
        b=cMrX3vkva++N9M6UtNRBwbmhGbM4RYhUVBCig1UwmN9PcbUds0CVO/FtxFrrkZAxSszQ2h
        7JA5cinLjBynedX+7zKquMFwB3qfU3rAt1vQ4Y865RfdI8bQXxoIh1PnZLr/1djn5rC85j
        MhMMl5RdZ8mFeBQ552jHrXX4AIDG/e4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-1Zw5b4ztPsGFxNWU1TCWyw-1; Tue, 02 Feb 2021 03:01:36 -0500
X-MC-Unique: 1Zw5b4ztPsGFxNWU1TCWyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA1A801B13;
        Tue,  2 Feb 2021 08:01:35 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC9A6A912;
        Tue,  2 Feb 2021 08:01:34 +0000 (UTC)
Date:   Tue, 2 Feb 2021 09:01:31 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Add uclampset schedutil
Message-ID: <20210202080131.lyvsda3rtp7btc3q@ws.net.home>
References: <20210130205039.581764-1-qais.yousef@arm.com>
 <20210130205039.581764-3-qais.yousef@arm.com>
 <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
 <20210201173202.jrsd6mbhbm2hhebm@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201173202.jrsd6mbhbm2hhebm@e107158-lin>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 01, 2021 at 05:32:02PM +0000, Qais Yousef wrote:
> On 02/01/21 17:12, Karel Zak wrote:
> > On Sat, Jan 30, 2021 at 08:50:36PM +0000, Qais Yousef wrote:
> > 
> > Now I see that you have reused chrt concept of --pid. We keep it for
> > chrt due to backward compatibility, but for new util it would be
> > better to use standard 'required_argument' for --pid.
> 
> Hmm what does required mean here? --pid is optional. But if passed, a value
> is required to be passed indeed.

It means a value required if --pid specified.

> > > +	static const struct option longopts[] = {
> > > +		{ "all-tasks",		no_argument, NULL, 'a' },
> > > +		{ "pid",		no_argument, NULL, 'p' },
> > 
> >  { "pid", required_argument, NULL, 'p' },
> 
> Assuming this means --pid must be followed by a value then indeed that's what
> we expect to happen.

 Yes.

> will fix this and the 2 other occurrences below to include in v3.

You don't have to send it to the mailing list, juts update your
github repo and I'll merge it :-) Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2812C48BDF
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ED1613EB
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 12:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhFRMuG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 18 Jun 2021 08:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230217AbhFRMuF (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Jun 2021 08:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624020476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dhcu/8ykMYKqptZ+Tj9VpwyI461UkBEFI8h5pGYbR7Q=;
        b=OY5qg7r3un7izx9rhY2x61Sf3Lusi+I9RJl6InGlCG2/jlDQ8wd5MftyDICeXp0ULxDOQh
        GQj3ijtvYyg0HoesEO+gvWjc4EbKopSfD0f4U11TITT3PvSpRzyro93GPkDizaX7xISUyB
        4KWtLT5T9z43HyoOfTtVokk0oKdboKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-TRbZTXPEM9ixHOsaGh4eOA-1; Fri, 18 Jun 2021 08:47:54 -0400
X-MC-Unique: TRbZTXPEM9ixHOsaGh4eOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D766B80430C;
        Fri, 18 Jun 2021 12:47:53 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 121CA19D61;
        Fri, 18 Jun 2021 12:47:52 +0000 (UTC)
Date:   Fri, 18 Jun 2021 14:47:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: An obscure problem with v2.37 make check
Message-ID: <20210618124748.gshsqqvkx2xfp4a3@ws.net.home>
References: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com>
 <20210617085901.l45esa2fuzinn44w@ws.net.home>
 <CADxRZqwwfA7KWirH5XxdAHN_PprGFzqKOi2q_6MBA39MfB2+Qw@mail.gmail.com>
 <27bff31c-d6d5-478d-f63d-e121750b259d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bff31c-d6d5-478d-f63d-e121750b259d@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 17, 2021 at 11:50:42AM -0500, Bruce Dubbs wrote:
> On 6/17/21 6:37 AM, Anatoly Pugachev wrote:
> > util-linux$ git diff
> > diff --git a/tests/ts/lsns/ioctl_ns b/tests/ts/lsns/ioctl_ns
> > index e91f6743f..b8f35e2e5 100755
> > --- a/tests/ts/lsns/ioctl_ns
> > +++ b/tests/ts/lsns/ioctl_ns
> > @@ -24,6 +24,9 @@ ts_init "$*"
> >   # ts_skip_nonroot
> >   grep -q '#define HAVE_LINUX_NSFS_H' ${top_builddir}/config.h ||
> > ts_skip "no ioctl_ns support"
> > 
> > +[ -a /proc/self/ns/user ] || ts_skip "no USER namespace kernel support"
> > +[ -a /proc/self/ns/pid ] || ts_skip "no PID namespace kernel support"
> > +
> >   ts_check_test_command "$TS_CMD_LSNS"
> >   ts_check_test_command "$TS_CMD_UNSHARE"
> >   ts_check_prog "stat"
> > 
> 
> Looks pretty good to me, but I would use -r instead of -a.

Applied with -r, thanks guys!

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


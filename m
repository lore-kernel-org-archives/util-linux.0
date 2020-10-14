Return-Path: <SRS0=yCBK=DV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1160AC433E7
	for <util-linux@archiver.kernel.org>; Wed, 14 Oct 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4DA720BED
	for <util-linux@archiver.kernel.org>; Wed, 14 Oct 2020 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVLgTaMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgJNITb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 14 Oct 2020 04:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgJNITb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602663572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PEkyWCB8VsF3CyVCeEYFtwjZeC20Nd1ksXWuclFG9TE=;
        b=SVLgTaMorX74zL8hLrTET8N3QNeNgrEuARDZzfRxrRCVTzgEG31cUibQLM5h2Rma8oZoim
        IW7wm6tKSiXSdbWQ5DiWwI6XAOC9bYeMn6yr3T2e1ySoE2Y4c8vrS0MArfz4W0bLwUhyWW
        ySU5J+wyP8K/ihk47lIzzvxj8cPWUzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-VYxzDqOQN5m7iGyMQbNJdw-1; Wed, 14 Oct 2020 04:19:29 -0400
X-MC-Unique: VYxzDqOQN5m7iGyMQbNJdw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB2E41018F7A;
        Wed, 14 Oct 2020 08:19:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4BD210013D0;
        Wed, 14 Oct 2020 08:19:27 +0000 (UTC)
Date:   Wed, 14 Oct 2020 10:19:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     Util-Linux <util-linux@vger.kernel.org>,
        jun wang <junguo.wang@suse.com>
Subject: Re: [PATCH] bash-completion: Fix su
Message-ID: <20201014081925.wweh5l3vww5gzb6u@ws.net.home>
References: <423799ab-a6d8-987c-711e-cdda6ee72c3e@suse.cz>
 <20201008075351.ucusodaf3dqh5k4v@ws.net.home>
 <8440a218-e1ac-22fc-7a4d-4de5f606d24d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8440a218-e1ac-22fc-7a4d-4de5f606d24d@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Oct 13, 2020 at 05:15:45PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> > On Thu, Oct 08, 2020 at 08:50:39AM +0200, Stanislav Brabec wrote:
> >> Fix su -s <tab> that reports invalid chsh -l.
> >  
> > "cat /etc/shells" and "chsh -l" get the same output on my system, why
> > "chsh -l" is invalid? 
> > 
> > chsh -l uses getusershell() glibc function.
> > 
> >     Karel
> > 
> Oops. SUSE uses chsh from shadow package, which is not fully compatible with util-linux one.
> 
> So the patch is unappropriate for the upstream util-linux.

So, now you have motivation to use our wonderful chsh and chfn in SUSE
distros ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440DBC48BE5
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A54A61417
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 09:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOJP0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhFOJPZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 15 Jun 2021 05:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623748401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3E5eP0PjsWpOySa8mIFwjrCsPgBO1HrWLAMYsumfxc=;
        b=iZhs9aH7Cc3wHIKTBFjvkMYxiZaetLXdP7q0kgjI2LH8FV4eAQ23NmEjfqe54uAWynSJ4X
        ynzwDpaatDeFePKt/vLNAOHR17H3n29oVQWaHtgMMjWzrTWq4a3eIDFv/2ffNbBhPWnyhJ
        41WoiutMgpAAbg119RQ51ieWHaeH938=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-BUO0mnzNPQK7hB7HgtRlVQ-1; Tue, 15 Jun 2021 05:13:19 -0400
X-MC-Unique: BUO0mnzNPQK7hB7HgtRlVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530938049C5;
        Tue, 15 Jun 2021 09:13:18 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3F4F5C1C2;
        Tue, 15 Jun 2021 09:13:16 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:13:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, jbastian@redhat.com
Subject: Re: [PATCH] lscpu: get the processor information by DMI
Message-ID: <20210615091314.3hrkztuvnqyff3ll@ws.net.home>
References: <20210614094845.13958-1-shijie@os.amperecomputing.com>
 <20210614104126.htcsjaaibwfcvp2n@ws.net.home>
 <YMhw94JMDieTpqLA@hsj>
 <20210615084821.s2mcvmpaetb7fbjq@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615084821.s2mcvmpaetb7fbjq@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 15, 2021 at 10:48:25AM +0200, Karel Zak wrote:
> On Tue, Jun 15, 2021 at 09:20:55AM +0000, Huang Shijie wrote:
> > > > +	/* Get CPU family */
> > > > +	memset(buf, 0, sizeof(buf));
> > > > +	sprintf(buf, "%d", di.processor_family);
> > > > +	free(ct->family);
> > > > +	ct->family = xstrdup(buf);
> > > 
> > > is there any difference between "cpu family" from /proc/cpuinfo and
> > > this DMI field? Do we need a new field ct->bios_family or overwrite 
> > > the ct->family good enough? I don't know ;-)
> > > 
> > In the arm platform, it seems it does not show the "cpu family" info in lscpu.
> > And I did not find the "cpu family" in the /proc/cpuinfo, only find "cpu architecture: 8".
> > Unfortunately, the "cpu architecture :8 " is hardcode, it will be changed for armv9 in future.
> > 
> > In the DMI, the "cpu family" shows 0x101 which means "arm v8".
> 
> So, re-use ct->family for now. We can change it later.

Ah, I see you already send patch with "BIOS CPU Family". OK, let's use
it and ignore my previous email ;-)

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


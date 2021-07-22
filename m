Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCDC63793
	for <util-linux@archiver.kernel.org>; Thu, 22 Jul 2021 14:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5871861221
	for <util-linux@archiver.kernel.org>; Thu, 22 Jul 2021 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhGVOSz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:18:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23892 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhGVOR3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jul 2021 10:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626965884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NU35KxKodbN3/W1d6h9ilO6sqB4XxMOvfYClGfSvSqY=;
        b=JaDyN6sc4YqmzV6ju/fmNrU4p60/h2o++C3yFt+Dbyz4cVteaknGKnAeN8Dkuxh5M0rMwD
        Uxn46nqdAoc5gJwmiaex0B5BHtbYK0DqoTBpvGOCMGKMo7Perfyh94KeHPd5WE1lThsC3J
        oJMO+sL2ce7M26/aH/L9emeCglfgMz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-bkt7YrxwPriB1Mk-4INbpw-1; Thu, 22 Jul 2021 10:58:02 -0400
X-MC-Unique: bkt7YrxwPriB1Mk-4INbpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB94B190D340;
        Thu, 22 Jul 2021 14:58:01 +0000 (UTC)
Received: from ws.net.home (ovpn-113-182.ams2.redhat.com [10.36.113.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C28E144;
        Thu, 22 Jul 2021 14:58:00 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:57:58 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.37
Message-ID: <20210722145758.augvzjc4r4f4mtsv@ws.net.home>
References: <20210601083849.niumt2zvyr3boiqw@ws.net.home>
 <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
 <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
 <4a6781ff-04ad-f3e1-402e-b4cb65d1749b@gmail.com>
 <20210603101939.ltmyouadjizgw2mu@ws.net.home>
 <eab7d8ef-652b-3700-0a82-2f36f22f2e97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab7d8ef-652b-3700-0a82-2f36f22f2e97@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 03, 2021 at 12:40:22PM -0500, Bruce Dubbs wrote:
> On 6/3/21 4:19 AM, Karel Zak wrote:
> > On Wed, Jun 02, 2021 at 11:25:14AM -0500, Bruce Dubbs wrote:
> > > On 6/2/21 9:27 AM, Karel Zak wrote:
> > > > On Tue, Jun 01, 2021 at 01:29:21PM -0500, Bruce Dubbs wrote:
> > > > > On 6/1/21 2:38 AM, Karel Zak wrote:
> > ...
> > > > > Karel, Is there any chance you can release a tarball with rendered man
> > > > > pages?  It would make things a lot easier for us.
> > > > 
> > > > I'm not sure if duplicate content in the upstream source
> > > > tarball is a good idea (it means keep there AsciiDoc as well as
> > > > generated man pages).
> > 
> > Today morning I had time to play with it and it seems that we can
> > distribute man pages as well as adoc in the same tarbal, the size
> > change is not so big:
> > 
> > 5956904  util-linux-2.37.42-308a1-dirty.tar.xz
> > 5863940  util-linux-2.37.tar.xz
> > 
> >   ~1.5% up, that's something we can ignore.
> > 
> > It also seems that autotools are smart enough to keep the man pages
> > synchronized with adoc without any significant changes to our build
> > system.
> 
> Much appreciated.

Note that in v2.37.1 will be in hwclock.8 hardcoded ADJTIME_PATH to /etc/adjtime
because the man page is generated with the default setting.

For v2.38 it would be nice to fix this issue somehow.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


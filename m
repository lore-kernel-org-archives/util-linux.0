Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C33DC4708F
	for <util-linux@archiver.kernel.org>; Wed,  2 Jun 2021 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A661360
	for <util-linux@archiver.kernel.org>; Wed,  2 Jun 2021 15:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFBP3A (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 2 Jun 2021 11:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232143AbhFBP3A (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Jun 2021 11:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622647636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/C/UCXJymGIpufc+l3+SLDK/xCT5wsO8/xP4Vj5izzU=;
        b=HlLHzoxbh9GxVSOjJuZ1qi0rjyrledJwDmsmMS9bb9PafmEFIGGfGqasrJwmDvyJ1ACtbx
        w2mCvS0Mw9pNwshJTVfAq6gFVersarBGNKNmwNi25jz1nMCbXDZwRke24ojqbmDz3pVU9L
        kSwqaUXcVHHqJVfEQpFQQ0ouQLrOy4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-auIv_3TvPcSDLoDefQccIw-1; Wed, 02 Jun 2021 11:27:14 -0400
X-MC-Unique: auIv_3TvPcSDLoDefQccIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F6A802B78;
        Wed,  2 Jun 2021 15:27:13 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3150A19C44;
        Wed,  2 Jun 2021 15:27:13 +0000 (UTC)
Date:   Wed, 2 Jun 2021 17:27:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.37
Message-ID: <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
References: <20210601083849.niumt2zvyr3boiqw@ws.net.home>
 <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 01, 2021 at 01:29:21PM -0500, Bruce Dubbs wrote:
> On 6/1/21 2:38 AM, Karel Zak wrote:
> > 
> > The util-linux release v2.37 is available at
> > 
> >    http://www.kernel.org/pub/linux/utils/util-linux/v2.37/
> > 
> > Feedback and bug reports, as always, are welcomed.
> > 
> >    Karel
> 
> Karel, Is there any chance you can release a tarball with rendered man
> pages?  It would make things a lot easier for us.

I'm not sure if duplicate content in the upstream source
tarball is a good idea (it means keep there AsciiDoc as well as
generated man pages).

Maybe we can create a separated tarball util-linux-man-2.37.tar.gz and
distribute it by kernel.org FTP for users who do not want to depend on
AsciiDoc. It would be also usable in the future when we will have the
man pages translated to other languages.

The problem is content which depends on the configuration (variables
like $ADJTIME_PATH, $docdir, etc.), because it's distro-specific and
these variables are replaced by real data during conversion from
AsciiDoc,  but I guess this is something we can fix by simple sed call
in the Makekefile.am.

So, your work-flow will be:

 * download and extract source tar.gz
 * download and extract man-pages tar.gz to the same directory as source
 * ./configure [--disable-asciidoc]
 * make
 * make install

Does it sounds usable?

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


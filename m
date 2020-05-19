Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F93EC433DF
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3532E2065F
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWg2YjI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESKik (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 06:38:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726412AbgESKik (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 May 2020 06:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589884719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnGof+LJTCoEwfRcVHa75MBmpCQOAdfYbfYEyLHQJEY=;
        b=AWg2YjI16+UdoifqWnDAqD80ojNOm1jbaopmS/enyKr2MczetZVMS61h53EdSEEoi2T8cU
        hLnmlK9KHZY/OOq3sF6sHDTC7CK7eHCkF48nLzYpFVIli9jOadLnCcTI/qEPNjcxy25SLf
        WH8C7eziHGmlPxTFAL62C+9R30nugHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-9Esv7KHsPhCDiwjeWOtQAw-1; Tue, 19 May 2020 06:38:37 -0400
X-MC-Unique: 9Esv7KHsPhCDiwjeWOtQAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B616107ACF3;
        Tue, 19 May 2020 10:38:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F1979589;
        Tue, 19 May 2020 10:38:35 +0000 (UTC)
Date:   Tue, 19 May 2020 12:38:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Helge Kreutzmann <debian@helgefjell.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: Consistency fixes in util-linux man pages
Message-ID: <20200519103832.7kmxmta2dl67ujpj@ws.net.home>
References: <4cb60e3f-0226-e7f0-0052-08a48ea9f425@gmail.com>
 <20200518082814.pq22ph732eiebacz@ws.net.home>
 <CAKgNAkihsF1tGurfHbnFPYZ4qJV9-2f=Sbj5qdLxmuuuAJ+GGA@mail.gmail.com>
 <20200518150312.GA22063@Debian-50-lenny-64-minimal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518150312.GA22063@Debian-50-lenny-64-minimal>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 18, 2020 at 05:03:13PM +0200, Helge Kreutzmann wrote:
> On Mon, May 18, 2020 at 12:36:01PM +0200, Michael Kerrisk (man-pages) wrote:
> > I'm not too knowledgeable in AsciiDc, but my impression is that it's
> > too limited in terms of its formatting opinions.

Yes, I'm not sure about AsciiDoc limitations. For example systemd guys uses
DocBook which is probably ultimate solution.

> > 
> > If I did move man-pages, the most likely candidate would probably be
> > Sphinx, as is nowadays used in the kernel docs. But, that would
> > require converting a thousand pages or so, and  I have not so far had
> > the stomach for that. Of course, you have a rather smaller set of
> > pages to deal with, so a conversion step sould be more easily
> > entertained.
> 
> Even though man pages are limitted in formatting, they are universally
> available and, from our POV, getting more attention from the
> translators side. We just welcomed our seventh language. Probably not 
> relevant for kenel side docs, but for programs by non programmers (and 
> presumably non native speakers) man pages are good option.

The idea is maintain documentation (in git tree) in some content
oriented language and then generate man pages from this content. It
means in the official release tarball will be man pages and end-users
will not see any difference.

The issue I have with man pages is that contributor very often send
patches to change formatting details and keep it consistent, avoid
color-of-bike-shed discussions is very difficult. It would be better
care about content and keep all the formatting details in some
conversion template.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


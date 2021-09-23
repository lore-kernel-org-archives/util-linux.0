Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4CC433F5
	for <util-linux@archiver.kernel.org>; Thu, 23 Sep 2021 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7DC60F39
	for <util-linux@archiver.kernel.org>; Thu, 23 Sep 2021 10:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbhIWKZs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 23 Sep 2021 06:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235605AbhIWKZs (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Sep 2021 06:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632392656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy+qq/qQbyVi8AEEZ225p2/fggrNXwx0/KltiVr4Cf8=;
        b=EeQzxjNTgJ4pOxzAGNz5+wbMR8jFyp4KNFmsWYBnPDm27jKQ4643ZwgKVTJGmCRfUUnxJR
        Jijh04eQLZ+08J3bgH80OCIUVvgHFJ0m+dOqTxjKn9bhUADJ9M9Gyyk9W7uyqTVie3+/J0
        1Ke0BUL16IpRyYREFqynUUrZz/Yn7YA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-Xba62-ZZMtOa4yHzCIDkag-1; Thu, 23 Sep 2021 06:24:14 -0400
X-MC-Unique: Xba62-ZZMtOa4yHzCIDkag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A4A180830E;
        Thu, 23 Sep 2021 10:24:14 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4F277E26;
        Thu, 23 Sep 2021 10:24:13 +0000 (UTC)
Date:   Thu, 23 Sep 2021 12:24:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: agetty.8.adoc: Replace /usr/lib with a variable?
Message-ID: <20210923102410.n3hylc6muys34por@ws.net.home>
References: <CAHi0vA__mxJoQ4c2jqZsZiR+omLqwwRAcKb4J+Ypp=5qqDwKpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA__mxJoQ4c2jqZsZiR+omLqwwRAcKb4J+Ypp=5qqDwKpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 21, 2021 at 09:17:48PM +0200, Mario Blättermann wrote:
> in agetty.8.adoc the file path /usr/lib/ is hardcoded. At least the
> Mageia distribution (possibly others, too) uses /usr/lib64 for the
> x86_64 version instead. Would it be better to use {libdir} and let
> replace it on demand by a ./configure option? As far as I can
> evaluate, this should work with an option in Makefile.am:
> 
> AM_CPPFLAGS = \
> ...
>         -D_PATH_LIBDIR=\"${libdir}\"
> 
> Similarly, we could think about to replace all file paths in man pages
> which are configurable during the installation.

Yes, use variables is perfect solution, go ahead and send patch ;-)

For now there is a problem that we distribute in tarball already
generated man pages (to avoid dependence on asciidoctor for some
use-cases). Maybe all we need is to add some sed(1) call to "if
HAVE_MANPAGES" section to modify these man pages. I'll try to improve
it. Anyway, for .adoc files is this irrelevant issue.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


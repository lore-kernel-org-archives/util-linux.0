Return-Path: <SRS0=3CY+=3R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE67C2D0DB
	for <util-linux@archiver.kernel.org>; Tue, 28 Jan 2020 12:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6621424681
	for <util-linux@archiver.kernel.org>; Tue, 28 Jan 2020 12:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExwIkkcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgA1MH7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:07:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44370 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726057AbgA1MH7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Jan 2020 07:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580213278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SQP8KqBascu6xwwAl/ip2/mxQ7ff22YnY+PDbkpxtLc=;
        b=ExwIkkcuZGol6g1OUW4sCqsbOt7MlWsPe7vSbWFUqxSVOtff5jHjdMwlZPPWir5PWXY2+q
        6gb+2+neKCFd7SXpZeCizOoQRPcvRnqYSGfGTj8/9EIp1TmMziGSe/ezLusDUhSdBtUbNE
        mPoEi1a9c2UwVosFcAIdDJb2P3spNmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-PrpA2d7HO-uJY3acLSBWSg-1; Tue, 28 Jan 2020 07:07:37 -0500
X-MC-Unique: PrpA2d7HO-uJY3acLSBWSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C66AC189F760;
        Tue, 28 Jan 2020 12:07:36 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DFE019E9C;
        Tue, 28 Jan 2020 12:07:35 +0000 (UTC)
Date:   Tue, 28 Jan 2020 13:07:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: fix configure --without-systemd
Message-ID: <20200128120733.s3n7f5gidsorwii7@ws.net.home>
References: <20200124172947.877099-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124172947.877099-1-tytso@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 24, 2020 at 12:29:47PM -0500, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 84b375543..595d57cf1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -2215,7 +2215,7 @@ AM_CONDITIONAL([HAVE_BTRFS], [test "x$have_btrfs" = xyes])
>  
>  AC_ARG_WITH([systemd],
>    AS_HELP_STRING([--without-systemd], [do not build with systemd support]),
> -  [], [with_systemd=check]
> +  [], [with_systemd=no]

The current default is to check for the libraries, if installed than
enable systemd support. This is generic way we use for many libs and
features. Why do you think that explicit --enable-* will be better?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


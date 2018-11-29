Return-Path: <SRS0=CT6f=OI=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512BDC43441
	for <util-linux@archiver.kernel.org>; Thu, 29 Nov 2018 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A91120834
	for <util-linux@archiver.kernel.org>; Thu, 29 Nov 2018 10:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A91120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeK2Vmg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:42:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeK2Vmg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Nov 2018 16:42:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 127913002C96;
        Thu, 29 Nov 2018 10:37:42 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 520965C7AA;
        Thu, 29 Nov 2018 10:37:40 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:37:38 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <casantos@datacom.com.br>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: make fdisk, sfdisk, cfdisk optional (enabled
 by default)
Message-ID: <20181129103738.n3xqiemqlv5iibvm@ws.net.home>
References: <20181122150549.32675-1-casantos@datacom.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122150549.32675-1-casantos@datacom.com.br>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 29 Nov 2018 10:37:42 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 22, 2018 at 01:05:49PM -0200, Carlos Santos wrote:
>  configure.ac | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Applied with a small change, thanks.

> +AC_ARG_ENABLE([fdisk],

renamed to --disable-fdisks

> +  AS_HELP_STRING([--disable-fdisk], [do not build fdisk(8), sfdisk(8) and cfdisk(8)]),
> +  [], [UL_DEFAULT_ENABLE([fdisk], [check])]
> +)

It seems better to initialize $enable_fdisk, $enable_sfdisk and
$enable_cfdisk to keep UL_BUILD_INIT() and UL_REQUIRES_* usable.

    Karel

> +UL_BUILD_INIT([fdisk])
>  UL_REQUIRES_HAVE([fdisk], [openat], [openat functions])
>  UL_REQUIRES_BUILD([fdisk], [libfdisk])
>  UL_REQUIRES_BUILD([fdisk], [libsmartcols])
>  AM_CONDITIONAL([BUILD_FDISK], [test "x$build_fdisk" = xyes])
>  
>  
> -UL_BUILD_INIT([sfdisk], [check])
> +UL_BUILD_INIT([sfdisk])
>  UL_REQUIRES_HAVE([sfdisk], [openat], [openat functions])
>  UL_REQUIRES_BUILD([sfdisk], [libfdisk])
>  UL_REQUIRES_BUILD([sfdisk], [libsmartcols])
> -AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_sfdisk" = xyes])
> +AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_fdisk" = xyes])
>  
>  
> -UL_BUILD_INIT([cfdisk], [check])
> +UL_BUILD_INIT([cfdisk])
>  UL_REQUIRES_BUILD([cfdisk], [libfdisk])
>  UL_REQUIRES_BUILD([cfdisk], [libsmartcols])
>  UL_REQUIRES_HAVE([cfdisk], [open_memstream], [open_memstream function])
>  UL_REQUIRES_HAVE([cfdisk], [ncursesw,slang,ncurses], [ncursesw, ncurses or slang library])
> -AM_CONDITIONAL([BUILD_CFDISK], [test "x$build_cfdisk" = xyes])
> +AM_CONDITIONAL([BUILD_CFDISK], [test "x$build_fdisk" = xyes])
>  
>  
>  AC_ARG_ENABLE([mount],
> -- 
> 2.14.5
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD20C433E0
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C854F22515
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 10:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbhAEK3F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 05:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727841AbhAEK3F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 05:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609842459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+2C//EOqsieFnGvdJepqDDj76nZReKdjSEeLaPMoO3Q=;
        b=QrU3RI9uTfbsY0YAAekpOFStFNpGMw2fjjpPFXO8yPNKDCXJGPuvcSqTNWntixEcu5F9QW
        YI25kiymklBcannODoxfnBCZEKEgWakzK3rxcTRxD3SLolb8Q7sYfPuwh+mUiOddtj+H7z
        y//PwKNBDV1TBK8/3mRlwQkv3Fn6tS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-d_5hyT34NEuz8JwOfXHPbg-1; Tue, 05 Jan 2021 05:27:34 -0500
X-MC-Unique: d_5hyT34NEuz8JwOfXHPbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B516D180E470
        for <util-linux@vger.kernel.org>; Tue,  5 Jan 2021 10:27:33 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B2B47092D;
        Tue,  5 Jan 2021 10:27:32 +0000 (UTC)
Date:   Tue, 5 Jan 2021 11:27:30 +0100
From:   Karel Zak <kzak@redhat.com>
To:     David O'Brien <daobrien@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Bug in lsblk command or man page?
Message-ID: <20210105102730.w5qxkr3qg353evlr@ws.net.home>
References: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 24, 2020 at 11:14:04AM +1000, David O'Brien wrote:
> I don't know if this is expected or not, but it seems very odd:
> 
> # lsblk -o=UUID /stratis/labpool/labfs
> lsblk: unknown column: =UUID
> 
> [root@serverb ~]# lsblk -o UUID /stratis/labpool/labfs
> UUID
> 0118efb8-66fe-406a-837c-725961bdad4d
> 
> [root@serverb ~]# lsblk --output=UUID /stratis/labpool/labfs
> UUID
> 0118efb8-66fe-406a-837c-725961bdad4d
> 
> 
> From the man(8) page:
> -o, --output list
>               Specify which output columns to print.  Use --help to get
>               a list of all supported columns.  The columns may affect
>               tree-like output.  The default is to use tree for the
>               column 'NAME' (see also --tree).
> 
>               The default list of columns may be extended if list is
>               specified in the format +list (e.g., lsblk -o +UUID).
> 
> There is no mention of "=" being required, causing failures, etc. I found this quite frustrating.
> 

This is common getopt_long() behavior where equal sign is usable only for
long options (and sometimes for optional arguments).

 lsblk -o UUID
 lsblk --output UUID
 lsblk --output=UUID

this is how "=" works in almost all commands and I don't see reason
why we need to be explicit about it for "lsblk -o".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


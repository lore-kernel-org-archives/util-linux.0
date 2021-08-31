Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A86C432BE
	for <util-linux@archiver.kernel.org>; Tue, 31 Aug 2021 08:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8D360FE8
	for <util-linux@archiver.kernel.org>; Tue, 31 Aug 2021 08:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbhHaItk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:49:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240366AbhHaItj (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Aug 2021 04:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630399724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MocBzAPPoMCvjOzNMokYA11Rv3rAcFVG1PzVersZ1ss=;
        b=XB+v8nB0U0Z4rETu5VLGl0v6mqCe9FPQQbY+su4TRQ77GAZx1Io3+AjB+zDqu0OcoO6Jaq
        qUId/3SzJkyKxj38WoqpxekTeKFHlUv8BKChBpcBYnuKhe51ITs2gIEzVSww9MN31NYImT
        Uv+fimuV2EXYDwtbvFX78KNXCjBJ/4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-WBCB1uaGP6aBs_iG_gvi3w-1; Tue, 31 Aug 2021 04:48:41 -0400
X-MC-Unique: WBCB1uaGP6aBs_iG_gvi3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F2B180196F;
        Tue, 31 Aug 2021 08:48:40 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3148727089;
        Tue, 31 Aug 2021 08:48:39 +0000 (UTC)
Date:   Tue, 31 Aug 2021 10:48:36 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, Damien.LeMoal@wdc.com
Subject: Re: [PATCH v3 0/3] add columns for zoned parameters
Message-ID: <20210831084836.fqqfkbxcwqkuyshg@ws.net.home>
References: <20210830055257.1832523-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830055257.1832523-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Aug 30, 2021 at 02:52:54PM +0900, Naohiro Aota wrote:
> Naohiro Aota (3):
>   lsblk: factor out function to read sysfs param as bytes
>   lsblk: add columns of zoned parameters
>   lsblk: add zoned columns to "lsblk -z"
> 
>  bash-completion/lsblk   |   3 +-
>  misc-utils/lsblk.8.adoc |   2 +-
>  misc-utils/lsblk.c      | 104 ++++++++++++++++++++++++++++++----------
>  3 files changed, 82 insertions(+), 27 deletions(-)


 Applied, thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


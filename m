Return-Path: <SRS0=VVbZ=YE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6662FC47404
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53D214E0
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 06:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfJKG6q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfJKG6q (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 11 Oct 2019 02:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F1978A26698;
        Fri, 11 Oct 2019 06:58:45 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D1FD196B2;
        Fri, 11 Oct 2019 06:58:45 +0000 (UTC)
Date:   Fri, 11 Oct 2019 08:58:42 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Add modules.builtin.modinfo support
Message-ID: <20191011065842.f5tm6ynkbltiqcyq@10.255.255.10>
References: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010120928.3817287-1-gladkov.alexey@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 11 Oct 2019 06:58:46 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Alexey, it seems you need another mailing list for libkmod, see:
 https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/about/

 Thanks,
   Karel

> Alexey Gladkov (4):
>   libkmod: Add parser for modules.builtin.modinfo
>   libkmod: Add function to get list of built-in modules
>   Lookup aliases in the modules.builtin.modinfo
>   modinfo: Show information about built-in modules
> 
>  Makefile.am                |   1 +
>  libkmod/libkmod-builtin.c  | 231 +++++++++++++++++++++++++++++++++++++
>  libkmod/libkmod-internal.h |  10 ++
>  libkmod/libkmod-module.c   |  76 ++++++++++--
>  libkmod/libkmod.c          |  25 ++++
>  libkmod/libkmod.h          |   1 +
>  tools/depmod.c             |  63 ++++++++++
>  tools/modinfo.c            |  39 ++++---
>  8 files changed, 419 insertions(+), 27 deletions(-)
>  create mode 100644 libkmod/libkmod-builtin.c
> 
> -- 
> 2.21.0
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

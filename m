Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F0C63777
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B012220B
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 09:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPr4DH/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKTJHn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 04:07:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgKTJHn (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 20 Nov 2020 04:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605863262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFeMpPjemkuTvF5Nl58HRRgv0iyjaEAqZWG2Sxs6Nig=;
        b=XPr4DH/NfckN6gPD7lYeif01+WXre+6g7dEjdKuyyDrHS85Dy27J6jVj1FQJ3RHBf1Z9jN
        IPm2eSRweJAUyNJfBUZ0CwJQv47icg+JRuh/eLJsKbbccQpH4Il80F6NeXenbMUAXBCO14
        kNyzH3NdufwdJ58a3EruTbYQmw4nIyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-t-3lfHKpOhaHBVNLLScXlQ-1; Fri, 20 Nov 2020 04:07:38 -0500
X-MC-Unique: t-3lfHKpOhaHBVNLLScXlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094E0612ED;
        Fri, 20 Nov 2020 09:07:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EE1A1349A;
        Fri, 20 Nov 2020 09:07:35 +0000 (UTC)
Date:   Fri, 20 Nov 2020 10:07:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v3 0/5] lscpu: Fix socket information on aarch64 machine
Message-ID: <20201120090733.3ah7zrgwdsqwpasb@ws.net.home>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Nov 20, 2020 at 12:06:04AM -0500, Masayoshi Mizuma wrote:
> Masayoshi Mizuma (5):
>   lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
>   lscpu-virt: split hypervisor_from_dmi_table()
>   lscpu-dmi: Move some functions related to DMI to lscpu-dmi
>   lscpu: add helper to get physical sockets
>   lscpu: show the number of physical socket on aarch64 machine without
>     ACPI PPTT
> 
>  sys-utils/Makemodule.am |   1 +
>  sys-utils/lscpu-arm.c   |  15 ++++++
>  sys-utils/lscpu-dmi.c   | 108 ++++++++++++++++++++++++++++++++++++++++
>  sys-utils/lscpu-virt.c  |  62 ++++++-----------------
>  sys-utils/lscpu.1       |   3 ++
>  sys-utils/lscpu.c       |  39 ++++++++++++---
>  sys-utils/lscpu.h       |  38 ++++++--------
>  7 files changed, 190 insertions(+), 76 deletions(-)
>  create mode 100644 sys-utils/lscpu-dmi.c


Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


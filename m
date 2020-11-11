Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0EC56201
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C61206E3
	for <util-linux@archiver.kernel.org>; Wed, 11 Nov 2020 08:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TR22qhel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKIoF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgKKIoE (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 11 Nov 2020 03:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605084243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=evNTjiTRrMC0n3Irs5bmQWoUTXJPsmNzLatCnvLFVMg=;
        b=TR22qhel1Nko0UhTFQVsHIS+JCHdcb7ozSvUu/JGW3FlY+ByzNC1uoMamgidmYUel/Xy7B
        Z21FqFb+KW23EtVXK3TdSYzBzJiteIFmjBIDvdgcsQS8UZU4u8aSEC6qfizMAGpYqes0L7
        2ru/cl5hlb0HBhD9e/a3cXmrPfcdr0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-yGGHxWdAPzK6apnpnF4ozA-1; Wed, 11 Nov 2020 03:44:02 -0500
X-MC-Unique: yGGHxWdAPzK6apnpnF4ozA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0411891E84;
        Wed, 11 Nov 2020 08:44:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4162D6EF76;
        Wed, 11 Nov 2020 08:43:59 +0000 (UTC)
Date:   Wed, 11 Nov 2020 09:43:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        jeremy.linton@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v5] lscpu-arm: Add "BIOS Vendor ID" and "BIOS Model name"
 to show the SMBIOS information.
Message-ID: <20201111084356.igcrkrqzx52npb2q@ws.net.home>
References: <20201111012400.23995-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111012400.23995-1-msys.mizuma@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 08:24:00PM -0500, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> After commit: 367c85c47 ("lscpu: use SMBIOS tables on ARM for lscpu"),
> Model name for A64FX shows like as:
> 
>    Model name:       461F0010
> 
> That's because 367c85c47 changes to get the modelname from Processor
> Version of SMBIOS.
> 
> To fix that, use the hard corded table to show the "Model name" and
> add two new lines; "BIOS Vendor ID" and "BIOS Model name" to show the
> SMBIOS information.
> 
> lscpu shows the SMBIOS information when root user runs it because
> accessing the SMBIOS information requires root privilege.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  sys-utils/lscpu-arm.c | 22 ++++++++--------------
>  sys-utils/lscpu.c     |  4 ++++
>  sys-utils/lscpu.h     |  2 ++
>  3 files changed, 14 insertions(+), 14 deletions(-)

OK, I'll integrate it to my new lscpu later this week. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


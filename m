Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CDC388F7
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 09:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FD922249
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 09:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtr2DBG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgKMJ7P (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 04:59:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKMJ7P (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Nov 2020 04:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605261554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEWRg0qvS6Av9EeklPSCObpMFE1dSbWDG2SvXPixc3s=;
        b=Mtr2DBG3WIWRJg8861+mHh75AiuKJpACHoU+anwMj12QPFw3fQLDMwbRx6bEnorRPovoUz
        vEBM3VfYFstpThj9TZhhmyn0YA7wYrct89gOw7REINHb0X8T7bpzUF16QW4uhXzWXPp6OB
        BrVx5y4QZrcsextyIHLspvMJlqJg/gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-Gxki3hcuNDihErVGie94_Q-1; Fri, 13 Nov 2020 04:59:12 -0500
X-MC-Unique: Gxki3hcuNDihErVGie94_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A19F835B49;
        Fri, 13 Nov 2020 09:59:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA05360C0F;
        Fri, 13 Nov 2020 09:59:09 +0000 (UTC)
Date:   Fri, 13 Nov 2020 10:59:06 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com,
        jeremy.linton@arm.com, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH v5] lscpu-arm: Add "BIOS Vendor ID" and "BIOS Model name"
 to show the SMBIOS information.
Message-ID: <20201113095906.tjd5iee4xb6cd72d@ws.net.home>
References: <20201111012400.23995-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111012400.23995-1-msys.mizuma@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 08:24:00PM -0500, Masayoshi Mizuma wrote:
>  sys-utils/lscpu-arm.c | 22 ++++++++--------------
>  sys-utils/lscpu.c     |  4 ++++
>  sys-utils/lscpu.h     |  2 ++
>  3 files changed, 14 insertions(+), 14 deletions(-)

Ported to the new lscpu and merged. Thanks (and extra thanks for
your patience :-).

I see one issue with the stuff from BIOS. It seems it reads the
information always from the same place. How does it work if I have two
different CPUs? I guess it always return the same model name, but what
if I have Cortex-A53 and Cortex-A72 on the same board?

Maybe we should disable reading from BIOS on systems with more than
one CPU type.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


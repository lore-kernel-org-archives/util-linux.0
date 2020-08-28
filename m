Return-Path: <SRS0=8KZJ=CG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05061C433E2
	for <util-linux@archiver.kernel.org>; Fri, 28 Aug 2020 07:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC33320CC7
	for <util-linux@archiver.kernel.org>; Fri, 28 Aug 2020 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm4a2khd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgH1HSV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:18:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48805 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbgH1HSU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 28 Aug 2020 03:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598599099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fh7rNLuxgSqX5xImnkKz5W3atabk18NGomO4TBwxUUE=;
        b=Pm4a2khdPhBQsErk+rHv8+2hUrA6BqoVrAL0l0DQQ4dMXWohs5uXksATarkqrm2ImANmiQ
        kdAbN2KrvvrqL0Vz0SYl0Ed2OZJUV8T04W31hllyeNPsHhQepjfsaclU9lESNRW2HOqbGM
        N4+W7L5QUg3Dg0kb8DDHx5D2iD2n2M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-9i_wb3oZNLeeTGjKf0AUvw-1; Fri, 28 Aug 2020 03:18:13 -0400
X-MC-Unique: 9i_wb3oZNLeeTGjKf0AUvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8217100855A;
        Fri, 28 Aug 2020 07:18:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 240E11001B2B;
        Fri, 28 Aug 2020 07:18:11 +0000 (UTC)
Date:   Fri, 28 Aug 2020 09:18:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Manual pages: blockdev.8, sfdisk.8: typo fixes
Message-ID: <20200828071809.qsmvuz43vqfcizet@ws.net.home>
References: <20200827151245.97613-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827151245.97613-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 27, 2020 at 05:12:45PM +0200, Michael Kerrisk (man-pages) wrote:
>  disk-utils/blockdev.8 | 2 +-
>  disk-utils/sfdisk.8   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


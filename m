Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97288C433E8
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 07:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6876E2073E
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 07:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAY8Yquc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXHM6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:12:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23505 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726554AbgGXHM5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 03:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595574777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uxzrBCphZX+k5Ks7OsPo7CA0kQt+LqmSXrQwMpHI6Bg=;
        b=fAY8Yquc/n9M/u4JajQBsrcWKLe+rL8tWNpBR/zn3yx8H5ntMx73T/oGsVzu3Dwe5h+Mkv
        9XAxxLj6Td4x1xoJeYMh+fcgWnEwX/MyD7xGSVsp0Sz5+KJLUBN7g16oN3PecHdCTPTdp6
        xLx9A0ssn+KS1LmQuhE2+kgnz6oHMzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-5mJ1JFuFPXylGmq79ycdUA-1; Fri, 24 Jul 2020 03:12:51 -0400
X-MC-Unique: 5mJ1JFuFPXylGmq79ycdUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92B181005504;
        Fri, 24 Jul 2020 07:12:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D23095D9F1;
        Fri, 24 Jul 2020 07:12:49 +0000 (UTC)
Date:   Fri, 24 Jul 2020 09:12:47 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] manpages: fix "The example command" in AVAILABILITY
 section
Message-ID: <20200724071247.ctrvpghhkiqdltnw@ws.net.home>
References: <20200723223141.3718-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723223141.3718-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jul 23, 2020 at 10:31:41PM +0000, Chris Hofstaedtler wrote:
>  disk-utils/fsck.cramfs.8 | 2 +-
>  disk-utils/mkfs.cramfs.8 | 2 +-
>  misc-utils/uuidparse.1   | 2 +-
>  sys-utils/irqtop.1       | 2 +-
>  sys-utils/lsirq.1        | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Oh, good catch. Applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


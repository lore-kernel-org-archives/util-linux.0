Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC11EC433E0
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7651120721
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9rYYL1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2Mn3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 08:43:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49510 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgE2Mn2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 May 2020 08:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590756208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cAVAp6VE/4Fj2OyGRr3DTom+YHKAB5SJqr45Qgvb+6I=;
        b=Q9rYYL1B50I7CRnsk4EppJDx+ckI2AhnvnWgT8ZyBiYb7iZ4j5Nq2X3Z2RYs+yucak1x08
        vOP2mhkdegUocFVPQEL0DnxKEbCD33Ew5mEn2ol0jmG/OapcH/Ji5xetNymr4Gx+eftK69
        DoiqFmkU34X4EwEfATKlxsRyiGxrVeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-c1V4V9moMDKWaZ0D9f5NdA-1; Fri, 29 May 2020 08:43:26 -0400
X-MC-Unique: c1V4V9moMDKWaZ0D9f5NdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FF2E107ACF2;
        Fri, 29 May 2020 12:43:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 372D22BFF9;
        Fri, 29 May 2020 12:43:23 +0000 (UTC)
Date:   Fri, 29 May 2020 14:43:21 +0200
From:   Karel Zak <kzak@redhat.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] Manual pages: unshare.1: EXAMPLES: improve
 persistent mount namespace example
Message-ID: <20200529124321.5lgp3ojlqti7xqtf@ws.net.home>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
 <20200529074611.kjzmhxyvee6jxe7g@ws.net.home>
 <c5aba53a-2da8-934d-5ab2-330931af0b23@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5aba53a-2da8-934d-5ab2-330931af0b23@physik.fu-berlin.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 29, 2020 at 10:54:03AM +0200, John Paul Adrian Glaubitz wrote:
> > All 10 patches applied. Thanks!
> I just wanted to say Thank You to you for being such a busy maintainer! It's really

Thanks to Red Hat -- it's my fulltime job (together maintenance for RHEL/Fedora).

> refreshing to see how fast new patches are reviewed and applied for util-linux
> knowing that in other projects, reviews can take days or even weeks!

Well, on github we have some pending issues/PR ...

Thanks for your feedback :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


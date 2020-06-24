Return-Path: <SRS0=qu+V=AF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AC4C433E0
	for <util-linux@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30AC220738
	for <util-linux@archiver.kernel.org>; Wed, 24 Jun 2020 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJmoGV3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391216AbgFXOl0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:41:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390251AbgFXOl0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jun 2020 10:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593009685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KhCfNrG5TN7pRlCF4TmUaVape9tJbfhdm9ogRyD30KU=;
        b=cJmoGV3nrRlDcz9fskV2Pss1+699yF64L7XolKu9YESne5VCT9ECv4fkB+96quykcn1ycz
        IepjnMlHhwOwNJMPFaQJpzYobAfTY3tpX8N4LUxJDrFQrCfZR3Wk56zMXWfi08/Q3clmQN
        EY+a+B2DyRMOs+eo4ZuEQE8g9P68WV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-u1BuJaJnP068nf6jwS0e_Q-1; Wed, 24 Jun 2020 10:41:21 -0400
X-MC-Unique: u1BuJaJnP068nf6jwS0e_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB150800D5C;
        Wed, 24 Jun 2020 14:41:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD9886106A;
        Wed, 24 Jun 2020 14:41:19 +0000 (UTC)
Date:   Wed, 24 Jun 2020 16:41:17 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] hexdump: automatically use -C when called as hd
Message-ID: <20200624144117.k2aiarwbz6puqxkc@ws.net.home>
References: <20200623001430.890832-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623001430.890832-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 23, 2020 at 12:14:30AM +0000, Chris Hofstaedtler wrote:
> When invoking hexdump as hd enable the "Canonical" format to by
> default, implying the -C option.

Well, I personally prefer aliases too, but ...

> This is historic behaviour on Debian and apparently also on FreeBSD.
> Some Debian users have asked for this to be restored, after Debian
> switched to util-linux' hexdump and hd.

if BSD implements it 24 years ago than it's probably good idea to
follow this manner to make util-linux more portable. 

Merged to the "next" branch (it's too late for v2.36).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


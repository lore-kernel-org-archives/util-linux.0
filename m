Return-Path: <SRS0=qkB4=7X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79951C433E0
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 08:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B212064C
	for <util-linux@archiver.kernel.org>; Wed, 10 Jun 2020 08:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWTbfZtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFJIZp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:25:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50449 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726512AbgFJIZp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Jun 2020 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591777544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDXzrqJ1KG3Av94AoYtKMUUUbeWR8t0yG/k/X+x56zw=;
        b=UWTbfZtEick2HiBpo6vQZIzCTG9UTTNpekWD8J3VCEjZIpOhYdOrc9KAHyIUSw/XdOZGKl
        ChpqCDoqKtTHIjztxhwjMnhsvIz6xyU9+QZrufY1GujulYYCfrv2gFrNq8QFPROiJJIqkY
        hW7ZixSMbr/wTtYCzxpnPgmbYs6ykeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-EDo2_vVNPeqcLX8Ax_K0Pg-1; Wed, 10 Jun 2020 04:25:39 -0400
X-MC-Unique: EDo2_vVNPeqcLX8Ax_K0Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7C5B18A8224;
        Wed, 10 Jun 2020 08:25:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E52681A7CE;
        Wed, 10 Jun 2020 08:25:36 +0000 (UTC)
Date:   Wed, 10 Jun 2020 10:25:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: Fix some warnings from "test-groff" for manuals
Message-ID: <20200610082533.xsxxjb4k4de5lgm3@ws.net.home>
References: <20200610021750.GA24504@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610021750.GA24504@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 10, 2020 at 02:17:50AM +0000, Bjarni Ingi Gislason wrote:
> <./sys-utils/mount.8>:68 (macro RB): only 1 argument, but more are expected
> troff: backtrace: '/home/bg/git/groff/build/s-tmac/an-old.tmac':467: macro 'RB'
> troff: backtrace: file '<./sys-utils/mount.8>':68
> troff: <./sys-utils/mount.8>:68: warning [p 1, 3.5i]: can't break line
> an-old.tmac: <./sys-utils/mount.8>:201 (.RE): warning: extra .RE or .RS is missing before it; "an-RS-open" is 0.

I have modified the patch and added .RS (rather than remove .RE) to
keep indention.
 
Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


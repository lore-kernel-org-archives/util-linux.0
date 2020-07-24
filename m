Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB10C433EC
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A22073E
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3RZO+b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgGXHQ5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:16:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45347 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726607AbgGXHQ5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Jul 2020 03:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595575016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ax0EzujKPxtmXcTC2oCQP2/Pq7h9ae3+W0pUNv4jlLo=;
        b=S3RZO+b2cVnVj/KlCxBbz3v0zfG13Dq7co+Y0LlIwsp9J/AEPlpkPXRTTaTZPyiY96Vqi7
        XKGpoSdlTjUphWuoK+pYWpeEl1AA+bTpREHtAq18hR7sncz1NM2HOlx0y5oWADzQCTfOqd
        eLdwbY7UxJ1ZzoTslLs3sGRc7aCsp08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-3VmJTV3JO6a5lDykxEPvew-1; Fri, 24 Jul 2020 03:16:51 -0400
X-MC-Unique: 3VmJTV3JO6a5lDykxEPvew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68DE3800473;
        Fri, 24 Jul 2020 07:16:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A4EF78BEF3;
        Fri, 24 Jul 2020 07:16:49 +0000 (UTC)
Date:   Fri, 24 Jul 2020 09:16:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: fix expected test output on alpha
Message-ID: <20200724071646.7xrf7esfrvf3ab4u@ws.net.home>
References: <20200724003509.19927-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724003509.19927-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jul 24, 2020 at 12:35:09AM +0000, Chris Hofstaedtler wrote:
>  tests/expected/fdisk/bsd_0_64_alpha.LE | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

It would be nice to report Debian tests' issues during -rc1 or -rc2.
It's a little bit annoying to have such bug report one day after
release ;-)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


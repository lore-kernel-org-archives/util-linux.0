Return-Path: <SRS0=qu+V=AF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC904C433E0
	for <util-linux@archiver.kernel.org>; Wed, 24 Jun 2020 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD78220C09
	for <util-linux@archiver.kernel.org>; Wed, 24 Jun 2020 13:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+/eRU9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbgFXNqS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:46:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21318 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391076AbgFXNqR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2020 09:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593006377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=atPT2Di5NuyTXe8TZ7NWkFz52S/Qryw30v3eNpM3LOE=;
        b=E+/eRU9xBLTUiXmLAlUHGRdNWpWBXecXN13kywy1u+cYu4+WW8S11HCu4H6UdxjcazVtXg
        Ihi0kMUVX+feyFMGpD7g1vvumqOg1DJKpLFwnCUwtMUeOrvfzFYR3FJFSCk3CiqcQsMdY6
        BDvQY0iPn72sk6FDg/Tzgxc/PkgDOls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-4hC0cyubPsqcIl7SMz0JTg-1; Wed, 24 Jun 2020 09:46:14 -0400
X-MC-Unique: 4hC0cyubPsqcIl7SMz0JTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D568F1B18BD2;
        Wed, 24 Jun 2020 13:46:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8A25512FE;
        Wed, 24 Jun 2020 13:46:12 +0000 (UTC)
Date:   Wed, 24 Jun 2020 15:46:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Mark Hindley <mark@hindley.org.uk>
Subject: Re: [PATCH] Fix mountpoint test failure in build chroots.
Message-ID: <20200624134610.kgix65mkmo352iyt@ws.net.home>
References: <20200622235209.816843-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622235209.816843-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 22, 2020 at 11:52:09PM +0000, Chris Hofstaedtler wrote:
>  tests/expected/misc/mountpoint-default  |  2 +-
>  tests/expected/misc/mountpoint-nofollow |  2 +-
>  tests/ts/misc/mountpoint                | 15 +++++++++++----
>  3 files changed, 13 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


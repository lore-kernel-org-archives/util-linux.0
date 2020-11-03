Return-Path: <SRS0=zhuq=EJ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67BEC2D0A3
	for <util-linux@archiver.kernel.org>; Tue,  3 Nov 2020 11:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F31B206B5
	for <util-linux@archiver.kernel.org>; Tue,  3 Nov 2020 11:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5aqwPHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKCLj0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728458AbgKCLjY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Nov 2020 06:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604403563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4txHnYPpJiRPTd3WeI/vfNU8FRzKemuFZAefw4fckWs=;
        b=b5aqwPHAzkWTbF0QfqTFmTYHgtyeHWUT04kc6y/AiURvRryoO/VNym9nLRixR1TIFfrUPU
        DQ6ozMu/gdz6alJOTpNpZQXDhAMTWl7V35VBfIgr8cPDgAWXt5+1us/ASKXROZRp4Sroba
        ReAGKOhGlssfieD2Qtya/EcwDfFkJcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-33-m2RG0NiKg2itQ0qo4JA-1; Tue, 03 Nov 2020 06:39:19 -0500
X-MC-Unique: 33-m2RG0NiKg2itQ0qo4JA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86385107465D;
        Tue,  3 Nov 2020 11:39:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E94775124;
        Tue,  3 Nov 2020 11:39:17 +0000 (UTC)
Date:   Tue, 3 Nov 2020 12:39:14 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sami Kerola <kerolasa@iki.fi>
Cc:     cryintothebluesky@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/randutils: rename random_get_bytes()
Message-ID: <20201103113914.ifjrmgmo6gf3or5q@ws.net.home>
References: <20201101141608.ba365cf67d92ee3973226de9@gmail.com>
 <20201102222618.40770-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102222618.40770-1-kerolasa@iki.fi>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 02, 2020 at 10:26:18PM +0000, Sami Kerola wrote:
>  include/randutils.h    | 2 +-
>  lib/randutils.c        | 6 +++---
>  libfdisk/src/dos.c     | 2 +-
>  libuuid/src/gen_uuid.c | 6 +++---
>  misc-utils/mcookie.c   | 2 +-
>  sys-utils/ipcmk.c      | 6 +++---
>  6 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


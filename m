Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B47C48BE8
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 15:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542676102A
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 15:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhFRPz1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 18 Jun 2021 11:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233880AbhFRPz0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Jun 2021 11:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624031596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZnKPcDEHFGiVVzPXHogPbfigixOsZaIlJZqblBPL+5E=;
        b=cNjRzrF5rzs5ecJlOhKU5kshf/3dYVCNyRgsfEVYXxyD5xfuLsstFFHxmCFg6W68rcnXuN
        fqexUY8norxwbBympXE5NrEmkUaOvNEcxGC+KJJlmbzfZIzBeNj0h1tjiIWgNJZ0Be2i4B
        qi55+Dox+gLEFCjkHClVk5HpJEd8AZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-gQfp7BbCOqWTYlmsNP1SKA-1; Fri, 18 Jun 2021 11:53:15 -0400
X-MC-Unique: gQfp7BbCOqWTYlmsNP1SKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B91219611A0;
        Fri, 18 Jun 2021 15:53:13 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C5885DD68;
        Fri, 18 Jun 2021 15:53:11 +0000 (UTC)
Date:   Fri, 18 Jun 2021 17:53:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com
Subject: Re: [PATCH] lscpu: add more sanity checks for dmi_decode_cputype()
Message-ID: <20210618155309.526u3s5cexolex44@ws.net.home>
References: <20210618124632.16691-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618124632.16691-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 18, 2021 at 12:46:32PM +0000, Huang Shijie wrote:
>  sys-utils/lscpu-dmi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied, thanks!

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


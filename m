Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BC3C11F65
	for <util-linux@archiver.kernel.org>; Wed, 30 Jun 2021 09:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EFFC61C9F
	for <util-linux@archiver.kernel.org>; Wed, 30 Jun 2021 09:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhF3JbI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhF3JbI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Jun 2021 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625045318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o1hYgag00O+tzOPq0CrQ7U14BANMrF8FrDNsOH1beNs=;
        b=X/LECoqhrjwEPel9y26Q85yduh8MEzlQ1FaaCt7vJbxtkIi1umV09yS4HoWONlRDHSVD0h
        XwD9trvraKevHTy0+fqfq5Z0/Kj33sLJNVqSZSXiqq0RWvtgV7cxw9R88sS5LrvpTNg+ts
        wyWJWsAxM/h7hHkNG4jvclYAuXgBm4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-9a3uspyWMuaEhn0qJMz_Ag-1; Wed, 30 Jun 2021 05:28:35 -0400
X-MC-Unique: 9a3uspyWMuaEhn0qJMz_Ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6371084F54;
        Wed, 30 Jun 2021 09:28:34 +0000 (UTC)
Received: from ws.net.home (ovpn-112-214.ams2.redhat.com [10.36.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E181260C17;
        Wed, 30 Jun 2021 09:28:31 +0000 (UTC)
Date:   Wed, 30 Jun 2021 11:28:29 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com
Subject: Re: [PATCH] lscpu: remove the old code
Message-ID: <20210630092829.reohvkzshmtqacrl@ws.net.home>
References: <20210617124116.6841-1-shijie@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617124116.6841-1-shijie@os.amperecomputing.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 17, 2021 at 12:41:16PM +0000, Huang Shijie wrote:
>  sys-utils/lscpu-arm.c | 46 +------------------------------------------
>  sys-utils/lscpu.h     |  1 -
>  2 files changed, 1 insertion(+), 46 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


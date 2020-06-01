Return-Path: <SRS0=/ORA=7O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EDFC433DF
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E30620734
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 07:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC/qJhu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFAH4u (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:56:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53629 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726056AbgFAH4u (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Jun 2020 03:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590998209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjOVNrFQyGxBR0r1V3fOmx+do84e/SZLW6CjnDm4eTg=;
        b=jC/qJhu/XzJZ8O31DP+BfPNt0rWJZ+XnHpGwkd1ls/qQF2/PbDQ9zxIyRVWt3eURromWo5
        eQaM5C14bZQSrIBIMnXlBtfHIMleRu3FcBUJ5fGctjUDICLX0WwR47XfrtR+9979hrqTPj
        k1oN2ncoUAfF/XyUyHeWJT9Tw8UB5UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-qbKwihhpNQWIMb_aqN7ddg-1; Mon, 01 Jun 2020 03:56:47 -0400
X-MC-Unique: qbKwihhpNQWIMb_aqN7ddg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059FB1005510;
        Mon,  1 Jun 2020 07:56:47 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4599360BEC;
        Mon,  1 Jun 2020 07:56:46 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:56:43 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: add --follow-new
Message-ID: <20200601075643.b5pmr55vkidobe3z@ws.net.home>
References: <159084767331.127122.9117317049390963928.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159084767331.127122.9117317049390963928.stgit@buzz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, May 30, 2020 at 05:07:53PM +0300, Konstantin Khlebnikov wrote:
>  bash-completion/dmesg |    1 +
>  sys-utils/dmesg.1     |    3 +++
>  sys-utils/dmesg.c     |   11 +++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


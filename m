Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F9C433EF
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 11:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9627B60F6D
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhI0Lxe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25378 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234037AbhI0Lxd (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Sep 2021 07:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632743515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fIrP38ExE2LzNAvUGrQBuDMzONjpG42jEfkq/RilwAs=;
        b=Go7xQuq6w+FNy8RhVUEh3kBAyWWslFvtwJGU8zo4JNYoE+cxtaNoRcWhSTFGyHwrNEFAHI
        JdyTVpagOCDe/fhEg4lT2tHnRECr8dj+zRautc/QoTdYNtsw9zYnrP+Uhc4Fiip+oRNN27
        TM50i5Ucd1AtOHLJr9mcs5fyaW3KmSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-4YH5AnnGOamwYKN2IyAlEQ-1; Mon, 27 Sep 2021 07:51:53 -0400
X-MC-Unique: 4YH5AnnGOamwYKN2IyAlEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B15F818125C4;
        Mon, 27 Sep 2021 11:51:52 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E055A60C13;
        Mon, 27 Sep 2021 11:51:51 +0000 (UTC)
Date:   Mon, 27 Sep 2021 13:51:49 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Eduard Bloch <blade@debian.org>
Subject: Re: [PATCH] Let user choose larger buffers for IO reading
Message-ID: <20210927115149.3466hzo2ezmhjzyi@ws.net.home>
References: <20210927070723.76950-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927070723.76950-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 27, 2021 at 09:07:23AM +0200, Chris Hofstaedtler wrote:
>  misc-utils/hardlink.1.adoc |  6 +++++
>  misc-utils/hardlink.c      | 50 ++++++++++++++++++++++++++++++++------
>  2 files changed, 49 insertions(+), 7 deletions(-)

 Good idea, merged (with small changes). Thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


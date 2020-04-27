Return-Path: <SRS0=WmqB=6L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83EC54FD0
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 09:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07994206A4
	for <util-linux@archiver.kernel.org>; Mon, 27 Apr 2020 09:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y90HFKCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgD0Jcx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:32:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21167 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbgD0Jcx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Apr 2020 05:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587979972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kX1i68DXyo98fYgAi/IX5E+V49lmQPLrN1gjrBe1wa4=;
        b=Y90HFKCdke1j0kMZZBTVXGH5364tesZFgONVUowtGf9DLKppjgOTJbsdh1Q/I829fBuxxx
        ECAwRm/k1Zkzpyzj+9LyWIpiXFKiJcj9CmEcI0Kt6r+gSDSkv9m4eQDOIgdtoKnOGTv0M4
        +2KHTXn3fDcYAgnFt3wmqxbNXM/vMGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-Gg05fTijPy2v9a-EBnBF1w-1; Mon, 27 Apr 2020 05:32:48 -0400
X-MC-Unique: Gg05fTijPy2v9a-EBnBF1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0678F107ACF3;
        Mon, 27 Apr 2020 09:32:47 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0411860612;
        Mon, 27 Apr 2020 09:32:45 +0000 (UTC)
Date:   Mon, 27 Apr 2020 11:32:43 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     util-linux@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH] docs: nsenter(1): fix further details in PID namespace
 section
Message-ID: <20200427093243.f5ot3lxtuevmjxpo@ws.net.home>
References: <20200423083702.14466-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423083702.14466-1-steve@sk2.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 23, 2020 at 10:37:02AM +0200, Stephen Kitt wrote:
>  sys-utils/nsenter.1 | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


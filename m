Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DAC433DF
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05D522472
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUGgaWoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGNMis (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:38:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28541 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728047AbgGNMis (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594730327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3m/lvBm0Wl1EVyfwx3ndQaJ2PHCAaFWJVZX18gWmTOA=;
        b=aUGgaWoeH8ScMszkNDTn/gHsjVSBwRaSknxoxzTdSbuijjmPMkXDPuDYG3cOdfksaXrBxN
        6tPsnNAWgb/b8Nhd319LqHent+MIYIadRsWtMtDlQt65OPZF7fX3rBemIV2LfDC4HyUCSe
        2BdkAQo1D0NV4p8BTlmfgdmQ9A+yczI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-sKrlUeVNNG-n26yzvaK4Xg-1; Tue, 14 Jul 2020 08:38:43 -0400
X-MC-Unique: sKrlUeVNNG-n26yzvaK4Xg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F3B94ABE;
        Tue, 14 Jul 2020 12:38:33 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F13BA79CE3;
        Tue, 14 Jul 2020 12:38:32 +0000 (UTC)
Date:   Tue, 14 Jul 2020 14:38:30 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 5/5] Manual pages: various: reword "allow(s) to"
Message-ID: <20200714123830.2tn46t3iv5yyd4r7@ws.net.home>
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
 <20200714095741.45292-5-mtk.manpages@gmail.com>
 <CAKgNAkhWAe-VDRQwkXC=crfZ117EfRd0Vw3keU2WYdrXkOSsTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhWAe-VDRQwkXC=crfZ117EfRd0Vw3keU2WYdrXkOSsTw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 14, 2020 at 02:13:01PM +0200, Michael Kerrisk (man-pages) wrote:
> +allows commands to be run with a substitute user and group ID.
> 
> Shall I resend the patch, or will you edit?

Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


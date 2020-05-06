Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4478BC28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F12B206D5
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Drv9YWFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEFNPg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:15:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgEFNPg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588770935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wh0z3f2TM4z6PUJXQM1QKaHr8JbQvjSzyatHRI3+X74=;
        b=Drv9YWFBRdf1Xu7smE5tctNeD93e4e9xfCMHt3ka83WJzf0S/GVlpepehrCMd2LGbAKMFA
        56WeiLEPppDwjccvMzmAsxM3h7bhXTff4TAC7U6hG9h503Uo0+fXOr+34/QPVGvI8+6urV
        sD90lCYY63P4COobgLCZbGvB/eiAGvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-nuK4DTijNgivn1Ubfr2ZZg-1; Wed, 06 May 2020 09:15:32 -0400
X-MC-Unique: nuK4DTijNgivn1Ubfr2ZZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57222460;
        Wed,  6 May 2020 13:15:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 90A6D5C1D4;
        Wed,  6 May 2020 13:15:30 +0000 (UTC)
Date:   Wed, 6 May 2020 15:15:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: add dax (direct access) capability column
Message-ID: <20200506131527.kduvb442qatqjhjq@ws.net.home>
References: <20200505143145.9852-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505143145.9852-1-ailiop@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 05, 2020 at 04:31:44PM +0200, Anthony Iliopoulos wrote:
>  misc-utils/lsblk.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


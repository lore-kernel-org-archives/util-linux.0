Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AEAC433F5
	for <util-linux@archiver.kernel.org>; Mon, 14 Mar 2022 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiCNJqa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiCNJq3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2022 05:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A51F3FBC8
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647251109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ip00u+fORZhSCrh1yfzQUB9LGmBQEXFkiKfoFWcqLWA=;
        b=BDRmyDb0hioHAtRwDFHcAIDpl00XM9ZH9eZEYJUCGrvz7/ROoZN0Utlyluhtp5S0oRtwMM
        zkmvpoZY3COao+43SupWokNPumHd/Ft7bToNBUzkTFisqUibsNyA9i7QobpLktSl0TAXFL
        ZxEw3wFVBUT7MoYshsxwLRH9maH5Lbw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-jej5AD3bNOSAIMTO0bV4Ng-1; Mon, 14 Mar 2022 05:45:06 -0400
X-MC-Unique: jej5AD3bNOSAIMTO0bV4Ng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E5FE3C021AB;
        Mon, 14 Mar 2022 09:45:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E098566E42F;
        Mon, 14 Mar 2022 09:45:04 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:45:02 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Subject: Re: [PATCH] hardlink: add a missing word to an error message
Message-ID: <20220314094502.mrv5bubep624wtj4@ws.net.home>
References: <20220313114556.6218-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313114556.6218-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Mar 13, 2022 at 12:45:56PM +0100, Benno Schulenberg wrote:
>  misc-utils/hardlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


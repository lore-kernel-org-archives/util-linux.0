Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECF3ECAAD1
	for <util-linux@archiver.kernel.org>; Thu,  1 Sep 2022 09:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiIAJbo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiIAJbn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Sep 2022 05:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE2DDA86
        for <util-linux@vger.kernel.org>; Thu,  1 Sep 2022 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662024701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=18R3E/d5KpydD++sx2WDJsOUcqBDcJZKJISEGX3NO4w=;
        b=AvgOBXNAFA4a+f4BTRVbG0rYVdiB6NWGpw8WuYtVGwQaLLl6WLMsCGPrRLcEg5M6pXoURg
        CgRTzwvwH7gx+j0z3gcHiNXnf1EvlUSCiNRxby7XQuqbNsmngSUGBMkitsqGEvzWMtT5Um
        0Vqkf1rZc50MxHLzDNEg60BkN+f/gmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-zSiIeQNNPAOiVDQota-BGA-1; Thu, 01 Sep 2022 05:31:38 -0400
X-MC-Unique: zSiIeQNNPAOiVDQota-BGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEB4D101A54E;
        Thu,  1 Sep 2022 09:31:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61B28C15BB3;
        Thu,  1 Sep 2022 09:31:35 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:31:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] asciidoc: fix typo in hwclock.8
Message-ID: <20220901093132.agw6unes74awqhy7@ws.net.home>
References: <20220831084743.10620-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831084743.10620-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Aug 31, 2022 at 04:47:43PM +0800, Enze Li wrote:
>  sys-utils/hwclock.8.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


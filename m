Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F064C28D13
	for <util-linux@archiver.kernel.org>; Mon, 22 Aug 2022 10:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiHVK25 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 22 Aug 2022 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiHVK2z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 22 Aug 2022 06:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E129C9C
        for <util-linux@vger.kernel.org>; Mon, 22 Aug 2022 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661164132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NZ/1epahWE6TRLUVD79JiCiFrPBW5syZMDMwstAcT6Y=;
        b=bDOYZmtk60aUEtyU85TAw+Sui5e6yqvvMfVddWx40IrRa87jkxRXVokSVCvnORM0EnlpN4
        dZhpk45TBdJPQdFxcEMR2dp6+eK81zzrkXts9DWjYpO2E8NLLFuHymfXfF5LnHS0tKD4ij
        3yMMChhTcp69Jpt8k01wphFf3TJLnn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-vELeZhfcOVKEy0be9fUH1g-1; Mon, 22 Aug 2022 06:28:51 -0400
X-MC-Unique: vELeZhfcOVKEy0be9fUH1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 107BC811E7A;
        Mon, 22 Aug 2022 10:28:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A9ED4010D2A;
        Mon, 22 Aug 2022 10:28:50 +0000 (UTC)
Date:   Mon, 22 Aug 2022 12:28:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid - check clock value from LIBUUID_CLOCK_FILE
Message-ID: <20220822102848.pmvxozilygtsn2lv@ws.net.home>
References: <20220802121643.29565-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802121643.29565-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 02, 2022 at 02:16:43PM +0200, Michael Trapp wrote:
>  libuuid/src/gen_uuid.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks. (And sorry for the delay :-)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


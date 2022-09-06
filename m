Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9961C38145
	for <util-linux@archiver.kernel.org>; Tue,  6 Sep 2022 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbiIFIuV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbiIFItb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Sep 2022 04:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4916BB7
        for <util-linux@vger.kernel.org>; Tue,  6 Sep 2022 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662454043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qe1PKZz1BQJ8rKUq35gs8zYCB05t3GyypBuRWdy5New=;
        b=cH1afM5UGJELn7WvigwIt9kfmHaxq8tTJ5Mw751vbSMksa1b/pxKXHAZ4zwFFvnDaGxrpY
        m9lfYwPlWD6XovTXgf36IrFTtyHTt+iCszFcgp9wM2PypWIJCkVHWhqIiFHKCiXOh5Hse4
        7/Sd49jJnrpPUx8Kr5iztNbt5rKetPU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-znFIjm5FP_GMqJ_62wdrkg-1; Tue, 06 Sep 2022 04:47:19 -0400
X-MC-Unique: znFIjm5FP_GMqJ_62wdrkg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E396299E745;
        Tue,  6 Sep 2022 08:47:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 12DDC2026D64;
        Tue,  6 Sep 2022 08:47:18 +0000 (UTC)
Date:   Tue, 6 Sep 2022 10:47:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to
 parse_timestamp()
Message-ID: <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
References: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 06, 2022 at 10:04:36AM +0300, Peter Ujfalusi wrote:
>  lib/timeutils.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


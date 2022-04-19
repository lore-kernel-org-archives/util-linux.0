Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2596AC433FE
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 09:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiDSJwu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 05:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiDSJwt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 05:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F4BF13E34
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650361805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mOA2M04T3mQSSPgFT9AuwERzjNwUEqg/gqAIhCJJn0=;
        b=YFZuDy8qkzsX/lB8GAAWDezuHMA5TGLM/mupXubKeh8HY2JrOSH+4o9YlV4BojWSfq2fYE
        EL8pmgi3tWj4W1xIR6V4I04cR8YaL95IT7N4nr+uWgJfwL8ou8M7fKAkEd86uNGUlFp322
        8UsQguymuvA/51ami/aVPNTOI3Ka800=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-L1uFpWF7O3-5e0-uZ7odSw-1; Tue, 19 Apr 2022 05:50:03 -0400
X-MC-Unique: L1uFpWF7O3-5e0-uZ7odSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24BEC18E5381;
        Tue, 19 Apr 2022 09:50:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 969E8215CDD5;
        Tue, 19 Apr 2022 09:50:01 +0000 (UTC)
Date:   Tue, 19 Apr 2022 11:49:59 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: test_buffer, return EXIT_SUCCESS at the end
Message-ID: <20220419094959.6fmlp4o2nwxotuyg@ws.net.home>
References: <20220414073952.285415-1-matorola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414073952.285415-1-matorola@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 14, 2022 at 10:39:54AM +0300, Anatoly Pugachev wrote:
>  lib/buffer.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


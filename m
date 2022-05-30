Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14834C433EF
	for <util-linux@archiver.kernel.org>; Mon, 30 May 2022 10:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiE3KVj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 May 2022 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiE3KVe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 May 2022 06:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3E742B1
        for <util-linux@vger.kernel.org>; Mon, 30 May 2022 03:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653906091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1t9p9/ZK5fqGcfvJbd5ZoPsNvF42TT4qwuDCjRYREU=;
        b=gFxsSllMu0JnU/squu17WPkXLw4eA3pWRzWbg1spTrX+Key3zEsPGegFomxuRH/U8SdMMD
        cUnbAkWZ5ePuDnbPNtXuhV4cDs1RSpm7FN8Don/yWXoAXZ9nEfY86QtNBV/dJcKkfbKqKT
        nJ780E+QEjJbjQ31RyxMKeSPv/Wx5lY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-1psdkVtrOC-DVMARYmzEuA-1; Mon, 30 May 2022 06:21:29 -0400
X-MC-Unique: 1psdkVtrOC-DVMARYmzEuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFE08801228;
        Mon, 30 May 2022 10:21:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4349F40F06B;
        Mon, 30 May 2022 10:21:21 +0000 (UTC)
Date:   Mon, 30 May 2022 12:21:18 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] pipesz: correct manpage issues
Message-ID: <20220530102118.6kce2qbgu2wqvqxx@ws.net.home>
References: <SN6PR04MB398339AA1E5BC7F8863D66DAC2D89@SN6PR04MB3983.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB398339AA1E5BC7F8863D66DAC2D89@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 26, 2022 at 08:59:44PM -0600, Nathan Sharp wrote:
>  misc-utils/pipesz.1.adoc | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


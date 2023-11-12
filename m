Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E6C4332F
	for <util-linux@archiver.kernel.org>; Sun, 12 Nov 2023 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjKLRzn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 12 Nov 2023 12:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjKLRzm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Nov 2023 12:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B6A2715
        for <util-linux@vger.kernel.org>; Sun, 12 Nov 2023 09:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699811693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FiWkHZ/IpAI0NMzXWtYJt159Fqd9TRZeTGPwb5vbNRU=;
        b=GyZbB+FWbuDRyzJLmPfcfrtX+TBsaBNq1ow+ORizHOcn8RwbG7gjbESnIDU7xOjdTzee9/
        HBWFs+bvPgu9wVTLAG0u1/ZVGniAgydF2cNH4U4lh/HfwYTQ3OdIgZV9M6T+B/fgcacmxL
        ivPeaz560toz4E0/JScUcO8onYvb0gI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-Ef1sH-SuNJCT7BCZjpfknA-1; Sun,
 12 Nov 2023 12:54:49 -0500
X-MC-Unique: Ef1sH-SuNJCT7BCZjpfknA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A303C0F424;
        Sun, 12 Nov 2023 17:54:49 +0000 (UTC)
Received: from localhost (unknown [10.64.240.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA5352166B26;
        Sun, 12 Nov 2023 17:54:48 +0000 (UTC)
Date:   Mon, 13 Nov 2023 02:54:47 +0900 (JST)
Message-Id: <20231113.025447.1424703398754597049.yamato@redhat.com>
To:     glaubitz@physik.fu-berlin.de
Cc:     util-linux@vger.kernel.org
Subject: Re: RFH: fincore/count lsfd/column-xmode failing on sparc64
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de>
References: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Thank you for reporint the issue about lsfd.

    diff-{{{
    --- /home/glaubitz/util-linux/tests/expected/lsfd/column-xmode-MODE-x-bit       2023-11-11 18:12:22.478579711 +0000
    +++ /home/glaubitz/util-linux/tests/output/lsfd/column-xmode-MODE-x-bit 2023-11-11 18:19:47.434570270 +0000
    @@ -1,2 +1,3 @@
     r-x
    +rwx
     MODE(x-bit):  0
    }}}-diff

Could you show the outout of "pmap $$" on the target platform?

On my PC (Fedora 38 running on x86_64):

    929547:   zsh
    000055e86f2d7000     92K r---- zsh
    000055e86f2ee000    716K r-x-- zsh
    000055e86f3a1000     88K r---- zsh
    ...

The failed test case is highly depends on "r-x--" iin
the line "000055e86f2ee000    716K r-x-- zsh".

I guess, on your environment, the field is "rwx--".

If, my guessing is correct, I must fix the test case.

Masatake YAMATO


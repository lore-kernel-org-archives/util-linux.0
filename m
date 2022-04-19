Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA023C433EF
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 10:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiDSKjo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiDSKjo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 06:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50CFD2B19F
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650364620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4f2JrbCL3autdpnIKqjOowZZGt4ftPfUzXYGe1JdxE=;
        b=Lu9U5Dee1/Xa8F2KuzVQ6O3ffKM8fimR7wBuntUcPV0BEro/RzvJcqAdjDyNCEYr0NWeV4
        2btdx3f2D8YtA1YPvZkhSLLC9R4W20Xas5NJrepYU+EWGD8Mey1125kyA6sp2UVHl06SlB
        fy5/IO0diVuLY5MPmkIb/9tvDtWfTYg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-tRZZuTz3OHGYHulfHKIULA-1; Tue, 19 Apr 2022 06:36:59 -0400
X-MC-Unique: tRZZuTz3OHGYHulfHKIULA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFCD43C1392E;
        Tue, 19 Apr 2022 10:36:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 166AA1454535;
        Tue, 19 Apr 2022 10:36:57 +0000 (UTC)
Date:   Tue, 19 Apr 2022 12:36:55 +0200
From:   Karel Zak <kzak@redhat.com>
To:     1003095@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>,
        util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220419103655.gnqmga6363xqiglp@ws.net.home>
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
 <20220411100806.bfplpv36sdixd6uu@ws.net.home>
 <20220412142514.jkgnjc3452q5kmm4@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220412142514.jkgnjc3452q5kmm4@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 12, 2022 at 04:25:14PM +0200, наб wrote:
> Added pty->free_buffers where we put free-to-use (fully-written-out buffers)
> instead of free()ing them; my testing indicates, that for interactive use
> we allocate a single buffer and re-use 100% of the time.
 
Cool.

>  include/pty-session.h |   7 +++
>  lib/pty-session.c     | 126 ++++++++++++++++++++++++++++++++++--------
>  2 files changed, 110 insertions(+), 23 deletions(-)

Applied, thanks!

Please, next time use "Signed-off-by:" line :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25FEC7619A
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 10:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjDEKpL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjDEKpK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 06:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE514C02
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 03:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680691472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OLMwiozkJJiRUigI/D5uVBOngl8v068CsyT/wdv+Du4=;
        b=AJzctsFaCuR9VnblDbOtRyN4Hc8w4q8VByv6PTnT+dZOlTcS5EmoXcQD2Rf4hHvIz+7XnA
        LgiF/X3k5QMnpinhD0aH/v0sWfmtJC2qazat114Ado6f+BZqWhoW4IE98j3aiJnjQTFfGk
        P0Kv4PJpNPEUADJcT4COV89FsJGkJIQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-XceRLNQvPhCl_1OyWrbhSg-1; Wed, 05 Apr 2023 06:44:29 -0400
X-MC-Unique: XceRLNQvPhCl_1OyWrbhSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1381E2810C16;
        Wed,  5 Apr 2023 10:44:29 +0000 (UTC)
Received: from ws.net.home (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B8482027061;
        Wed,  5 Apr 2023 10:44:28 +0000 (UTC)
Date:   Wed, 5 Apr 2023 12:44:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] add blkpr in AUTHORS file
Message-ID: <20230405104426.ykyf5owfwqshrjmh@ws.net.home>
References: <20230405100801.10295-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405100801.10295-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 05, 2023 at 06:08:00PM +0800, zhenwei pi wrote:
> I noticed that you announced the v2.39-rcX, and I find the lack of
> blkpr entry in AUTHORS.

Applied, thanks!


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


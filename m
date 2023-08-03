Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC5C001DF
	for <util-linux@archiver.kernel.org>; Thu,  3 Aug 2023 10:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjHCKSk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHCKSJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Aug 2023 06:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE1421A
        for <util-linux@vger.kernel.org>; Thu,  3 Aug 2023 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691057805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOq1jTWVKjQJESV1kywqr9mMc4jmuKgnLeh1hkykauI=;
        b=IE1NNdSmNEtNS74Ss5Ygw1zrT7RhNoINiRrWQu8DGDUXRvja0dEXY/iy7b5h5h9PIOHW6A
        NYwKBzbpkD53xVe4w2P0wZ0QX820PCAo0PNXii6oyaBwKjTMUP8KMSTPBgigSjRodrSu3M
        tpBA38jwwnSLTmC6hEX6aGj/4HvboAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-Vr7dCUCaOx6Gx6Ms9skJWw-1; Thu, 03 Aug 2023 06:16:42 -0400
X-MC-Unique: Vr7dCUCaOx6Gx6Ms9skJWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33C7186801E;
        Thu,  3 Aug 2023 10:16:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B363E40C206F;
        Thu,  3 Aug 2023 10:16:41 +0000 (UTC)
Date:   Thu, 3 Aug 2023 12:16:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     util-linux mailing list <util-linux@vger.kernel.org>
Subject: Re: [PATCH] include: define pidfd syscalls if needed
Message-ID: <20230803101639.bbubldzajmgknttt@ws.net.home>
References: <20230801200824.49768-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801200824.49768-1-mmayer@broadcom.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 01, 2023 at 01:08:24PM -0700, Markus Mayer wrote:
>  include/pidfd-utils.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


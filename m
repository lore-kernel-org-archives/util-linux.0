Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EAC433F5
	for <util-linux@archiver.kernel.org>; Wed, 13 Apr 2022 08:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiDMIEm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiDMIEl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2022 04:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A79E205F1
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2022 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649836940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjyvklNtsTXraB9VvmjocvRs2V/OaYikzD5BIH8lZ2A=;
        b=JjQeZIN3iLV+EDYsRKlHxJM3sDJIgBAPoWz1XNuGOuKq6zbk/9Nw5fBZFB0RSbNNn5U2Qx
        u1YTnqvTwHbZOUr3FhuN1Hpc7gy+l2d8mD4rD2uEI/wjqdyc7Nj8Qqf0Pw9S1pbiBuvwr+
        7pE1LAlSSbwRlM/LI1UfJmpnY67qJH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-HUUmc4TFNfut2_pWaB97rQ-1; Wed, 13 Apr 2022 04:02:17 -0400
X-MC-Unique: HUUmc4TFNfut2_pWaB97rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28FB8185A7B2;
        Wed, 13 Apr 2022 08:02:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A247BC2812C;
        Wed, 13 Apr 2022 08:02:16 +0000 (UTC)
Date:   Wed, 13 Apr 2022 10:02:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] build-sys: add gnu global outputs to gitignore
Message-ID: <20220413080214.d6rvlzu3txmchwdf@ws.net.home>
References: <20220413075350.2190928-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413075350.2190928-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 13, 2022 at 03:53:50PM +0800, Enze Li wrote:
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798B6C433EF
	for <util-linux@archiver.kernel.org>; Tue, 19 Apr 2022 09:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348453AbiDSJzl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Apr 2022 05:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbiDSJzk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2022 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E945120F6B
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2022 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650361978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtFYrrLVMAs28KOhqqUnH/Hu6NjR9zntsAR1I1timUg=;
        b=innlRj48Hv90sQoYYQ2znBMOUHD69BcDLeQpf+iGSjwWqOfu8hsnLo4mLdgpGrbDwdyWAF
        f8QZi3FoSLKGfqNq2/byf5cN/N9Qhpx4YxNbilOyXEcqnJhnAA6kpwHg6HW74ZJtjjTFVy
        fs0avzFIchsaeIL37gOvxZxBt9MrL6s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-qkXXg5QJOu23LBTBWnP7Ww-1; Tue, 19 Apr 2022 05:52:54 -0400
X-MC-Unique: qkXXg5QJOu23LBTBWnP7Ww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B6EC29AB45B;
        Tue, 19 Apr 2022 09:52:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95804401DBE;
        Tue, 19 Apr 2022 09:52:53 +0000 (UTC)
Date:   Tue, 19 Apr 2022 11:52:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] build-sys: add blkpr to gitignore
Message-ID: <20220419095251.yut7o4otxhphr6tq@ws.net.home>
References: <20220415033125.3409425-1-lienze@kylinos.cn>
 <20220415055510.714627-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415055510.714627-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 15, 2022 at 01:55:10PM +0800, Enze Li wrote:
>  .gitignore | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Good catch. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


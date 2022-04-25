Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46315C433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 13:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiDYNqr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiDYNqj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 09:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C3024A3F3
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650894213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cLsXj2/mJNWQ5iqn1GDBOmEx0udfmEHAkLAXZ5id36Y=;
        b=Bs4p0UurNYxpyQj4A1YKIZ1UjN8jlaI7WKKL7IaqVr8INZ0nnF+TvKHy6gn1qXdxvNXiQ2
        yy4jr0e192F89V2ilJWVsFPot8fcT7GaaRzw4jMqGmAABmSC+hYVrh4Hn9+TwbWwe4xxbF
        NWt8kq5A+3naEuYGj35qTvF32+f3EuU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-LSfYeIxxPgGbrN3OmSEtMA-1; Mon, 25 Apr 2022 09:43:32 -0400
X-MC-Unique: LSfYeIxxPgGbrN3OmSEtMA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FA331C0512B
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 13:43:32 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 783D654CB02;
        Mon, 25 Apr 2022 13:43:31 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:43:29 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     util-linux@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Message-ID: <20220425134329.ub3thxkscsniy74e@ws.net.home>
References: <20220421130946.318737-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421130946.318737-1-aalbersh@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Thanks Andrey,

the code looks good.

On Thu, Apr 21, 2022 at 03:09:44PM +0200, Andrey Albershteyn wrote:
> I had a look into other fs, like ext4 and btrfs, to implement FSSIZE
> for them, but I think I don't have enough expertize to do that as
> they have not so trivial metadata overhead calculation :)

But it would be nice to have ext4 and btrfs too. Maybe Eric can help
you :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


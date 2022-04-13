Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015DCC433F5
	for <util-linux@archiver.kernel.org>; Wed, 13 Apr 2022 09:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiDMJZK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiDMJZH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 13 Apr 2022 05:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03FE553709
        for <util-linux@vger.kernel.org>; Wed, 13 Apr 2022 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649841763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/L84902IUfADEafAqonN9VlaGh1XRtEfI+6IlKb60sY=;
        b=Ow1ijh+oFbH+AY2UKsodZT62lXLBYyIyU8ay5t1aF+gDCEhcDMyi3a0mArG6v4e1Lfe4Ji
        5T0942RVoHztWOezXv2+t64ZJisu77SJbptTtkGgShtXQ8LnmPNqN/doMmto5iNTRCG+0u
        dBihidakjXtLuLd+hS6OHmXckWISUxE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-YUsnLK3VO-W6O_3KoLYsfg-1; Wed, 13 Apr 2022 05:22:39 -0400
X-MC-Unique: YUsnLK3VO-W6O_3KoLYsfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 743191C0690F;
        Wed, 13 Apr 2022 09:22:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE74A401E75;
        Wed, 13 Apr 2022 09:22:38 +0000 (UTC)
Date:   Wed, 13 Apr 2022 11:22:36 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] pipesz: a utility for examining and resizing
 pipe buffers
Message-ID: <20220413092236.fdqyzmp2cc3ctfdt@ws.net.home>
References: <SN6PR04MB39830A8FED1D11B472DAB968C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB39830A8FED1D11B472DAB968C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 11, 2022 at 10:59:26PM -0600, Nathan Sharp wrote:
> Thank you for taking time to read this cover letter, and thank you
> in advance for the additional time you might spend reviewing these
> patches.

At first glance it seems like something we can merge. Thanks for all
the work (docs, tests, etc.). I'll review and merge it later (probably
next week).

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


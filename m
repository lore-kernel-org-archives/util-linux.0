Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749BC61DA4
	for <util-linux@archiver.kernel.org>; Thu,  9 Mar 2023 12:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCIMUy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Mar 2023 07:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjCIMUe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Mar 2023 07:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57FEA031
        for <util-linux@vger.kernel.org>; Thu,  9 Mar 2023 04:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678364371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cgQUNVoPR+n5N+LhYiGoXY3U0IptwR67+gqv4mWteMk=;
        b=LqZzrgE88XtP3IYGu2nSNrLIf3alGLIBAGuYv/GN68hIDciYbHROwde2uYmuJQXUT2U0X1
        yf3cE2x5hbRPzhbzkqWjSm6icWENImmGpmtGyIZ2HketHz9+IPfsoGObvYDTSaBPzjfGc0
        bEsNoR4+8RO+WcBYhykh9OhTBeAeIsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-H4CrVnbEN-uS83KSseH81Q-1; Thu, 09 Mar 2023 07:19:28 -0500
X-MC-Unique: H4CrVnbEN-uS83KSseH81Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F20BE1871D97;
        Thu,  9 Mar 2023 12:19:27 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78230440DD;
        Thu,  9 Mar 2023 12:19:27 +0000 (UTC)
Date:   Thu, 9 Mar 2023 13:19:25 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: fix lib internal cache size
Message-ID: <20230309121925.5llrlfnjdel5pu6d@ws.net.home>
References: <20230306104020.46754-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306104020.46754-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 06, 2023 at 10:40:20AM +0000, Michael Trapp wrote:
>  libuuid/src/gen_uuid.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


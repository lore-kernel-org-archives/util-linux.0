Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B64C433F5
	for <util-linux@archiver.kernel.org>; Fri, 29 Apr 2022 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349313AbiD2LO2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 Apr 2022 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348440AbiD2LO1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 Apr 2022 07:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EF566E8E4
        for <util-linux@vger.kernel.org>; Fri, 29 Apr 2022 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651230668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeriiPmnLeDbaV6kMoVZ88nG6c9hp4DM2eALedFtI4Y=;
        b=K4I+oSMPAnvFj/wCSwyofx5xlZFBHuUeAY9sEMScymn/VjteycvjXhxgpgPD65l3RV7GXX
        o9RixccuMGAPbUkpD8hVQSAAeg9Hwq4zM9qvPm8yxjdnWHxPbO5jrtooDu1hS7VhwoInI2
        zWhBn7KkJ6/nbjopMMco1wZBFZGJRd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-Uu-mT3CeMkal1ZT-SsCNAw-1; Fri, 29 Apr 2022 07:11:05 -0400
X-MC-Unique: Uu-mT3CeMkal1ZT-SsCNAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B80B7811E76;
        Fri, 29 Apr 2022 11:11:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C24414A4F80;
        Fri, 29 Apr 2022 11:11:04 +0000 (UTC)
Date:   Fri, 29 Apr 2022 13:11:02 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: improve cache handling
Message-ID: <20220429111102.os67d7aawscgw3xa@ws.net.home>
References: <20220422080746.29896-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422080746.29896-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 22, 2022 at 10:07:46AM +0200, Michael Trapp wrote:
>  libuuid/src/gen_uuid.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

 This is simple and elegant optimization :) Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


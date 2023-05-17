Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6622CC77B7F
	for <util-linux@archiver.kernel.org>; Wed, 17 May 2023 11:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEQL5F (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 17 May 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjEQL5E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 17 May 2023 07:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE2421D
        for <util-linux@vger.kernel.org>; Wed, 17 May 2023 04:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684324581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1WRQNeesO/U7hoVmkb8gG6Ae6UogTYPgFmkWWM21wg0=;
        b=BY38ye+Iazwk6KMxftAMiXKUwN503DiqV2k+KbBSNYzSdI01R7mgwSG599SRzn+eeGCEM+
        xyE9xy/qnX8K3QUYOnzYJlv7pydV+0MXVDtoBAiptSVS+L+eB9TVKkjzao1XgeEthgCsZL
        iwdpatWc/vo5sSyOlwx1dzXVQ7THB0o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-tqkRPL7DPOiN-RPTc3ZygQ-1; Wed, 17 May 2023 07:56:18 -0400
X-MC-Unique: tqkRPL7DPOiN-RPTc3ZygQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2A3E1C0F2E0;
        Wed, 17 May 2023 11:56:17 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CA0A492C3F;
        Wed, 17 May 2023 11:56:17 +0000 (UTC)
Date:   Wed, 17 May 2023 13:56:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] mesg.1 cleanups/updates
Message-ID: <20230517115614.ei7jqczu6ugwyvuv@ws.net.home>
References: <iv3bmcufpzlrrasfctami46xmazuhlq3z4hvd7537bomu6fa5q@k7tx2qgxwrrg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iv3bmcufpzlrrasfctami46xmazuhlq3z4hvd7537bomu6fa5q@k7tx2qgxwrrg>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> diff -u -r util-linux-2.39-rc3.orig/term-utils/mesg.1.adoc util-linux-2.39-rc3/term-utils/mesg.1.adoc
> --- util-linux-2.39-rc3.orig/term-utils/mesg.1.adoc	2023-05-15 00:57:54.747355121 +0200
> +++ util-linux-2.39-rc3/term-utils/mesg.1.adoc	2023-05-15 01:15:55.971205532 +0200

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25858C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0301420746
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d0vq2swQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEFNRa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:17:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48463 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728058AbgEFNRa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588771049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=If1E7SxBXZxmWU7k8YgfDWOvkoX4JMX5RFIzJiUFgTA=;
        b=d0vq2swQQY0lVuoZA9T/ZuDD5Q9RPUXwLNRY6hPCq9CEq9x5EmxUELpBhOAB++FNjgOfhn
        sMlugViOfQlikSZc6nr+9yC6U4pQzDuK6fZtdrsb4BIHvC7GeYNjYo5ru/yrSAgD4i0SBz
        RfK7H0oUS6T7pHpLG6QEqL1ca15pXSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-G_Sq5wuxM5GDj4CQ5bpkMw-1; Wed, 06 May 2020 09:17:28 -0400
X-MC-Unique: G_Sq5wuxM5GDj4CQ5bpkMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E6519057A0;
        Wed,  6 May 2020 13:17:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4944F26552;
        Wed,  6 May 2020 13:17:26 +0000 (UTC)
Date:   Wed, 6 May 2020 15:17:23 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: better wording for '-B' in the man page
Message-ID: <20200506131723.f2xrmkuubikqjcwc@ws.net.home>
References: <20200506103804.2638-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506103804.2638-1-wsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 12:38:04PM +0200, Wolfram Sang wrote:
>  disk-utils/fdisk.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


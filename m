Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5D1C433FE
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E338161159
	for <util-linux@archiver.kernel.org>; Tue, 21 Sep 2021 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhIUIzp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 Sep 2021 04:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231260AbhIUIzp (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Sep 2021 04:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632214456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agWWtW7dG4UyWDbA34Wq2oViHaZe2Mp2AF2BFNQtGxw=;
        b=MTEL+Az4/Xu9GfeMdoMRyo9V9zUSkMVSLn48kQKyBFQlKhbxEVUBYYMjEBBrMRTeqcIZZq
        neIj8BQZ6pIO6PXkTdBiYg/MNzWeohqjGUiBtLnsoioHOB5T3PqEStt9HNZCXkB6fW9noM
        pd5NgoVMKF/y/8JG0FJqrZXrgNjyLto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-lIDf2SvhNtOAplippFuA3Q-1; Tue, 21 Sep 2021 04:51:03 -0400
X-MC-Unique: lIDf2SvhNtOAplippFuA3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6697584A5E0;
        Tue, 21 Sep 2021 08:51:02 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B91921346F;
        Tue, 21 Sep 2021 08:51:01 +0000 (UTC)
Date:   Tue, 21 Sep 2021 10:50:59 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: PATCH: misformatting in mount.8.adoc
Message-ID: <20210921085059.7jqz4htg3gqyvj2c@ws.net.home>
References: <CAHi0vA_sSHZ8MV8PExEUkOuE1EhGWZ5RL_1-tLpwrbsqqMgVgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA_sSHZ8MV8PExEUkOuE1EhGWZ5RL_1-tLpwrbsqqMgVgw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Sep 09, 2021 at 08:06:44PM +0200, Mario Blättermann wrote:
> while translating the latest changes in man pages, I found some issues
> in mount.8.adoc. See the attached diff.

Applied, thanks.

> Unfortunately we can't use non-standard citation characters in the
> Asciidoc files, like “these”.

I guess "standard" citation characters are good enough for us ;-)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


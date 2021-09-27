Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF52C433F5
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 11:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE3960F6D
	for <util-linux@archiver.kernel.org>; Mon, 27 Sep 2021 11:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhI0LyB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234015AbhI0LyA (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Sep 2021 07:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632743542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgE4nqMIEyiIv0Oeon4T8vo65U/IjQFLnp89XZq2sVs=;
        b=O5qEBGbPR3EqGXic37yjo4LRefdMCrnJtxMeoT52pgWUjwD8Xf8gkV+RGlPXNwXW1YhVZ9
        fyjxC6KlWUHtkCJxCQ1ELDt5PZ/fTEVvtXAG+o0bzMLzRB6PpnWYNzs2int6T+A2+sDKVJ
        dXYEJ4e5/69JDLh/supb/3i71oNJ8HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-kxlTM1mkPEySOC1TsoIveQ-1; Mon, 27 Sep 2021 07:52:21 -0400
X-MC-Unique: kxlTM1mkPEySOC1TsoIveQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44129100CCC5;
        Mon, 27 Sep 2021 11:52:20 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7323B1816A;
        Mon, 27 Sep 2021 11:52:19 +0000 (UTC)
Date:   Mon, 27 Sep 2021 13:52:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Eduard Bloch <blade@debian.org>
Subject: Re: [PATCH] Use more passive wording in hardlink.1
Message-ID: <20210927115216.hi3w233gif4wbgyr@ws.net.home>
References: <20210927070812.77020-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927070812.77020-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Sep 27, 2021 at 09:08:12AM +0200, Chris Hofstaedtler wrote:
>  misc-utils/hardlink.1.adoc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


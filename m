Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0A6C433EF
	for <util-linux@archiver.kernel.org>; Wed,  6 Apr 2022 12:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiDFMnz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiDFMmB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 08:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1F3488BE4
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649234607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xC0tV+w9+aLyhV/j1UGXZGjDfp6hVifTfBDn9PV+lms=;
        b=in0XkVoN6jNMkWv1NSjryEeIHWBw/Ppcob665Oec4gdS7iSf+qDGsOznB7agRIkwz9Y+x7
        K2X/DYf3FlGtivMjClPq5akuxNVIiSQcwy20vXbQfOU7pDsDeJ+w9YWHiYW/Qy4JBrRzsx
        zGEOG9Jrcxf+TM6dX50oTviCw1aYJcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-GeUo9gdjM5uxIfvRFkxxpQ-1; Wed, 06 Apr 2022 04:43:14 -0400
X-MC-Unique: GeUo9gdjM5uxIfvRFkxxpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6906883396F;
        Wed,  6 Apr 2022 08:43:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E33A340BAEE;
        Wed,  6 Apr 2022 08:43:13 +0000 (UTC)
Date:   Wed, 6 Apr 2022 10:43:10 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] configure.ac: add lsns option
Message-ID: <20220406084310.dw3exobhzgzboaqx@ws.net.home>
References: <20220405180459.944658-1-fontaine.fabrice@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405180459.944658-1-fontaine.fabrice@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 05, 2022 at 08:04:59PM +0200, Fabrice Fontaine wrote:
>  configure.ac | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

It's good idea to add --disable-lsns, but for your use-case it's
workaround. The proper solution is to compile lsns, but without
NS_GET_ ioctls. Fixed by:

    https://github.com/util-linux/util-linux/commit/fc686823b008bc95e2ebe904c706a117a03e2754

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


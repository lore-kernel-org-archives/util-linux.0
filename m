Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4D5C433EF
	for <util-linux@archiver.kernel.org>; Tue, 14 Jun 2022 13:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiFNN6q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFNN6R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jun 2022 09:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E51931DD4
        for <util-linux@vger.kernel.org>; Tue, 14 Jun 2022 06:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655215095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAz6IccBTzwfHG28h//CLsNXVBNXBob8EpOp2iDXQGc=;
        b=Mpe8ZtEU+5Ug9jZWCShTEi15KDzzJCqVKXoW2hbSf7OcMRamJ2P1d9oCgzS87mMbvH+1E7
        Q5Mbv7qfwl2Br78gHb578N2dc2SPo81p/qCJFEM9k/Cw6VLL5qhVtcTm+PZH8ugMgtBhFN
        s6eE7z0Wb0U2U5GU8X5e8GLee4qZRHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-WXCD64TJN6WzX9p0ovSzEg-1; Tue, 14 Jun 2022 09:58:12 -0400
X-MC-Unique: WXCD64TJN6WzX9p0ovSzEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D576D85A582;
        Tue, 14 Jun 2022 13:58:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5673C2026D64;
        Tue, 14 Jun 2022 13:58:11 +0000 (UTC)
Date:   Tue, 14 Jun 2022 15:58:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: bashcompletiondir should not be set or tested when
 --disable-bash-completion is given
Message-ID: <20220614135808.uetmqwqhdoikmnw6@ws.net.home>
References: <2832693.e9J7NaK4W3@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2832693.e9J7NaK4W3@mobilepool36.emlix.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 14, 2022 at 10:52:02AM +0200, Rolf Eike Beer wrote:
> I tried building some util-linux libraries in a minimal chroot (no pkg-config). 
> At the end it boils down to
> 
> ./configure --disable-bash-completion <other stuff>
> 
> The result of this was:
> 
> checking for ECONF... no
> ./configure: line 37542: --exists: command not found

Fixed. Thanks for your report!
https://github.com/util-linux/util-linux/commit/f6d3f34a8593adee7ba3dfa933fb5fb2c9ea7ff3

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


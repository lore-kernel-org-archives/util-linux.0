Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A60C64ED6
	for <util-linux@archiver.kernel.org>; Mon, 27 Feb 2023 10:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB0Kv0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Feb 2023 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB0KvZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Feb 2023 05:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE5D337
        for <util-linux@vger.kernel.org>; Mon, 27 Feb 2023 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677495042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSvJszlPLOaDneOStmom8111jzgl3Z+4SoW9AfYJ1Ns=;
        b=aXHUhFfcRtuMCF9udLJp6CtrVlSyLzju/k9t5h15U9tQB7oLofuHNhE1r7LDT6iEl9XN2q
        /bePl7jRcyxIGp91Ewzphev0xX1Sk9d+EuXN9mncGDFH3jkeQE7OG3GSTjibCW1yyuZz2o
        yog2paPQaIC/w717mT6KWOe2uC9bgb0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-TX8lY8VyNA2-v3wFnEisjA-1; Mon, 27 Feb 2023 05:50:41 -0500
X-MC-Unique: TX8lY8VyNA2-v3wFnEisjA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDC733815F68;
        Mon, 27 Feb 2023 10:50:40 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC89492B0E;
        Mon, 27 Feb 2023 10:50:40 +0000 (UTC)
Date:   Mon, 27 Feb 2023 11:50:38 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?U8O2cmVu?= Tempel <soeren@soeren-tempel.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: Fix access to uninitialised value in
 mnt_optstr_locate_option
Message-ID: <20230227105038.l2pw3nn6x62tridi@ws.net.home>
References: <20230225114352.9151-1-soeren@soeren-tempel.net>
 <20230225124131.10401-1-soeren@soeren-tempel.net>
 <3E04KR1SLWLFQ.25IAX13LC3PWS@8pit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E04KR1SLWLFQ.25IAX13LC3PWS@8pit.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Feb 25, 2023 at 02:40:52PM +0100, Sören Tempel wrote:
> This solution also has the issue that it handles the case incorrectly
> where xstrncpy actually calls strlen(3). I wanted to avoid that but
> maybe the best solution is to just change the xstrncpy API in a way that
> it indicates whether it has written anything through an int return
> value?

The best will be to avoid all the buffer, xstrndup(), and         
mnt_optstr_get_option() using if the options string or the pattern is   
empty.  It's unnecessary because we know that mnt_optstr_get_option()
will return nothing.

I have committed
https://github.com/util-linux/util-linux/commit/06ee5267516761721ebfbdfa313980cef8e54c66

> Sorry for all the noise. Next time, I will just write a bug report...

That's no problem. We should be friendly to people who invest time to
report bugs and write code ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275ABC433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 08:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343619AbiDKIR2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbiDKIRX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 04:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34E7733A10
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 01:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649664909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WeY4ytT2bjEuoHgCp5rXZ28PvaWQtDTWNtpijM/5Eus=;
        b=JbtL3o5KJDh/IPhZC9yk5IJo0SbsHc8WLF15TW1gey0ypw3fCZCPQcDeYra/J2Qtp44a6W
        EdTWxsJ4Hov3MdeuJdYvaFHvVTmN5YA1d3enPB3XdRuOwavS90b5ejRdMeAeFCx/knXNB/
        J/xgiNizjVwPh6orTDjXPRKA0dvFtpo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-wOrCWDAcM-y-yreBfp0C5A-1; Mon, 11 Apr 2022 04:15:07 -0400
X-MC-Unique: wOrCWDAcM-y-yreBfp0C5A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64A6A3C16185;
        Mon, 11 Apr 2022 08:15:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE635416386;
        Mon, 11 Apr 2022 08:15:06 +0000 (UTC)
Date:   Mon, 11 Apr 2022 10:15:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Jose M. Guisado" <jguisado@soleta.eu>
Cc:     util-linux@vger.kernel.org
Subject: Re: libfdisk python bindings
Message-ID: <20220411081504.izsddsnb4m3uguf5@ws.net.home>
References: <f0103dd3-870c-5ece-7490-12d927cdaefd@soleta.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0103dd3-870c-5ece-7490-12d927cdaefd@soleta.eu>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 06, 2022 at 04:24:34PM +0200, Jose M. Guisado wrote:
> Hi, recently I've started working on python bindings for libfdisk. Just
> a C extension for CPython, like the libmount python bindings.
> 
> Early WIP can be found at https://github.com/pvxe/python-libfdisk/
> 
> After reading the mailing list archive and previous github issues
> related to python bindings, I'm wondering if patches would be accepted,
> or python bindings are preferred separate from the util-linux tree.

Frankly, I'm not sure if adding bindings to the project is good.                                     

We already have libmount there, and it is terrible. It is not up to
date with the original libmount library, it requires some additional
stuff in the build system, extra dependencies, etc., and I have no
time to fix it. (So, my long-term plan is to mark it as obsolete and
remove it from the project.)                                                           

That's the reason why libsmartcols python binding has been maintained
out of the tree, and it would be probably better also for libfdisk.

If you plan to maintain the python binding, we can help you propagate
your project (in util-linux Release Notes, docs, ...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


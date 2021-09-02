Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F8CC432BE
	for <util-linux@archiver.kernel.org>; Thu,  2 Sep 2021 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7489361059
	for <util-linux@archiver.kernel.org>; Thu,  2 Sep 2021 10:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbhIBK4J (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52684 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233761AbhIBK4I (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 2 Sep 2021 06:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630580109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxyQcy83I/jXZ0z7vqMPVv7q0hHa6IKHp1K/O7w9Xyc=;
        b=PhwBgo9B9hv10vK5PhUBL5W3CT/zbvvjjoXTc6hV2kqQKOxEtT4OtA7WEfzOonoSRaLbgI
        tRFn1YZo8RkTCzmYuWAxgiNcdZw4/fdjHQaSv9Y/kkX0uVc7BT9o3sih8re8QeTdTxnaVw
        4lWLOpBy1M7W0LI8VCUzxt+TfBfHq1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-fCeg_yAHOjGr8CXwGL44dA-1; Thu, 02 Sep 2021 06:55:08 -0400
X-MC-Unique: fCeg_yAHOjGr8CXwGL44dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 206FB801AFC;
        Thu,  2 Sep 2021 10:55:07 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7438669CAD;
        Thu,  2 Sep 2021 10:55:06 +0000 (UTC)
Date:   Thu, 2 Sep 2021 12:55:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rafael Fontenelle <rafaelff@gnome.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: Update translations in Translation Project
Message-ID: <20210902105503.qk6ecxca7t43o4nb@ws.net.home>
References: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 01, 2021 at 01:32:04PM -0300, Rafael Fontenelle wrote:
> Translation Project has util-linux-man domain POT in version 2.37-rc2,
> and it seems that a few strings are different from released 2.37.
> Please consider updating the POT version on the Translation Project to
> avoid losing translation effort.

We usually update TP before a release, and I think it's only time when
it makes sense, because the upstream release is the way how translations are
distributed to downstream/users.
                    
The goal is to keep strings after -rc2 frozen, but sometimes we need
to fix bugs in code ...


We can update TP before maintenance releases too (e.g., v2.37.2) and       
wait for translations, but these changes will be lost after the next  
upgrade (e.g., v2.38) as upstream work continues in parallel. IMHO
this is really bad idea.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


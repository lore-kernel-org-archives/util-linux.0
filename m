Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79855C7618E
	for <util-linux@archiver.kernel.org>; Wed, 26 Apr 2023 10:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbjDZK3B (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 26 Apr 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDZK3A (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 26 Apr 2023 06:29:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB57D49D5
        for <util-linux@vger.kernel.org>; Wed, 26 Apr 2023 03:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682504892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d8RQayCuuGKaRRXZsgKQ5kPVnQ6jLpCSz8VMq0Ncjlc=;
        b=e3V/0M7yz/PiwJ5rVZ8YU1E8U60q++8Kfk9bQvtMVYb1buZHEerwQgAH5I2AIOrIZMoB53
        EFyxxjd3zPQc9Ka3E7Z5+e0FLVHbp4eIPvNojep8NNe/s9reEMvpiRSvkAtdR7x1PaFK+q
        /XpYD64UU3Wem3BnYlXzS0Ban/nbNoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-bAxVMGpYM6KG6oOf1Mnorw-1; Wed, 26 Apr 2023 06:28:09 -0400
X-MC-Unique: bAxVMGpYM6KG6oOf1Mnorw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BC1B86F126;
        Wed, 26 Apr 2023 10:28:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6DAA492C13;
        Wed, 26 Apr 2023 10:28:08 +0000 (UTC)
Date:   Wed, 26 Apr 2023 12:28:06 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux v2.39 with translated man pages by default?
Message-ID: <20230426102806.7w33zaheh3feuohg@ws.net.home>
References: <CAHi0vA9nvmh7qiWX2oWbOcanCesk2M9dS0Goef6772emz=uy4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA9nvmh7qiWX2oWbOcanCesk2M9dS0Goef6772emz=uy4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 19, 2023 at 08:24:47PM +0200, Mario Blättermann wrote:
> Hello,
> 
> when I run ./configure (without any option) on the current Git content, I get:
> 
>         Manual pages:              yes
>         Manual pages translated:   no
> 
> This means, creating and installing the translated man pages is still
> not enabled by default. What may we expect for v2.39? If this remains

Good point. I have enabled it:
 https://github.com/util-linux/util-linux/commit/9acfc349e0ea68a92baf818cc659121f40ab9c04

but as in other cases, the default is "check", and the result depends on  
if you have "po4a" installed, and if not installed, you will see a
warning  

    configure: WARNING: po4a not found; not building translated man pages

but ./configure will success.

> disabled, no downstream packager will notice it, and the effort of the
> translators (6 languages, more than 500 translated *.adoc files) was
> for the trashscan.

I need to think about how to push it to Fedora/RHEL; I'll probably
create a sub-package with the translations, one for all or per
language. Is there any good practice for man pages?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


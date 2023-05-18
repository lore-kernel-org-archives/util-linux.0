Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7BC77B7D
	for <util-linux@archiver.kernel.org>; Thu, 18 May 2023 09:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjERJ4A (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 May 2023 05:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERJz6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2023 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F98172A
        for <util-linux@vger.kernel.org>; Thu, 18 May 2023 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684403708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+OTA4dNFQWriqcdymd7YL4DDQZxpxJ9odznZFkdlDk=;
        b=EQ1Zdgq2Y6dL5i1WUUKiujNfJb7wQtrDiP03K7hiXAiMG++hG+o3kkCv4e8YPrQren7Q1L
        k32AfEHV24fCKIgIjVepM/kkoHURJ2dR/OqWLc2N/XnuiBPq0UmppWoWTCJNiFwcnnIB8l
        7klEAvaQbl2iNfCMNBZ4AlSivAU5ujY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-GH6Av3mJPdWGFqjUIimNTQ-1; Thu, 18 May 2023 05:55:07 -0400
X-MC-Unique: GH6Av3mJPdWGFqjUIimNTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 258291C05158;
        Thu, 18 May 2023 09:55:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2CCD14171C0;
        Thu, 18 May 2023 09:55:06 +0000 (UTC)
Date:   Thu, 18 May 2023 11:55:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux v2.39 with translated man pages by default?
Message-ID: <20230518095504.dywkmtgluwfjt4d6@ws.net.home>
References: <CAHi0vA9nvmh7qiWX2oWbOcanCesk2M9dS0Goef6772emz=uy4g@mail.gmail.com>
 <20230426102806.7w33zaheh3feuohg@ws.net.home>
 <CAHi0vA9PyvgD6ij3cR6fQyfZPeKAFB-YHy=XRkLZwE6OLYe5cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA9PyvgD6ij3cR6fQyfZPeKAFB-YHy=XRkLZwE6OLYe5cg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 26, 2023 at 09:10:38PM +0200, Mario Blättermann wrote:
> > I need to think about how to push it to Fedora/RHEL; I'll probably
> > create a sub-package with the translations, one for all or per
> > language. Is there any good practice for man pages?
> >
> 
> Please have a look at procps-ng. It ships *both* UI and man page
> translations in a subpackage named procps-ng-l10n. This would be an

Done. I like this approach as it also reduces the size of the main
util-linux package in Fedora/RHEL. This reduction is desirable for
installations in build roots, containers, and similar environments.
There is no need for internationalization (i18n) in these cases.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


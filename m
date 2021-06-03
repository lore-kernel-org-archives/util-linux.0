Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364F2C47082
	for <util-linux@archiver.kernel.org>; Thu,  3 Jun 2021 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3206139A
	for <util-linux@archiver.kernel.org>; Thu,  3 Jun 2021 10:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFCKVb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhFCKVb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Jun 2021 06:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622715586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7fsjQcy24FstMNwMzZN9yg6lh/uEjS4ZXW9UMPB+Ww=;
        b=OajSfqegSs8lB5P0Xzc4CgvwayJjIqzWcCPExH6t7ebIZfM00nxzvUMUNBWaTAP6yKRNsx
        ur6wRo1hgy4q/0xu+6ijXvzK92DaAS6ue+1OqDW47sVVjZqXIAOgP+K1EbQYeyEm4XNpEd
        KImxpt+86Je+Av1TXs6ukJAcNePgOto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-yK-ClJxUMESpr7lkrDk-rw-1; Thu, 03 Jun 2021 06:19:43 -0400
X-MC-Unique: yK-ClJxUMESpr7lkrDk-rw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF675801B15;
        Thu,  3 Jun 2021 10:19:42 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 249065D74B;
        Thu,  3 Jun 2021 10:19:41 +0000 (UTC)
Date:   Thu, 3 Jun 2021 12:19:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.37
Message-ID: <20210603101939.ltmyouadjizgw2mu@ws.net.home>
References: <20210601083849.niumt2zvyr3boiqw@ws.net.home>
 <e00ea8fe-e848-73c1-1314-de26ad698c90@gmail.com>
 <20210602152710.jjs2fpkcegtvlnvb@ws.net.home>
 <4a6781ff-04ad-f3e1-402e-b4cb65d1749b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6781ff-04ad-f3e1-402e-b4cb65d1749b@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 02, 2021 at 11:25:14AM -0500, Bruce Dubbs wrote:
> On 6/2/21 9:27 AM, Karel Zak wrote:
> > On Tue, Jun 01, 2021 at 01:29:21PM -0500, Bruce Dubbs wrote:
> > > On 6/1/21 2:38 AM, Karel Zak wrote:
...
> > > Karel, Is there any chance you can release a tarball with rendered man
> > > pages?  It would make things a lot easier for us.
> > 
> > I'm not sure if duplicate content in the upstream source
> > tarball is a good idea (it means keep there AsciiDoc as well as
> > generated man pages).

Today morning I had time to play with it and it seems that we can
distribute man pages as well as adoc in the same tarbal, the size
change is not so big:

5956904  util-linux-2.37.42-308a1-dirty.tar.xz
5863940  util-linux-2.37.tar.xz

 ~1.5% up, that's something we can ignore.

It also seems that autotools are smart enough to keep the man pages
synchronized with adoc without any significant changes to our build
system.

> Our problem is that when we install util-linux we have a bare environment
> and do not have asciidoc or asciidoctor installed.  Adding those would
> require a long dependency tail (ruby, docbook, etc).

Yes, that's what I understand.


   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


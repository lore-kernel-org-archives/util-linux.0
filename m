Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C5C761A6
	for <util-linux@archiver.kernel.org>; Tue,  4 Apr 2023 10:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjDDKOl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Apr 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjDDKOi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Apr 2023 06:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881032D49
        for <util-linux@vger.kernel.org>; Tue,  4 Apr 2023 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680603195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2nCmTm/JWq6/9F0eCdqUfy9Ccc7rxIx1wyLDzH37MM=;
        b=LheZrIccCY8AT5xjLaHYmrkc5JqPL9/68+uR1IoOrbK4Z9eY3NjVmwAb/3ALc8WBefcM6x
        0h94LW27JWEg/jxhUzcZwJQUYiMWsKPBYyNfxbPOs1YeWoeLWmAb0HKBoKjpyzWMXFljeE
        aazqBSyyk6dTlAPJoQjVvwosbMDhyEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-zqIxkb9COhe5hATE_a5jGA-1; Tue, 04 Apr 2023 06:13:14 -0400
X-MC-Unique: zqIxkb9COhe5hATE_a5jGA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17FB1800B23;
        Tue,  4 Apr 2023 10:13:14 +0000 (UTC)
Received: from ws.net.home (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9068A492C13;
        Tue,  4 Apr 2023 10:13:13 +0000 (UTC)
Date:   Tue, 4 Apr 2023 12:13:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Cc:     util-linux@vger.kernel.org
Subject: Re: fstab format, 4th field mandatory and the "sw" value
Message-ID: <20230404101311.3avcw3oldefbdzs6@ws.net.home>
References: <45fc7a385b006d734011a11487fbfdda4333644e.camel@christoph.anton.mitterer.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45fc7a385b006d734011a11487fbfdda4333644e.camel@christoph.anton.mitterer.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 29, 2023 at 03:03:16PM +0200, Christoph Anton Mitterer wrote:
> The following is in principle just cosmetic.

OK, let's be academic ;-)

> I recently wondered[0] what fstab entries for swap areas should look
> like.
> 
> Some resources recommend e.g.:
>   <swap-device/file> none swap sw 0 0
> others somehting like:
>   <swap-device/file> swap swap defaults 0 0
> 
> 
> fstab(5) describes the appropriate values for swap for fields 1 to 3
> (inclusive).
> But it gives nothing about the 4th.

For libmount/mount(8)/swapon, everything after 3rd field is optional.

> Neither do e.g. the manpages mount(8) or swapon(8).
> Especially there seems to be no longer any mention of "sw"
> 
> getfsent(3) still contains a reference to "sw",... seems it comes
> originally from BSD.

swapon(1) supports pri= or discard= options, so the field makes sense

> "default", which is documented as:
> > use default options: rw, suid, dev, exec, auto, nouser, and async.

The "default" should be described better on the man page. I'll fix it.
Its _kernel_ default for the filesystem, mount, or swapon has no
built-in default.

> doesn't seem to be the best choice either.

Frankly, "default" would be the best do describe what happen for a
swap area or an FS.

> Personally I'd have said that - from the documented values alone -
> "auto,nouser" perhaps in addition with "rw" might the most fitting
> choice.
> 
> fstab(5) even seems to make either "rw" or "ro" mandatory, by saying:
> > It contains at least the type of mount (ro or rw)
> 
> which I don't thin is however really enforced (neither would it mention
> any such thing for auto vs. noauto).

The default is rw, the man page is wrong here.

> In the thread at [0], a participant suggested that the most appropriate
> entry would be simply:
>   <swap-device/file> none swap
> i.e. omitting the 4-6th fields.
> 
> 
> However, at least by fstab(5), the 4th field (unlike #5 and #6) does
> seem to be required.

It depends who read the man page, I can imagine that some parsers
requires it.

> *If* fstab(5) is considered to be like a formal description of the
> fstab format it would be nice if the following could be clarified:
> - Whether or not "rw" respectively "ro" are really required (or whether
>   absence of both of them (and absence of "defaults") causes an
>   implicit default to be used.
>   The same for auto/noauto.
> - Whether he 4th field is mandatory and if not, what that means.
>   Is it the meaning of "defaults" or is it nothing except for the
>   "implicit defaults" of ro/rw noauto/auto?
> - Whether or not the other special values from getfsent(3), i.e. "rq",
>   "sw", "xx" still have any meaning for linux (and if it's just that
>   they're ignored)... and similar as it's done for fields 1-3, what
>   should be used for swap areas.

I have committed:
https://github.com/util-linux/util-linux/commit/43a6b183d8945cc91307f21adc8070254eb925b5

I'm unsure if this is explicit enough, but it answers the basics (I hope).

> Along with that, it might perhaps make sense to replace "swap
> partition(s)" with "swap device(s)", as a swap device doesn't need to
> be a partition.

Good point.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


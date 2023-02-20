Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1AC636CC
	for <util-linux@archiver.kernel.org>; Mon, 20 Feb 2023 12:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBTM2r (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 20 Feb 2023 07:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjBTM2q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 20 Feb 2023 07:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CEF1C58E
        for <util-linux@vger.kernel.org>; Mon, 20 Feb 2023 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676895984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6Pzyj0npfLLR9wBQuQIVQf7Jouv4DgDpoAxf/T9D60=;
        b=gjOuMPYXyvcBBvnFNNd8kS2Vi3GBJHk5KEzp/9u5A6AK6U2okiWUcPAsiE4olVG0z6VvIZ
        OtyJIb/7TIwIREC2xgMRRgOeEEDL/muh/XyWopnOL2dTmlxW1Afx1M0u63Aq+ft7q2Q+iF
        yzBI6d6AmQp54+swHkdexzET/e8u8mo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-t45LoU8IMhGvmvflph4xRg-1; Mon, 20 Feb 2023 07:26:20 -0500
X-MC-Unique: t45LoU8IMhGvmvflph4xRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E80F800B23;
        Mon, 20 Feb 2023 12:26:20 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68686C15BA0;
        Mon, 20 Feb 2023 12:26:19 +0000 (UTC)
Date:   Mon, 20 Feb 2023 13:26:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chris Hofstaedtler <zeha@debian.org>,
        Michael Richardson <mcr@sandelman.ca>,
        util-linux@vger.kernel.org, Michael Trapp <michael.trapp@sap.com>
Subject: Re: uuid and RFC4122
Message-ID: <20230220122617.bsbh6on6256gfrd3@ws.net.home>
References: <14266.1676658860@localhost>
 <20230219170116.q453di5cmknxn665@zeha.at>
 <Y/LPN7pf6x75Xm9H@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/LPN7pf6x75Xm9H@mit.edu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Feb 19, 2023 at 08:39:03PM -0500, Theodore Ts'o wrote:
> On Sun, Feb 19, 2023 at 06:01:16PM +0100, Chris Hofstaedtler wrote:
> > Hello Michael,
> > 
> > * Michael Richardson <mcr@sandelman.ca>:
> > > Hi, thanks for your work on debian packages.
> > > I'm contacting you wearing my IETF uuidrev WG co-chair on.
> > > 
> > > The https://datatracker.ietf.org/wg/uuidrev/documents/ WG was chartered to
> > > update RFC4122 last summer, and we expect to start a WGLC on RFC4122bis in
> > > the next few weeks.  This is just a heads up for now.
> > > 
> > > Some comments, even they are just "Looks Good to Me" from the util-linux
> > > folks would be awesome.
> > 
> > Thanks for reaching out, but from the Debian side I think we have
> > little to comment on (mostly for lack of expertise).
> > 
> > I've CC:ed the upstream mailing list, in the hope that upstream
> > util-linux folks have comments.
> 
> Hi,
> 
> I originally wrote the uuid implementation in util-linux.  Originally,
> it was first in e2fsprogs, and then later the library was transferred
> to util-linux at least for most Linux distributions.  Technically
> speaking, however, libuuid is still shipped in the e2fsprogs sourecs
> and that's the version which is used by Android and some non-Linux
> OS's including NetBSD and Darwin (MacOS may have forked the library,
> though, so if I shipped updates in e2fsprogs how quickly it would get
> picked up by Apple.)  Libuuid is mostly in maintenance mode, actually;
> the sort of changes that have landed recently have been to support the
> getrandom(2) system call.
> 
> I'm not sure what the context is for this e-mail thread, or what
> you're asking for in terms of an LGTM?  Were you looking for comments
> on draft-ietf-uuidrev-rfc4122bis?  Or were you hoping to see if folks
> might be interested in implementing the new UUID versions in
> draft-ietf-uuidrev-rfc4122bis so the libuuid in Linux might support
> those new variants?

Note that libuuid in util-linux is actively maintained and improved.

It already supports MD5 and SHA1 based UUIDs, and I think we can add
the new versions v6 (Reordered Gregorian time-based), v7 (Unix Epoch
time-based) and v8 (custom SHA256/SHA512 based) in the near feature.

CC also to Michael, who worked on libuuid in last years; not sure
but maybe v6, which improves use in databases, could be attractive for
SAP, see:
https://datatracker.ietf.org/doc/draft-ietf-uuidrev-rfc4122bis/

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


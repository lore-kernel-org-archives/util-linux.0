Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF42EC433E0
	for <util-linux@archiver.kernel.org>; Tue,  9 Mar 2021 08:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEAE64F6B
	for <util-linux@archiver.kernel.org>; Tue,  9 Mar 2021 08:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhCIItT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Mar 2021 03:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhCIItR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Mar 2021 03:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615279756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPB9+GQFDuN9VirK1mN9Vy+8Ny/2oBo4EUpJeAw9+Cg=;
        b=FLggRaqtdNIN2ZRQTRHXSNAxG2fMMyWl+Y76QvDf1m94g5XNKiqUJq0iKfmmNohNVIrduz
        Peeu9Us0StN9f034gPQtaHzi1ycDrK0rjjaGeolTko23VFY6+J26udRBWCiRRJacAoWIQ/
        rCmsWOPYIMMfVA94MP/IVUozFzezC9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-KwP5I9Q4OFK0lQc85fDDeg-1; Tue, 09 Mar 2021 03:49:12 -0500
X-MC-Unique: KwP5I9Q4OFK0lQc85fDDeg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05501814313;
        Tue,  9 Mar 2021 08:49:12 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 569B962665;
        Tue,  9 Mar 2021 08:49:11 +0000 (UTC)
Date:   Tue, 9 Mar 2021 09:49:08 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Help needed with man page conversions to asciidoc?
Message-ID: <20210309084908.izmuxsrqujiml6ph@ws.net.home>
References: <karelzak/util-linux/issues/1257@github.com>
 <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 08, 2021 at 09:10:34PM +0100, Mario Blättermann wrote:
> >
> > I like the idea with translated man pages maintained in the
> > upstream tree, keep it all in one place is the only way how to
> > keep it up to date. If I good understand then the result will be
> > another template on translationproject.org to maintain man pages
> > strings in po, right? What about in-tree .po files? I guess it
> > should be separate from normal po files, po-docs/ directory?
> >
> Yes, it needs a separate .po file. It's not OK to mix UI and doc
> translations. Well, it's theoretically possible to merge both .pot
> files in one to force translators to work on both UI and man pages.
> But I think the UI .pot file with more than 4000 gettext messages is
> big enough, especially for newbies. So don't let's blow it up to more
> than 10000.

 I agree.

> I propose the following structure:
> 
> The asciidoc man pages will be stored where the *roff man pages reside
> for ages: in their respective subdirectories (sys-utils, schedutils,
> whatever). For the special asciidoc files footer.adoc,
> translation.adoc and asciidoc.conf we need an extra directory, let's
> name it "man-common".

 OK.

> For the man page translations, we can also use man-common. It's a good
> place for files like po4a.conf or the TP sync script (if desired), and
> the subdirectory "po".

 OK. For scripts, see also tools/ directory where we have some
 checkers, simple script to commit po/ changes to git (git-tp-sync)
 etc.

...
> > Is there any possibility to use some "style" template for
> > conversion to the man pages (for example the same header/footer
> > for all pages, generic sections like AVAILABILITY, etc.)?
> >
> Yes, see the attached tarball for an example footer.adoc. I could
> extend it with a "Reporting bugs" section.

 I see, it looks pretty cool and readable.

> > Don't worry about Autotools, I'll do this task. All I need is some
> > command-line examples of how to do the conversion.
> 
> Oh, very nice... Although I also use Autotools in manpages-l10n (but
> haven't written all the Makefile* and related stuff), my knowledge is
> poor, and I'm happy after each release without problems;)
>
> Karel, I've already forked the util-linux project at Github; maybe it
> is useful to create a branch for the Asciidoc stuff in your main repo,
> which I can check out into the forked repo? This would be probably the
> most painless way for a merge request.

 OK, I have created a new branch "topic/asciidoc" on github.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


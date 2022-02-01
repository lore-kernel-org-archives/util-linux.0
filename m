Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014DC433EF
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 12:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiBAM6P (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 07:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233789AbiBAM6O (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 07:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQ/RpQV6+uMUXdsWUrI0rfPdcU+rjY7V1pL6t/3zYf4=;
        b=ZVRqQoVnCz36YEQip9FEm8C//z3A5qoq8NTW5+YJR3ylWUfLg2kQl3OVnCsTN+kodniPbE
        hOeQbJ5gF3elvf7RNvRenM2qdBbvCNIiQxR4T8L2spkcZrz8vQZvLHbachTBg+qzRUyPAP
        DjrVzS8X8Xu2pqGeVhPiRwVuxo9b234=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-NWk5-G5aNuWes7rveEQfiQ-1; Tue, 01 Feb 2022 07:58:10 -0500
X-MC-Unique: NWk5-G5aNuWes7rveEQfiQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A6219251A0;
        Tue,  1 Feb 2022 12:58:09 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 34371109003E;
        Tue,  1 Feb 2022 12:58:09 +0000 (UTC)
Date:   Tue, 1 Feb 2022 13:58:06 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Unify the --help and --version descriptions in man pages?
Message-ID: <20220201125806.7shbxjw4mcyhmlhw@ws.net.home>
References: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
 <20220131093510.onug66aufuadj2ed@ws.net.home>
 <CAHi0vA-8RYm88aYbLAuTcwBLYuH+GsVWP2WEqucFQXCsg2CKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA-8RYm88aYbLAuTcwBLYuH+GsVWP2WEqucFQXCsg2CKpg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 09:17:22PM +0100, Mario Blättermann wrote:
> Hello Karel,
> 
> Am Mo., 31. Jan. 2022 um 10:35 Uhr schrieb Karel Zak <kzak@redhat.com>:
> >
> > On Sat, Jan 29, 2022 at 12:57:12PM +0100, Mario Blättermann wrote:
> > > I've just noticed the commit »docs: add man-common/in-bytes.adoc«.
> > > What about to unify the descriptions of the --help and the --version
> > > options in the man pages in a similar manner? Besides to simplify the
> > > maíntenance, it would also shrink the .po file of the man pages a bit.
> >
> > Arbitrary unification and consolidation is wanted, go ahead ;-)
> >
> > > --- blockdev.8.adoc     2021-11-26 17:40:06.931013901 +0100
> > > +++ blockdev.8.adoc    2022-01-29 12:47:43.087144014 +0100
> > > @@ -40,10 +40,10 @@
> > > Print a report for the specified device. It is possible to give multiple device
> > > s. If none is given, all devices which appear in _/proc/partitions_ are shown. N
> > > ote that the partition StartSec is in 512-byte sectors.
> > >
> > > *-h*, *--help*::
> > > -Display help text and exit.
> > > +include::man-common/help-description.adoc[]
> > >
> > > *-V*, *--version*::
> > > -Print version and exit.
> > > +include::man-common/version-description.adoc[]
> >
> > Do we need to separate help & version? Maybe we can use
> >
> >   include::man-common/help-and-version.adoc[]
> >
> > where will be everything.
> >
> >       *-h*, *--help*
> >               Display help text and exit.
> >
> >       *-V*, *--version*
> >               Display version information and exit.
> >
> > We use the same in usage() function (--help output) where both
> > items are printed together by USAGE_HELP_OPTIONS macro. (see 'git grep
> > USAGE_HELP_OPTIONS')
> >
> > IMHO --help and --version is so generic that we do not need to keep it
> > sorted in man pages. I guess it's OK to keep it at the end of the list
> > of options like we use in usage().
> 
> 
> OK, this is possible for --help without any other changes; all our
> tools have the same options (*-h*, *--help*). But for --version, the
> single-letter option differs. While most of the tools have *-V*,
> *--version*, it is *-v*, *--version* for the following ones:
> 
> sfdisk.8.adoc
> chsh.1.adoc
> chfn.1.adoc
> 
> For sfdisk, -V has a different meaning, and for chsh and chfn the
> option -V is unknown (invalid). So we could change chsh and chfn to
> accept -V (and maybe drop -v in turn), and we leave the --help and
> --version part of sfdisk.8.adoc untouched.

For chsh and chfn it's probably good idea to support also -V, but for
backward compatibility it would be nice to keep -v in code (not
necessary in man page).

And yes, sfdisk.8.adoc keep untouched.

> > > BTW, are there any plans for the next release 2.38? I'm planning to
> >
> > The last remaining patch is x-fstrim from Stanislav and than I'll
> > release v2.38-rc1 :-) (so today).
> >
> > > add direct support for Fedora 36 in manpages-l10n (once it is
> > > available from the servers), in addition to Rawhide. If v2.38 will
> > > come with Fedora 36, I could adjust the package lists appropriately,
> > > to avoid file conflicts.
> >
> > F36 beta freeze is 2022-03-15, it seems we have enough time.
> >
> So I assume you plan to release the final v2.38 until this Fedora Beta
> gets rolled out, including the translated man pages?

v2.38-rc1 is Fedora rawhide now :-) But without translated man pages,
I need to play with it during work on rc2.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


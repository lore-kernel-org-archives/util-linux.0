Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96BCC433F5
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiAaJfV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 31 Jan 2022 04:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237158AbiAaJfT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 31 Jan 2022 04:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643621719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vQRioYYCFuoBFwLDgUx1Ctr9eWPIa8xmvoRJNa+cozs=;
        b=O3Oh46/dhzj8xYTercjf63KqkJ/RFdACI9aMUQfIfYYBJ2UBGwfoq3o2ft9xxKXLgpS4oM
        5vON8mC72lhlfs7ZamAraYB/YgNFdTx0dXGRti091D9oVNFrFVhhZmdzb5UPFjXmLAdbPe
        dHZog9cJouj3PxxLuTfcAVf99+J035c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-I7kq-17gNvO4NMZsY0dQ2g-1; Mon, 31 Jan 2022 04:35:14 -0500
X-MC-Unique: I7kq-17gNvO4NMZsY0dQ2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF45B1091DA1;
        Mon, 31 Jan 2022 09:35:13 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3939B56A86;
        Mon, 31 Jan 2022 09:35:13 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:35:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Unify the --help and --version descriptions in man pages?
Message-ID: <20220131093510.onug66aufuadj2ed@ws.net.home>
References: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 29, 2022 at 12:57:12PM +0100, Mario Blättermann wrote:
> I've just noticed the commit »docs: add man-common/in-bytes.adoc«.
> What about to unify the descriptions of the --help and the --version
> options in the man pages in a similar manner? Besides to simplify the
> maíntenance, it would also shrink the .po file of the man pages a bit.

Arbitrary unification and consolidation is wanted, go ahead ;-)

> --- blockdev.8.adoc     2021-11-26 17:40:06.931013901 +0100
> +++ blockdev.8.adoc    2022-01-29 12:47:43.087144014 +0100
> @@ -40,10 +40,10 @@
> Print a report for the specified device. It is possible to give multiple device
> s. If none is given, all devices which appear in _/proc/partitions_ are shown. N
> ote that the partition StartSec is in 512-byte sectors.
> 
> *-h*, *--help*::
> -Display help text and exit.
> +include::man-common/help-description.adoc[]
> 
> *-V*, *--version*::
> -Print version and exit.
> +include::man-common/version-description.adoc[]

Do we need to separate help & version? Maybe we can use

  include::man-common/help-and-version.adoc[]

where will be everything.

      *-h*, *--help*
              Display help text and exit.

      *-V*, *--version*
              Display version information and exit.

We use the same in usage() function (--help output) where both
items are printed together by USAGE_HELP_OPTIONS macro. (see 'git grep
USAGE_HELP_OPTIONS')

IMHO --help and --version is so generic that we do not need to keep it
sorted in man pages. I guess it's OK to keep it at the end of the list
of options like we use in usage().

> BTW, are there any plans for the next release 2.38? I'm planning to

The last remaining patch is x-fstrim from Stanislav and than I'll
release v2.38-rc1 :-) (so today).

> add direct support for Fedora 36 in manpages-l10n (once it is
> available from the servers), in addition to Rawhide. If v2.38 will
> come with Fedora 36, I could adjust the package lists appropriately,
> to avoid file conflicts.

F36 beta freeze is 2022-03-15, it seems we have enough time.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


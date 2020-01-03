Return-Path: <SRS0=ZGwe=2Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D2C2D0C2
	for <util-linux@archiver.kernel.org>; Fri,  3 Jan 2020 11:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FF421835
	for <util-linux@archiver.kernel.org>; Fri,  3 Jan 2020 11:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oddw2C8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgACLsY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:48:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727220AbgACLsY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jan 2020 06:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578052102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJGn15h0dl0LykP5bvlBe3Kf0J6dAJrRr0dhLQHH53c=;
        b=Oddw2C8UoeeXQhJec4ylTLnpdKcCDREODRsoTHGMmyOG8ktuKQEvngK6esnBhPGareX2Hp
        GDbqihIJCNqk9w9oQUJGQM+XzgXybc7WvY/PW5RRvkbYnuOrSoriAD+2MLKI4P5003ohaX
        9iyxBIQoin0XJAiXh8MneMlbwmH6X9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-wvBsmO7JMlaNH96Atci-dQ-1; Fri, 03 Jan 2020 06:48:19 -0500
X-MC-Unique: wvBsmO7JMlaNH96Atci-dQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 270E6107ACC7;
        Fri,  3 Jan 2020 11:48:18 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A516B5C28C;
        Fri,  3 Jan 2020 11:48:16 +0000 (UTC)
Date:   Fri, 3 Jan 2020 12:48:14 +0100
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>
Cc:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: howto-man-page.txt: Use font macros instead of font
 escapes
Message-ID: <20200103114814.2roeaoes2uu3enxu@10.255.255.10>
References: <20191216222032.GA25430@rhi.hi.is>
 <nycvar.YAK.7.76.1912171449170.1929@zhn.tzk.pbz>
 <20200102001715.GA30885@rhi.hi.is>
 <nycvar.YAK.7.76.2001021131520.1385@zhn.tzk.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YAK.7.76.2001021131520.1385@zhn.tzk.pbz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 02, 2020 at 11:52:06AM -0500, J William Piggott wrote:
> On Thu, 2 Jan 2020, Bjarni Ingi Gislason wrote:
> > Comment the font-escape line and
> > add the font-macro line after it.
>=20
>  If I had submitted a patch like that it would have been rejected
>  (although I would not do that to a production man page anyway).

Well, frankly... I don't like man-page (re)formatting patches :-)=20

It's maintainer's nightmare -- always is there someone who hates the
change, it's difficult review all the details and keep all consistent
if you have large collection of man pages from different
sources/authors, etc.

For me the best would be to maintain *content* in some formatting
independent data format like AsciiDoc or DocBook, and before release
or during package build process generate wanted output according a
user-specified template; it's only a way how to support user or distro
specific point of view.

For example asciidoctor (AsciiDoc backend) is actively maintained and
used by projects like github. Not sure about readability of the final
man pages, but it seems that AsciiDoc -> DocBook -> man page is
possible way.

And for example systemd guys maintain man pages directly in XML DocBook.

IMHO it's way to go rather than for ever play "color of bike shed"
game with our man pages.

=E2=80=9CContent is King=E2=80=9D :-) Volunteers?

    Karel


--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


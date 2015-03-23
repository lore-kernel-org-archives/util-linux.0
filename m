Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbbCWLQn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Mar 2015 07:16:43 -0400
Date: Mon, 23 Mar 2015 12:16:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Otto Visser <work@otvi.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [libfdisk] incorrect GPT header leads to segfault
Message-ID: <20150323111640.GE1749@ws.net.home>
References: <550C1E49.3000509@otvi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <550C1E49.3000509@otvi.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 20, 2015 at 02:19:05PM +0100, Otto Visser wrote:
> I then made the following (ordering) change in libfdisk/src/gpt.c:
> 
> 956a957,961
> >       /* make sure header size is between 92 and sector size bytes */
> >       hsz = le32_to_cpu(header->size);
> >       if (hsz < GPT_HEADER_MINSZ || hsz > cxt->sector_size)
> >               goto invalid;
> >
> 973,977d977
> <               goto invalid;
> <
> <       /* make sure header size is between 92 and sector size bytes */
> <       hsz = le32_to_cpu(header->size);
> <       if (hsz < GPT_HEADER_MINSZ || hsz > cxt->sector_size)

Thanks. Fixed.

> Although this fixes getting the segfault, it still means that fdisk
> concludes there is no GPT label, despite that the signature is clearly
> there; hence I wouldn't want to call this an actual patch.

Well, be able to work with broken GPT header means that we have to
implement something like fsck for GPT -- analyze each field in the
header and try to fix it. I'm going to add this to TODO.

I don't think something like GPT fsck should be within regular GPT
probing code. It's very special use-case.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

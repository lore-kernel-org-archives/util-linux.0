Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33639 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdEPL7o (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 May 2017 07:59:44 -0400
Received: by mail-wm0-f49.google.com with SMTP id f135so35444222wmd.0
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 04:59:43 -0700 (PDT)
Date: Tue, 16 May 2017 13:59:40 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: udf: Incorrect implementation of Unicode strings
Message-ID: <20170516115940.GD10015@pali>
References: <201705121638.59416@pali>
 <20170515100940.lggq2um6xt3dg66p@ws.net.home>
 <20170515123845.GA10015@pali>
 <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170516110139.v63qiov2ndxw2gwa@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 16 May 2017 13:01:39 Karel Zak wrote:
> On Mon, May 15, 2017 at 02:38:45PM +0200, Pali Rohár wrote:
> > But question remain what to do with UUID.
> 
> It seem generated UUID is libblkid feature and another tools/systems
> don't use anything like UUID for UDF, right?

Yes. Introduced in https://github.com/karelzak/util-linux/pull/135

But I would like to see UUID support also on other places (e.g. Grub2)
so it would be possible to use it really as UUID of FS. Which means we
need some normalized way of generation.

> If yes... then we can keep it unchanged, generate UUDI in the same way
> as now (hexadecimal digits). The "OSTA Unicode fix" maybe be used for
> LABEL= (etc) only. I guess nothing forces use to generate UUIDs from 
> decoded VolSetId.
> 
> Anyway, UUID has to be printable.

Lets first define allowed characters in UUID and then what we do with
UDF's UUID.

Printable means only printable ASCII? Or also printable from Unicode? Or
only alphanumeric?

Printable ASCII characters are: 0x20 - 0x7E (included). Which means that
also space is is printable.

So what could make sense:

* ASCII uppercase (or lowercase) hexdigits
* ASCII hexdigits
* ASCII alphanumeric
* ASCII alphanumeric and underline
* ASCII printable without space
* ASCII printable (including space)
* UNICODE Basic Latin without space + Latin-1 Supplement without space
* UNICODE Latin script without controls and spaces
* UNICODE Latin script without controls (including spaces)

> > I suggest to include all UDF changes in one release, so "breakage" would
> > be just between two versions. So if above Label/UUID changes would not
> > be ready for next release, I would suggest to postpone currently merged
> > UDF changes.
> 
> Yes.

Ok.

-- 
Pali Rohár
pali.rohar@gmail.com

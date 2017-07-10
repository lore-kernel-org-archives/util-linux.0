Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f170.google.com ([209.85.128.170]:35367 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbdGJLPW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Jul 2017 07:15:22 -0400
Received: by mail-wr0-f170.google.com with SMTP id k67so133682707wrc.2
        for <util-linux@vger.kernel.org>; Mon, 10 Jul 2017 04:15:21 -0700 (PDT)
Date: Mon, 10 Jul 2017 13:15:09 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: ID_FS_VERSION
Message-ID: <20170710111509.GB560@pali>
References: <201707051349.26662@pali>
 <20170710110828.r6dr6buolw4xtgpm@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170710110828.r6dr6buolw4xtgpm@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 10 July 2017 13:08:28 Karel Zak wrote:
> On Wed, Jul 05, 2017 at 01:49:26PM +0200, Pali Rohár wrote:
> > Hi! What is the meaning of the ID_FS_VERSION attribute? I'm trying to 
> > find documentation about libblkid attributes, but seems there is none.
> 
> libblkid/src/superblocks/superblocks.c
> 
>    * @VERSION: filesystem version
> 
> :-)

That does not provide more information :-)

> Well, the field is to provide more details about the filesystem, for
> example we have VERSION="FAT16" TYPE="vfat", and so on. Note that TYPE
> is usually name used by kernel (to be usable for "mount -t <type>").
> 
> I guess the VERSION is used by some userspace stuff (udisks?) to get
> more information (or provide more details to end-users). It's probably
> nothing critical.

I'm thinking if we can provide UDF revision/version of UDF filesystem to
userspace and looks like ID_FS_VERSION is good candidate for it...

What do you think?

E.g. Linux kernel is able to read UDF filesystem up to revision 2.50 and
has read-write support up to revision 2.01. So for userspace this
information can be useful.

-- 
Pali Rohár
pali.rohar@gmail.com

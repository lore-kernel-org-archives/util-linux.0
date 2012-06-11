Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcahe.dreamhost.com ([208.97.132.74]:60169 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753474Ab2FKLpI convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jun 2012 07:45:08 -0400
Subject: Re: [PATCH] allow to create a minix3fs with a blocksize != 1K
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Vladimir =?UTF-8?Q?=27=CF=86-coder/phcoder=27?= Serbinenko
	<phcoder@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
In-Reply-To: <4FD501AE.2070506@gmail.com>
References: <4FAAE6EA.3080308@gmail.com>  <4FAAE7FB.2060808@gmail.com>
	 <1339358318.3369.35.camel@offbook>  <4FD501AE.2070506@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 11 Jun 2012 13:45:04 +0200
Message-ID: <1339415104.2684.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 2012-06-10 at 22:21 +0200, Vladimir 'φ-coder/phcoder' Serbinenko
wrote:
> On 10.06.2012 21:58, Davidlohr Bueso wrote:
> 
> > On Wed, 2012-05-09 at 23:56 +0200, Vladimir 'φ-coder/phcoder' Serbinenko
> > wrote:
> >> Have used it to test minixfs support with various block sizes.
> >>
> > 
> > Hi Vladimir,
> > 
> > A few comments:
> > 
> > +       if (MINIX_BLOCK_SIZE % 512 || MINIX_BLOCK_SIZE < 1024
> > +           || MINIX_BLOCK_SIZE >= 65536)
> > +               usage();
> > 
> > This check should be part of the switch statement, perhaps in its own
> > function.
> > +       if (*tmp && ...)
> > 
> > 
> 
> Ok
> 
> > +       if (fs_version != 3 && MINIX_BLOCK_SIZE != MINIX12_BLOCK_SIZE)
> > +               usage();
> > 
> > We should set -1/-2 options to be mutually exclusive with -B.
> > 
> 
> Ok
> 
> > +#define MAX_MINIX_BLOCK_SIZE 65536
> > Isn't the max minix block size 4096?
> > 
> 
> No, Maximum for the on-disk format is 65535. Minix itself supports
> everything from 1025 to 65536-512 as long as it's divisible by 512.
> Linux driver is limited to 1024, 2048 and 4096

hmmm, do you have any documentation I can look at? Both the native mkfs
minix tool and the mfs server, also set the max block size to 4K.
Unfortunately I don't have a copy of ast's minix book.

> 
> > +#define MINIX12_BLOCK_SIZE   1024
> > This is the minimal block size, including v3. MINIX12_ doesn't describe
> > it well.
> > 
> 
> I use this constant specifically in places which only relate to v1 and v2
> 
> > 
> > Also, please send the patches in the body of the message - just as with
> > the lkml.
> > 
> 
> Ok
> 
> > Thanks,
> > Davidlohr
> > 
> > 
> 
> 
> 



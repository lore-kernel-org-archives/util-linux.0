Return-Path: dave@gnu.org
Message-ID: <1354937076.2664.12.camel@offbook>
Subject: Re: libfdisk branch
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Petr Uzel <petr.uzel@suse.cz>
Date: Fri, 07 Dec 2012 19:24:36 -0800
In-Reply-To: <20121206143527.GB4991@x2.net.home>
References: <20121206143527.GB4991@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-12-06 at 15:35 +0100, Karel Zak wrote:
> Hi,
> 
>  I have created libfdisk branch at github. The most important change
>  is libfdisk/ directory. The directory contains the new code from
>  fdisks/utils.c (this file does not exist anymore). The goal is to
>  create a code independent on the global variables mess in fdisks/.

Thanks for doing this Karel. I think this makes a lot of sense since
utils.c was starting to get messy (lots of different _layers_ together).
We also have to move the label files in libfdisk/, fdisks should only
have {c,s}fdisk.c

So fdisk patches should now be on top of this new branch, right?

> 
>  The library won't be distributed as shared library, it's libfdisk.la
>  for the fdisk only (at least for now before the API will be stable
>  and usable).

Agreed. This reminds me that we still haven't updated the fdisk manpage
for the gpt support. IIRC you like to release around now, if so, this is
something we need to get in.

Cheers,
Davidlohr

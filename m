Return-Path: skalkoto@admin.grnet.gr
Message-ID: <52AAE5FF.90403@grnet.gr>
Date: Fri, 13 Dec 2013 12:48:31 +0200
From: Nikos Skalkotos <skalkoto@grnet.gr>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, synnefo-devel@googlegroups.com
Subject: Re: Support for the new OpenBSD disklabel format
References: <529CC1AE.9090006@grnet.gr> <20131210103208.GA8419@x2.net.home>
In-Reply-To: <20131210103208.GA8419@x2.net.home>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

On Tue 10 Dec 2013 12:32:08 PM EET, Karel Zak wrote:
> On Mon, Dec 02, 2013 at 07:21:50PM +0200, Nikos Skalkotos wrote:
>> Besides the python tool I've written, for a more permanent solution, I'm
>> considering patching libfdisk to support the OpenBSD disklabel. I wanted
>> to know if you are interested for those patches. I think the best way to
>> do it is to split the disklabel parts that have changed into different
>> structs and use unions to create a disklabel struct that will work both
>> for NetBSD and OpenBSD. What do you think?
>
> I'm just doing some invasive changes to the library -- it would be
> probably better to wait to January to avoid some collisions and extra
> work.
>
> We also have some very simple partitions table parser in libblkid
> (see libblkid/src/partitions/, mostly dos.c for nested partition tables). It
> would be nice to extend this partition table parser too.
>
> Don't forget to send some test image with the new BSD disklabel! :-)

No problem, I can wait till January. I'll keep an eye on the changes 
made in
libfdisk. I'll also examine the code under libblkid/src/partitions.

>
>> If this works out, I'd be happy to create python bindings for libfdisk
>> (like the ones you have for libmount) as a later step. I know that the
>> API is not currently stable, but most parts seem OK.
>
> It's probably too early, the API is not stable at all, maybe later in
> next year.
>
> Anyway, python binding is wanted -- we already have binding for
> libmount, Ondrej promised binding for libblkid, so binding for
> libfdisk would be excellent thing!
>
> Now the library is good enough for dialogs driven interfaces (like
> fdisk), but it's necessary to improve it for programs like cfdisk and
> sfdisk. Now I'm working on new cfdisk.

Actually I wanted to ask you about this. I've seen the fdisk_ask struct
and how the client can registers an ask_callback function, but it's not
clear to me how you are planning to allow programs to use the
library in an unattended way. Are you going to provide new methods
for this or are you going to document the data each method will ask
for to allow the user to provide the answers in advance?

If you rewrite sfdisk to use the library, I'll get all the answers I 
need. :-)

>
>     Karel
>

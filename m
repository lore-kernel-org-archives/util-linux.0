Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab3LMLq3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Dec 2013 06:46:29 -0500
Date: Fri, 13 Dec 2013 12:45:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Nikos Skalkotos <skalkoto@grnet.gr>
Cc: util-linux@vger.kernel.org, synnefo-devel@googlegroups.com
Subject: Re: Support for the new OpenBSD disklabel format
Message-ID: <20131213114555.GA16096@x2.net.home>
References: <529CC1AE.9090006@grnet.gr>
 <20131210103208.GA8419@x2.net.home>
 <52AAE5FF.90403@grnet.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52AAE5FF.90403@grnet.gr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 13, 2013 at 12:48:31PM +0200, Nikos Skalkotos wrote:
> > Now the library is good enough for dialogs driven interfaces (like
> > fdisk), but it's necessary to improve it for programs like cfdisk and
> > sfdisk. Now I'm working on new cfdisk.
> 
> Actually I wanted to ask you about this. I've seen the fdisk_ask struct
> and how the client can registers an ask_callback function, but it's not
> clear to me how you are planning to allow programs to use the
> library in an unattended way. Are you going to provide new methods

See libfdisk branch on github. There is a new 'struct fdisk_partition'
and some functions to modify this struct (well, it's not complete
yet). The idea is to use the struct as template for operations like
add partition. So the primary source for information will be the
template otherwise label drivers will ask by fdisk_ask API.

> If you rewrite sfdisk to use the library, I'll get all the answers I 
> need. :-)

Probably something like:

  struct fdisk_partition *pa = fdisk_new_partition();

  fdisk_partition_enable_default_start(pa);
  fdisk_partition_set_size(pa, 1024 * 1024 * 1024);

  fdisk_add_partition(cxt, pa);

to create 1GiB partition at the begin of the free space.

I can also imagine something like --interactive for sfdisk, so it will
possible to use incomplete input and then it will ask for the missing
things.

I guess it will be usable in python binding, because "*pa" could be an
object, so you can do things like:

 cxt = FdiskContext("/dev/sda")
 pa = FdiskPartition()
 pa[SIZE] = 1024 * 1024 * 1024
 pa[START] = FDISK_DEFAULT

 cxt.add(pa);

or so....

> or are you going to document the data each method will ask
> for to allow the user to provide the answers in advance?

I thought about it, for example add names for the ask API questions to
make it possible for the ask_callback function to detect what exactly is
wanted. But it seems to complex and callbacks driven libraries suck :-)  
(except UI events libs, etc.)

It would be probably better to keep the current ask API restricted to
things like err/warn messages, tables outputs and simple dialogs for
programs like fdisk.


Anyway, I believe that dialog driven fdisk is the best possible way
for advanced users because you can *talk* directly with label specific
code about label specific stuff. It's better than use extra
abstraction layers to describe labels and devices.  Unfortunately, for
programs like sfdisk we need something else (but I still believe that
we can make things in more lightweight way compare to libparted ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

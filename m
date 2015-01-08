Return-Path: util-linux-owner@vger.kernel.org
Received: from mta03.eastlink.ca ([24.224.136.9]:54855 "EHLO mta03.eastlink.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbbAHGbk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Jan 2015 01:31:40 -0500
Received: from cmgw04.eastlink.ca ([71.7.199.170])
 by mta03.eastlink.ca (Oracle Communications Messaging Exchange Server
 7u4-21.01 64bit (built Feb 16 2011))
 with ESMTP id <0NHU00D5EGJ15RV0@mta03.eastlink.ca> for
 util-linux@vger.kernel.org; Thu, 08 Jan 2015 02:31:39 -0400 (AST)
Received: from peter by llama.cordes.ca with local (Exim 3.36 #1 (Debian))
	id 1Y96d8-0002cz-00	for <util-linux@vger.kernel.org>; Thu,
 08 Jan 2015 02:31:38 -0400
Date: Thu, 08 Jan 2015 02:31:37 -0400
To: util-linux@vger.kernel.org
Subject: Re: fdisk units size & disk manufacturers buying the standard
Message-id: <20150108063136.GU29504@cordes.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
In-reply-to: <54AE0005.9070502@ubuntu.com>
From: Peter Cordes <peter@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 07, 2015 at 10:56:53PM -0500, Phillip Susi wrote:
> 
> > Basically, using base 10 prefixes to describe something that only 
> > comes in sizes of base-2 is a setup for miscommunication as well as
> > inherently being *unable* to accurately describe the quantities 
> > used in the computer field.
> 
> The reason base 2 is convenient for ram is because that is how it
> naturally aligns due to the way it is addressed, and they don't have
> physical constraints in the manufacturing process, not because there
> are 8 bits in a byte.  Bytes easily could have been defined to be 10
> or 12 bits and it would still make sense for ram to be built in power
> of 2 units of bytes.

 ECC RAM does in fact store 9 bits per byte, so there's an extra chip
on each stick.  It presents itself as an addressable container storing
64bit words, since the 72bit data + ECC is handled by the controller.
http://en.wikipedia.org/wiki/Synchronous_dynamic_random-access_memory#SDRAM_construction_and_operation
Point being, the natural word size of common (DDRwhatever) SDRAM isn't
8bits, but the convention of using bytes as the smallest logically
(not physically) addressable unit is so widespread that we measure
everything in bytes.

 And hard drives are most logically viewed as an array of sectors, of
size = 512B * 8 b/B.  Playing with the C/H/S geometry, or whatever you
did with scsi devices, just allowed access to more of fewer sectors.
You still use the device as a linear array of sectors, so it doesn't
matter how you go about translating linear sector addresses to
whatever addressing mode the hardware actually uses internally.

 There's huge inertia resisting any change to a convention with
smaller numbers, for marketting reasons.  This is probably also why
wire and wireless transmission protocols measure bits / sec.  (baud is
symbols / sec, BTW, which isn't bits or bytes per sec, in case anyone
needed reminding about that.)

 What are we arguing about here, anyway?  MB vs MiB?  Yeah it's
annoying that HD manufacturers used MB even before MiB was a thing,
and everyone else meant what we now call MiB.  Water under the bridge,
it's just how things are done, and I'd assume we're stuck with it.  It
only bites you when you forget to do the conversion when thinking
about if a 1TB hard drive will hold a directory with 950 GiB of data,
according to du output.  Filesystem overhead eats up space, too,
depending on the FS.

 But it's usually clear what's what.  Printing out storage device
sizes in TB and TiB together seems like a good idea, to make sure
people remember that the conversion is needed, until our wishes come
true and storage hardware is sold with sizes measured with power-of-2
prefixes, maybe by the year 2100.  Or maybe not until an alien
invasion forces the US to drop the ridiculous non-metric system, too.

 These days, everything is logically an array of bits, (almost always
a whole number of bytes), and any funky addressing is hidden behind a
hardware or at least software translation layer.

 PS, are we supposed to reply-all instead of just the list, on
util-linux?

-- 
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

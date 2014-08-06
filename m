Return-Path: util-linux-owner@vger.kernel.org
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41423 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbaHFRvu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 13:51:50 -0400
Date: Wed, 6 Aug 2014 10:51:46 -0700
From: josh@joshtriplett.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Link mkswap to mkfs.swap so mkfs -t swap works
Message-ID: <20140806175146.GA27011@cloud>
References: <20140803184813.GA20940@thin>
 <20140806133103.GJ19820@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140806133103.GJ19820@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 06, 2014 at 03:31:03PM +0200, Karel Zak wrote:
> On Sun, Aug 03, 2014 at 11:48:14AM -0700, Josh Triplett wrote:
> > This makes it easier to write generic code that deals with swap
> > along with other filesystems.
> 
>  Hmm... mkfs wrapper is deprecated, it does not provide any
>  functionality and it seems better when people use directly the FS
>  specific tools to create filesystems.

I've come across more than one script that takes a table of partition
sizes/proportions and filesystem types, creates the partitions, and
calls mkfs with the filesystem type.

Some of those scripts directly call mkfs.$type instead, rather than
mkfs -t $type, but either way this change would eliminate a special-case
for swap.

- Josh Triplett

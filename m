Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458Ab2KNJ1J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 04:27:09 -0500
Date: Wed, 14 Nov 2012 10:27:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] fdisk: api: move disklabel type to cxt
Message-ID: <20121114092702.GA1835@x2.net.home>
References: <1352880280.2577.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352880280.2577.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 14, 2012 at 12:04:40AM -0800, Davidlohr Bueso wrote:
> -	if (disklabel != DOS_LABEL)
> +	if (cxt->disklabel != DOS_LABEL)

What about to encapsulate it a little? The final goal is to have
libfdisk, so the context members shouldn't not be directly accessible.

   if (fdisk_is_disklabel(cxt, DOS))

something like:

  #define fdisk_is_disklabel(c, x)   fdisk_dev_is_dislabel(c, FDISK_DISKLABEL_ ## x)

to avoid too generic names (e.g. DOS_LABEL), but keep is brief. Note
that we already have a function fdisk_dev_has_label().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

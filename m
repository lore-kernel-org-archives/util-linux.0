Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3ENOGS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 10:06:18 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4EE6I9j009108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 May 2013 10:06:18 -0400
Date: Tue, 14 May 2013 15:06:14 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: ReFS
Message-ID: <20130514140614.GM4515@redhat.com>
References: <20130514110316.GA17246@redhat.com>
 <20130514132707.GC17246@redhat.com>
 <20130514135615.GA13909@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130514135615.GA13909@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 14, 2013 at 03:56:15PM +0200, Karel Zak wrote:
>  Yes, expected, I guess all is stored in some key-value DB (b-trees or
>  so).

Yeah, it seems very similar to btrfs.  I'm trying to write a program
that will dump out the B-/+tree, which will be a good start for anyone
who wants to have a go at writing a r/o filesystem driver (which ISN'T
going to be me -- no time).

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

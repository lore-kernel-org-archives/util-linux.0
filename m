Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:51339 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756780Ab2IDLJg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 4 Sep 2012 07:09:36 -0400
Subject: Re: [PATCH] fdisk: document FDISK_DEBUG
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <20120904105054.GA28558@x2.net.home>
References: <1345625829.2623.0.camel@offbook>
	 <20120904105054.GA28558@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 Sep 2012 13:09:32 +0200
Message-ID: <1346756972.2668.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-09-04 at 12:50 +0200, Karel Zak wrote:
> On Wed, Aug 22, 2012 at 10:57:09AM +0200, Davidlohr Bueso wrote:
> >  fdisks/fdisk.8 |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
>  Applied, thanks. It would be nice to have this info also in findmnt,
>  mount, umount, wipefs, partx, ... man pages. (LIBBLKID_DEBUG= and
>  LIBMOUNT_DEBUG=)

ah yes, of course. I'll send a patch shortly.

> 
>   Karel
> 



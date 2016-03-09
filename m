Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54514 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbcCILMb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Mar 2016 06:12:31 -0500
Date: Wed, 9 Mar 2016 12:12:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] mount: further improve formatting of the man page
Message-ID: <20160309111228.cm6etqonwbibzs5o@ws.net.home>
References: <1457520901-4133-1-git-send-email-bensberg@justemail.net>
 <1457520901-4133-2-git-send-email-bensberg@justemail.net>
 <1457521100.3212166.544009746.0578A459@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457521100.3212166.544009746.0578A459@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 09, 2016 at 11:58:20AM +0100, Benno Schulenberg wrote:
> > -Checking files on NFS filesystem referenced by file descriptors (i.e.\& the
> > +Checking files on NFS filesystems referenced by file descriptors (i.e.\& the
> >  .B fcntl
> >  and
> >  .B ioctl
> > -families of functions) may lead to inconsistent result due to the lack of
> > -consistency check in kernel even if noac is used.
> > +families of functions) may lead to inconsistent results due to the lack of
> > +a consistency check in the kernel even if noac is used.
> > +.\"  What is "noac"?

 Applied, but without this question. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

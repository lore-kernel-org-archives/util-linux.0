Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992553Ab2KBLfL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Nov 2012 07:35:11 -0400
Date: Fri, 2 Nov 2012 12:35:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpt: create empty disklabels
Message-ID: <20121102113503.GB30319@x2.net.home>
References: <1351358627.2842.3.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351358627.2842.3.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 27, 2012 at 07:23:47PM +0200, Davidlohr Bueso wrote:
> This patch enables creating a new, empty, GPT disklabel from either
> an empty disk or one that already has a disklabel. For this
> purpose, a 'g' option is added to the main menu and is visible to all
> labels. Here's an example for a scsi_debug device (/dev/sdb):
> 
> ...
> Device does not contain a recognized partition table
> Building a new DOS disklabel with disk identifier 0x20a614c8.
> 3696: fdisk:  CONTEXT: zeroize in-memory first sector buffer
> 
> Command (m for help): g

 It would be be really nice to print a message, something like

    GPT disk label created.

 and it would be also nice to print label type in the 'p'(print)
 command output and maybe also PT uuid.

>  fdisks/fdisk.c |    4 ++
>  fdisks/gpt.c   |  202 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 200 insertions(+), 6 deletions(-)

 Applied, excellent, thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

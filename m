Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3160 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab2GPQDP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Jul 2012 12:03:15 -0400
Date: Mon, 16 Jul 2012 18:03:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: API: add label probing functionality
Message-ID: <20120716160307.GB9087@x2.net.home>
References: <1341783627.2628.10.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341783627.2628.10.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 08, 2012 at 11:40:27PM +0200, Davidlohr Bueso wrote:
>  fdisks/fdisk.c         |   21 ---------------------
>  fdisks/fdisk.h         |   19 +++++++++++++++++++
>  fdisks/fdiskaixlabel.c |    8 +++++++-
>  fdisks/fdiskaixlabel.h |    2 --
>  fdisks/fdiskbsdlabel.c |    8 +++++++-
>  fdisks/fdiskbsdlabel.h |    1 -
>  fdisks/fdiskdoslabel.c |    8 +++++++-
>  fdisks/fdiskdoslabel.h |    1 -
>  fdisks/fdiskmaclabel.c |    8 +++++++-
>  fdisks/fdiskmaclabel.h |    1 -
>  fdisks/fdisksgilabel.c |    8 +++++++-
>  fdisks/fdisksgilabel.h |    1 -
>  fdisks/fdisksunlabel.c |    8 +++++++-
>  fdisks/fdisksunlabel.h |    1 -
>  fdisks/utils.c         |   35 +++++++++++++++++++++++++++++++++++
>  15 files changed, 96 insertions(+), 34 deletions(-)

 Applied, thanks ... but I'd like to see in future that we will use
 probing result from libblkid where we already have all the code for
 PT detection.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

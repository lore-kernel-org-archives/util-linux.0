Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030416Ab2K3N0p (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Nov 2012 08:26:45 -0500
Date: Fri, 30 Nov 2012 13:50:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] fdisk: api: propagate add partitions to users
Message-ID: <20121130125036.GB25818@x2.net.home>
References: <1353904158.2945.18.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353904158.2945.18.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 25, 2012 at 08:29:18PM -0800, Davidlohr Bueso wrote:
>  fdisks/fdisk.h         |    2 +-
>  fdisks/fdiskaixlabel.c |    4 +++-
>  fdisks/fdiskbsdlabel.c |   19 +++++++++++--------
>  fdisks/fdiskdoslabel.c |   36 ++++++++++++++++++++----------------
>  fdisks/fdiskmaclabel.c |    4 +++-
>  fdisks/fdisksgilabel.c |   12 +++++++-----
>  fdisks/fdisksunlabel.c |    9 +++++----
>  fdisks/gpt.c           |   12 +++++++-----
>  8 files changed, 57 insertions(+), 41 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

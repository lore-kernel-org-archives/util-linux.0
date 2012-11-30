Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab2K3Ni0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Nov 2012 08:38:26 -0500
Date: Fri, 30 Nov 2012 13:49:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] fdisk: api: move disklabel type to cxt
Message-ID: <20121130124931.GA25691@x2.net.home>
References: <1353903949.2945.15.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353903949.2945.15.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 25, 2012 at 08:25:49PM -0800, Davidlohr Bueso wrote:
>  fdisks/fdisk.c         |  191 ++++++++++++++++++++++++------------------------
>  fdisks/fdisk.h         |   34 +++++----
>  fdisks/fdiskaixlabel.c |    2 +-
>  fdisks/fdiskbsdlabel.c |    2 +-
>  fdisks/fdiskdoslabel.c |    2 +-
>  fdisks/fdiskmaclabel.c |    2 +-
>  fdisks/fdisksgilabel.c |    4 +-
>  fdisks/fdisksunlabel.c |    8 +-
>  fdisks/gpt.c           |   14 ++--
>  fdisks/utils.c         |   16 +++-
>  10 files changed, 146 insertions(+), 129 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

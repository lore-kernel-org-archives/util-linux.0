Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab2EBIri (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 May 2012 04:47:38 -0400
Date: Wed, 2 May 2012 10:47:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: isolate dos label logic
Message-ID: <20120502084711.GA24055@x2.net.home>
References: <1335650565.2545.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335650565.2545.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 29, 2012 at 12:02:45AM +0200, Davidlohr Bueso wrote:
>  fdisk/Makefile.am     |    2 +
>  fdisk/fdisk.c         |  420 +------------------------------------------------
>  fdisk/fdisk.h         |   64 ++++++++-
>  fdisk/fdiskdoslabel.c |  323 +++++++++++++++++++++++++++++++++++++
>  fdisk/fdiskdoslabel.h |   50 ++++++
>  5 files changed, 446 insertions(+), 413 deletions(-)
>  create mode 100644 fdisk/fdiskdoslabel.c
>  create mode 100644 fdisk/fdiskdoslabel.h

 Applied, but I guess it's the first step only -- for example
 new_partition(), add_partition(), ... still contain DOS label code.
 It would be nice to completely move the code to fdiskdoslabel.c
 before we start to work on the new internal API.

 Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

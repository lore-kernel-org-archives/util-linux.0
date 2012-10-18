Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754893Ab2JRKTL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Oct 2012 06:19:11 -0400
Date: Thu, 18 Oct 2012 12:19:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] fdisk: api: propagate partition deletion to users
Message-ID: <20121018101909.GC16021@x2.net.home>
References: <1349620417.2548.6.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349620417.2548.6.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 07, 2012 at 04:33:37PM +0200, Davidlohr Bueso wrote:
>  fdisks/fdisk.h         |    2 +-
>  fdisks/fdiskbsdlabel.c |    6 ++++--
>  fdisks/fdiskdoslabel.c |    4 +++-
>  fdisks/fdisksgilabel.c |   13 ++++++++-----
>  fdisks/fdisksunlabel.c |   12 +++++++-----
>  fdisks/gpt.c           |    8 +++++---
>  fdisks/utils.c         |    3 +--
>  8 files changed, 33 insertions(+), 21 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19185 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754226Ab2DWJ6m (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 05:58:42 -0400
Date: Mon, 23 Apr 2012 11:58:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] lib: add pager functionality
Message-ID: <20120423095838.GB8144@x2.net.home>
References: <1333377347.2552.19.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333377347.2552.19.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 02, 2012 at 04:35:47PM +0200, Davidlohr Bueso wrote:
>  include/pager.h |    6 ++
>  lib/Makefile.am |    2 +
>  lib/pager.c     |  214 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 222 insertions(+), 0 deletions(-)
>  create mode 100644 include/pager.h
>  create mode 100644 lib/pager.c

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

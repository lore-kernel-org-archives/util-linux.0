Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab1JLI1E (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Oct 2011 04:27:04 -0400
Date: Wed, 12 Oct 2011 10:26:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dbueso@aomail.uab.es>
Cc: util-linux <util-linux@vger.kernel.org>, dave@gnu.org
Subject: Re: [PATCH] lib/strutils: share parse_range()
Message-ID: <20111012082657.GC9667@nb.net.home>
References: <1318389492.1923.7.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318389492.1923.7.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 11, 2011 at 11:18:12PM -0400, Davidlohr Bueso wrote:
>  include/strutils.h |    2 ++
>  lib/strutils.c     |   45 ++++++++++++++++++++++++++++++++++++++++++++-
>  partx/partx.c      |   35 -----------------------------------
>  3 files changed, 46 insertions(+), 36 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

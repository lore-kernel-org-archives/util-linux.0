Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbaJNKJg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 06:09:36 -0400
Date: Tue, 14 Oct 2014 12:09:21 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?S=F8ren?= Holm <sgh@sgh.dk>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Provide libmount version as int for better compiletime
 test.
Message-ID: <20141014100921.GO8057@x2.net.home>
References: <1412172842-4137-1-git-send-email-sgh@sgh.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1412172842-4137-1-git-send-email-sgh@sgh.dk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 01, 2014 at 04:14:02PM +0200, Søren Holm wrote:
>  Makefile.am                | 3 +++
>  configure.ac               | 3 +++
>  libmount/src/libmount.h.in | 3 +++
>  3 files changed, 9 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

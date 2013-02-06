Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47705 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757254Ab3BFLB2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Feb 2013 06:01:28 -0500
Date: Wed, 6 Feb 2013 12:01:19 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] a pointer should not be compared to zero [coccinelle]
Message-ID: <20130206110006.GD24476@x2.net.home>
References: <1359578005-13427-1-git-send-email-kerolasa@iki.fi>
 <510D99FD.8060608@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <510D99FD.8060608@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 02, 2013 at 11:58:05PM +0100, Ángel González wrote:
> On 30/01/13 21:33, Sami Kerola wrote "a pointer should not be compared
> to zero":
> > Signed-off-by: Sami Kerola <kerolasa@iki.fi>

 Applied, thanks.

> Why not? It is perfectly legal.
> See http://www.c-faq.com/null/null2.html

 It's usually legal from compiler or C standard point of view, but
 it's horrible coding style manner.

 For example:
    http://lwn.net/Articles/93574/


  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

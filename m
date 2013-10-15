Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28608 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3JOLbV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Oct 2013 07:31:21 -0400
Date: Tue, 15 Oct 2013 13:31:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] a few more man-page improvements
Message-ID: <20131015113117.GC31477@x2.net.home>
References: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
 <20131015082731.GA31477@x2.net.home>
 <1381830660.19586.34144785.7C200E19@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1381830660.19586.34144785.7C200E19@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 15, 2013 at 11:51:00AM +0200, Benno Schulenberg wrote:
> Now it compiles fine, with only those five warnings in libfdisk/src/ask.c:
> «format '%zd' expects argument of type 'signed size_t', but...» and two
> unused variables in misc-utils/cal.c (when compiled without ncurses).

 Thanks! Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

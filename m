Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab1GNJSe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2011 05:18:34 -0400
Date: Thu, 14 Jul 2011 11:18:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
Message-ID: <20110714091829.GE3486@nb.net.home>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi> <1310529931.4444.7.camel@offbook> <CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com> <20110713121232.GC3486@nb.net.home> <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com> <20110713173430.GD3486@nb.net.home> <1310609005.3482.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310609005.3482.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 13, 2011 at 10:03:25PM -0400, Davidlohr Bueso wrote:
> >  Ignore kernel, 2. is right in this case.
> 
> Yep, I agree. Karel, if you have no objections then please apply my
> patch as it does fix the sb mismatch.

 Applied. It would be nice to clean up the superblocks definitions
 (use POSIX int types), move it to include/minix.h and use it for
 libblkid too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

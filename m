Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641Ab2CIMUz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Mar 2012 07:20:55 -0500
Date: Fri, 9 Mar 2012 13:20:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 09/17] lib: add fileutils function collection
Message-ID: <20120309122050.GG17711@x2.net.home>
References: <20120305123847.GD486@x2.net.home>
 <"1330976334-10751-1-git-send-email-kerolasa"@iki.fi>
 <1330976334-10751-10-git-send-email-kerolasa@iki.fi>
 <"1330984305.2953.25.camel"@offbook>
 <"CAG27Bk2LYb6h8djj0yom17oKtAy6Vvfh85Fu2k8+M9kPQGhPZg"@mail.gmail.com>
 <1331293735.4092.3.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331293735.4092.3.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 09, 2012 at 12:48:55PM +0100, Davidlohr Bueso wrote:
> I don't see how streams are more complete than descriptors - and no,
> every call to mkstemp *does not* require a call to fdopen, that's
> completely up to the user's use case.

 Add two functions :-)

    int xmkstemp()
    FILE *xfmkstemp()

 the second function might be an inline function...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50065 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbbF2J1Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Jun 2015 05:27:25 -0400
Date: Mon, 29 Jun 2015 11:27:23 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Dave Rutherford <dave@evilpettingzoo.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] wall: Print time and date (rather than just time) in
 wall banner
Message-ID: <20150629092723.GU1992@ws.net.home>
References: <E1Z8e57-0003js-1r@bb>
 <CAG27Bk1qdxbFJNGVbPezFeKJME2pLHpAgDzOkDkGzT82CtE6kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1qdxbFJNGVbPezFeKJME2pLHpAgDzOkDkGzT82CtE6kg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 27, 2015 at 09:20:58AM +0100, Sami Kerola wrote:
> That said now when everything is turning to json, maybe header and
> message should be json as well.  Something like:

 For humans? Why?

> {
>   "title": "Broadcast message"
>   "from": "foobar@example.com"
>   "tty": "pts/2"
>   "date": "2015-06-27T09:18:36+0100"
>   "message": "the stuff users write"
> }

Anyway, I don't think the current output is so bad that we have to
change it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

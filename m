Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f42.google.com ([209.85.212.42]:55274 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345Ab1IUWCt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 21 Sep 2011 18:02:49 -0400
Received: by vwl1 with SMTP id 1so3738704vwl.1
        for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 15:02:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110921202620.GD4056@thunk.org>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
	<20110921202620.GD4056@thunk.org>
Date: Wed, 21 Sep 2011 15:02:48 -0700
Message-ID: <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
Subject: Re: libuuid clock.txt fd leaks
From: Tim Pepper <tpepper@gmail.com>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 21, 2011 at 1:26 PM, Ted Ts'o <tytso@mit.edu> wrote:
> It may be that the right answer is to create a separate library which
> is used for threading programs --- or develop a completely thread-safe
> API for threaded progams, and keep the old API for
> sane^H^H^H^Hsingle-threaded programs.

I don't think this is so much about API.  The documented behavior for
uuid_generate() and its siblings does not necessarily need to change here.
I view this mostly as an internal implementation detail.

The existing code optimizes to reuse the fd and avoids repeated
open/close calls for a given caller.  If the variables are static,
they're not thread safe.  So they became thread local.  At that point
"interesting" threads may become a problem because of the lack of
destructor to do closes.  But...

Is the original optimization really needed?  If not you avoid the whole
problem...no static, no TLS, no fd left open.

And it looks like a similar thing happens in get_random_fd(), fwiw.

I wonder who would whinge on performance if the open/close simply
happened everytime?  Ie: remove initial state_fd=-2 and its associated
special casing.



Tim

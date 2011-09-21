Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:53695 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777Ab1IUVPg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Sep 2011 17:15:36 -0400
Date: Wed, 21 Sep 2011 17:15:33 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Tim Pepper <tpepper@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libuuid clock.txt fd leaks
Message-ID: <20110921211533.GA3032@thunk.org>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
 <20110921202620.GD4056@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110921202620.GD4056@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 21, 2011 at 04:26:20PM -0400, Ted Ts'o wrote:
> Part of the problem is that the uuid library was originally designed
> non-thread-using libraries, and I originally was trying to force all

Sigh, s/to force/to avoid forcing/

> programs to link against -lpthread.  (Remember, libuuid as found in
> e2fsprogs predates Linux having a standardized threads support, or any
> threads support at all.)

						- Ted

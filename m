Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439AbaBULH0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Feb 2014 06:07:26 -0500
Date: Fri, 21 Feb 2014 12:07:22 +0100
From: Karel Zak <kzak@redhat.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Kenny Rachuonyo <krmboya@gmail.com>, util-linux@vger.kernel.org
Subject: Re: Typo in mkfs man-page
Message-ID: <20140221110722.GC30903@x2.net.home>
References: <CAFeW3TRKCNKtXv-9mQC86JM6xQNySQn=csJQFa2RqBRBnbujug@mail.gmail.com>
 <20140210173545.GK8506@x2.net.home>
 <20140210185741.GF4724@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140210185741.GF4724@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 01:57:41PM -0500, Theodore Ts'o wrote:
> On Mon, Feb 10, 2014 at 06:35:45PM +0100, Karel Zak wrote:
> > On Wed, Jan 22, 2014 at 10:38:31AM +0300, Kenny Rachuonyo wrote:
> > > The short form of the --verbose option should probably be -v instead of -V
> > > 
> > > This occurs both on the online man-page:
> > > 
> > > http://man7.org/linux/man-pages/man8/mkfs.8.html
> > > 
> > > and my local system (Ubuntu 12.04) man-page.
> > 
> >  I think this historical mess is well explained in the man page. 
> 
> I'll add that I've never been convinced that the mkfs front end is all
> that useful.  It's probably better for people to explicitly run

Good point, I have marked the wrapper as deprecated.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

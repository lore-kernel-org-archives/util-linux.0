Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab1K2LT7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Nov 2011 06:19:59 -0500
Date: Tue, 29 Nov 2011 12:19:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: util-linux@vger.kernel.org
Subject: Re: Using /etc/fstab.d
Message-ID: <20111129111956.GE29168@nb.net.home>
References: <20111127221956.GF17458@codelibre.net> <20111128091435.GB29168@nb.net.home> <20111128225223.GJ17458@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111128225223.GJ17458@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 28, 2011 at 10:52:23PM +0000, Roger Leigh wrote:
> On Mon, Nov 28, 2011 at 10:14:35AM +0100, Karel Zak wrote:
> > On Sun, Nov 27, 2011 at 10:19:56PM +0000, Roger Leigh wrote:
> > > I noticed that support had recently been added for /etc/fstab.d.
> > > In Debian, we're configuring with --enable-libmount-mount, but
> > > I'm not seeing it being used; strace shows no opendir/stat calls
> > > for it.  Is anything else necessary to enable it, or is it not
> > > yet actually used by mount?
> > 
> >  Do you really have the latest git tree (gil pull to refresh)?
> 
> I was testing the 2.20.1 release, which I saw had fstab.d

 ah.. :-)

> support implemented (at least partially) in libmount.  It does
> indeed now work with current git.  Just saw that it was only
> enabled last week in mount, looking at the history.  Will it
> be long until this is in a release?

 The feature going to be supported in the next release 2.21 (beta next
 month), I don't expect any changes in this area.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46355 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaKXLks (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Nov 2014 06:40:48 -0500
Date: Mon, 24 Nov 2014 12:40:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org,
        Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH] bash-completion: Invoke actual commands to be completed,
 not basenames
Message-ID: <20141124114035.GD926@x2.net.home>
References: <CA+mSPTjwXzTnMeRb+kBF1RGLCCE_LOXDTqPgZXjrdKWbm=y9qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+mSPTjwXzTnMeRb+kBF1RGLCCE_LOXDTqPgZXjrdKWbm=y9qg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 18, 2014 at 09:28:51AM -0500, Dave Reisner wrote:
> On Nov 18, 2014 8:00 AM, "Karel Zak" <kzak@redhat.com> wrote:
> >
> > On Sat, Nov 15, 2014 at 10:36:04PM +0200, Ville Skyttä wrote:
> > >  bash-completion/chsh    | 2 +-
> > >  bash-completion/eject   | 2 +-
> > >  bash-completion/findmnt | 8 ++++----
> > >  bash-completion/losetup | 4 ++--
> > >  bash-completion/lsblk   | 2 +-
> > >  bash-completion/setarch | 2 +-
> > >  bash-completion/setpriv | 2 +-
> > >  7 files changed, 11 insertions(+), 11 deletions(-)
> >
> >  Applied, thanks!
> >
> >     Karel
> >
> 
> I think this patch breaks completions when used with binaries from a build
> root containing whitespace in the path. The use is probably rare, but fix

 For example?

> is simple -- quote the $1. The commands inside $() have their own separate
> level of quoting, i.e. "$("$1" -X)" is what we want.

 Ville, any comment?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

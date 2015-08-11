Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964826AbbHKKcZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Aug 2015 06:32:25 -0400
Date: Tue, 11 Aug 2015 12:32:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Santiago Vila <sanvila@unex.es>
Cc: kerolasa@gmail.com, Reuti <reuti@staff.uni-marburg.de>,
        util-linux <util-linux@vger.kernel.org>, ah-util-linux@debian.org,
        794727@bugs.debian.org
Subject: Re: "mesg n" exits with error, even if the command is successful
Message-ID: <20150811103222.GA13425@ws.net.home>
References: <alpine.DEB.2.11.1508091638320.23243@cantor.unex.es>
 <7302EB7B-64A1-44E7-B2C2-E28D22FDED7D@staff.uni-marburg.de>
 <20150809171906.GA27138@cantor.unex.es>
 <CAG27Bk2LoBzp122dkL7npkMSa0iEEVajE3EqMVFYnPbn5zDBHA@mail.gmail.com>
 <20150809191119.GA29884@cantor.unex.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150809191119.GA29884@cantor.unex.es>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 09, 2015 at 09:11:19PM +0200, Santiago Vila wrote:
> On Sun, Aug 09, 2015 at 06:58:15PM +0100, Sami Kerola wrote:
> > On 9 August 2015 at 18:19, Santiago Vila <sanvila@unex.es> wrote:
> > > On Sun, Aug 09, 2015 at 07:14:30PM +0200, Reuti wrote:
> > >> The profile is usually sourced. How does the error show up at the login prompt on Debian?
> > >
> > > The problem only happens in Debian testing and unstable, which I am not using yet.
> > > This is the original report which I received against base-files:
> > >
> > > https://bugs.debian.org/794727
> > 
> > Please notice the mesg(1) exit behavior is defined in POSIX
> > 
> > http://pubs.opengroup.org/onlinepubs/9699919799/utilities/mesg.html
> > 
> > Unfortunately the standard does not appear to be explicit whether the
> > exit value should be set only when requesting write permissions
> > (running without arguments), or if also when setting the permissions.
> 
> So if the standard is not explicit about this, there is some room for
> interpretation. Would not be possible to interpret the standard in a
> sensible way?

I think Posix standard is pretty explicit:

EXIT STATUS
The following exit values shall be returned:
    0 Receiving messages is allowed.
    1 Receiving messages is not allowed.
    >1 An error occurred.


but you're asking for 0 also when 'n' or 'y' operants are specified.
For me it seems like complicated return code semantic...

> Hmm, but who does really need message *setting* to report exit codes?
> They make more harm than help.
> 
> As explained before, if I do "mesg y" I can reasonably think that
> messages will be enabled after that, and if I do "mesg n" I can
> reasonably think that messages will be disabled after that.
> 
> I don't need an exit code for that, unless I don't trust the program
> to do its job, and this is why I think there is no need to interpret
> the standard so strictly.

I think standard wants to keep the things simple and stupid without
any extra exceptions (another exit codes when executed with operants).

BTW, you can use "mesg $SOMETHING_FROM_USER" and then return code
maybe an elegant way how to interpret user's input without parsing
$SOMETHING_FROM_USER.  (The current mesg implementation supporst
rpmatch().)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

Return-Path: ah@fatal.se
Date: Mon, 28 Jul 2014 14:21:15 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Karel Zak <kzak@redhat.com>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: allow non-inotify tailf to keep up
Message-ID: <20140728122115.GA17573@fatal.se>
References: <1406407441-4872-1-git-send-email-andreas@fatal.se>
 <53D4F231.9020906@draigBrady.com>
 <20140728115923.GK8533@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140728115923.GK8533@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

Hello!

On Mon, Jul 28, 2014 at 01:59:23PM +0200, Karel Zak wrote:
> On Sun, Jul 27, 2014 at 01:36:01PM +0100, Pádraig Brady wrote:
> > For such tests coreutils uses a helper function
> > to apply a truncated exponential backoff,
> > to run quickly in the common case, but also
> > delay longer if necessary. See retry_delay_() at:

Thanks for the pointer!

> > 
> > http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=init.cfg;h=725ee121;hb=HEAD#l608
> 
>  Andreas? (hint: send a new patch :-))

I fail to see how this is useful here. We either need a short delay (using
inotify) or a longer delay (not using inotify). All other steps seems
pointless to me, even harmful in non-inotify case!

Having a too short delay before appending data could make the testcase
succed even when tailf doesn't work properly (because it wakes up and
reads all data in first go).
And obviously having a too short delay before the file removal could
cause the test case to fail, but I consider false-positives worse
then false-negatives myself.

My hope was that 2*0.5s delay would be both low and high enough
to be good enough everywhere. Just wanted to warn about this maybe
not being 100% fail-proof.


If anyone else want to propose a solution/patch here, feel free!

Regards,
Andreas Henriksson

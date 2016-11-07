Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:55480 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbcKGI63 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 03:58:29 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Date: Mon, 7 Nov 2016 09:58:25 +0100
Cc: util-linux@vger.kernel.org
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de> <1478358489-18103-3-git-send-email-sweet_f_a@gmx.de> <6d62a61c-6dcf-e7a5-bfa3-5df4f93723a4@bernhard-voelker.de>
In-Reply-To: <6d62a61c-6dcf-e7a5-bfa3-5df4f93723a4@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201611070958.25232.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 06 November 2016, Bernhard Voelker wrote:
> On 11/05/2016 04:08 PM, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > Since there is no error handling in this test $LODEV
> > may be empty.
> >
> > Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
> > ---
> >  tests/ts/losetup/losetup-loop | 46
> > +++++++++++++++++++++---------------------- 1 file changed, 23
> > insertions(+), 23 deletions(-)
> >
> > diff --git a/tests/ts/losetup/losetup-loop
> > b/tests/ts/losetup/losetup-loop index cff12c9..13ccc65 100755
> > --- a/tests/ts/losetup/losetup-loop
> > +++ b/tests/ts/losetup/losetup-loop
> > @@ -42,15 +42,15 @@ BACKFILE="$TS_DEVICE"
> >
> >  ts_init_subtest "find-race-condition"
> >  LODEV=$( $TS_CMD_LOSETUP --find --nooverlap --show $BACKFILE )
> > -$TS_CMD_LOSETUP -d $LODEV
> > +$TS_CMD_LOSETUP -d "$LODEV"
>
> So what happens now when losetup is fed with ""?
> Wouldn't it be better to handle the error instead?

Actually the failure is generally handled in terms that the test will 
fail and exit 1. I did not want to change more of the test logic 
shortly before release. Also note that we are testing a possibly broken 
losetup here which makes any "good" error handling questionable 
anyways. For example if something goes wrong it would be of course nice 
to do at least some cleanup and remove all loop devices again to not 
let other tests fail too. But how should we do that if losetup is 
broken?

Regarding quoting. IMO we are missing a lot quotation marks in our 
test-suite. This is specially annoying since our programs are printing 
the whole --help output on usage errors. I really hate that auto-help 
feature. Don't understand why we are doing that instead of just 
printing "unkown option" or "missing argument".

cu,
Rudi

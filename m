Return-Path: <SRS0=5PSr=NM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B621C0044C
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36291205F4
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 18:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj+y7bPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36291205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbeKBDPx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:15:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36583 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbeKBDPx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Nov 2018 23:15:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id w16-v6so8491855ybp.3
        for <util-linux@vger.kernel.org>; Thu, 01 Nov 2018 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/s/xePhQ2jcU/NysnrU4QOPY5zYa3kD0JcgnickCP3w=;
        b=Mj+y7bPisek8blpTYci45oVLsoPMRScim3OR3kC4BzpOCFozTWHjkCftBQ9RWnJ1XC
         9idVkxiiwKHXKRAKx8yP+w7apEViFhfbuG+TEHDMYoWzlDrZliwh0A1qik5TcMFEAVYO
         25NWXKIm1SyFhpCB1OclFBA+C/LQXRuQFPuq9I5zqUKu1cEtboKLU3Pr2GV3HbJ4NbyM
         +2wppEiWEwhrUixxG3bqSi6yLqVAPp+BQaxhUKPSn597t/72hAFMsDGeImDM1grtosh2
         wue2fAAnBA8+lqxIDqjsHBGpdnUEUeREaIcOLkA6MabeMd6Bx7ZoChzOsADawmcW85ci
         +Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/s/xePhQ2jcU/NysnrU4QOPY5zYa3kD0JcgnickCP3w=;
        b=gzkylkvdteh2mtlmVp0+LTndKrjakt+RKHvuTfkOHgdzjCBj1eid9D/i9ybaokdiLn
         KBHebQOEjhQ08O55s0kv7nzY50YxWRx9wQLgTOOcEQyYIzjq6aRK6BOaUbzv8tMBCnru
         PROea/uJ15l/FbH5daNkZRt8Zt/QfqV4kPXKrtTB64pqvJ5Sz0sa5NaGLvi6beSHHZc4
         p507mdeANxJVFAi3H4Nl5hDA79K1u7iGCPuQa5ktW4AF30nLP/s8NSYUMOedANnav/TG
         EwKAfIr7eA72s2g5qu3i2BExVFdpT5d4eYkCX12S409BU4PJ/Nn2sO2IEsFijeugm5aO
         cW/w==
X-Gm-Message-State: AGRZ1gIYi/LB0Gt9yskJiAjTGcNtemetMjc3c+F0X3gjkAR5gJGv4Ct4
        0NkT8tShxmss6jjsmuU4RRsYF6A5gQXRZOv7O7I=
X-Google-Smtp-Source: AJdET5flSO2a2kzo0abaLnJ+eSmAOraE1HIyqFGgyxeM3dmNK57LQNlqAyVKbr8JcCvqgaMecfWN0t2qXs5eFfdikRY=
X-Received: by 2002:a25:ac22:: with SMTP id w34-v6mr8402943ybi.34.1541095909061;
 Thu, 01 Nov 2018 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <1541013948-15403-1-git-send-email-justinpopo6@gmail.com> <20181101100932.zdcp5rrbuab52rtt@ws.net.home>
In-Reply-To: <20181101100932.zdcp5rrbuab52rtt@ws.net.home>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 1 Nov 2018 11:11:36 -0700
Message-ID: <CAJx26kUA2+MH7zDpKOCG4kyX9Z9u-KNo4qB+viNSE4v3weyuZA@mail.gmail.com>
Subject: Re: [PATCH] rtcwake: use poweroff if shutdown is not found
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

v2 sent! Thanks for the review

On Thu, Nov 1, 2018 at 3:09 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Wed, Oct 31, 2018 at 12:25:48PM -0700, justinpopo6@gmail.com wrote:
> > From: Justin Chen <justinpopo6@gmail.com>
> >
> > Some systems do not have the shutdown command. Use poweroff as an
> > alternative.
> >
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > ---
> >  include/pathnames.h |  1 +
> >  sys-utils/rtcwake.c | 38 +++++++++++++++++++++++++++-----------
> >  2 files changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/pathnames.h b/include/pathnames.h
> > index 3d5052e..ed8ea33 100644
> > --- a/include/pathnames.h
> > +++ b/include/pathnames.h
> > @@ -53,6 +53,7 @@
> >  # define _PATH_LOGIN         "/bin/login"
> >  #endif
> >  #define _PATH_SHUTDOWN               "/sbin/shutdown"
> > +#define _PATH_POWEROFF               "/sbin/poweroff"
> >
> >  #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
> >  #define _PATH_TERMCOLORS_DIR "/etc/" _PATH_TERMCOLORS_DIRNAME
> > diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> > index b63c646..b79adbe 100644
> > --- a/sys-utils/rtcwake.c
> > +++ b/sys-utils/rtcwake.c
> > @@ -28,6 +28,7 @@
> >  #include <stdlib.h>
> >  #include <string.h>
> >  #include <sys/ioctl.h>
> > +#include <sys/stat.h>
> >  #include <sys/time.h>
> >  #include <sys/types.h>
> >  #include <termios.h>
> > @@ -579,20 +580,35 @@ int main(int argc, char **argv)
> >               break;
> >       case OFF_MODE:
> >       {
> > +             struct stat buf;
> >               char *arg[5];
> >               int i = 0;
> >
> > -             if (ctl.verbose)
> > -                     printf(_("suspend mode: off; executing %s\n"),
> > -                                             _PATH_SHUTDOWN);
> > -             arg[i++] = _PATH_SHUTDOWN;
> > -             arg[i++] = "-h";
> > -             arg[i++] = "-P";
> > -             arg[i++] = "now";
> > -             arg[i]   = NULL;
> > -             if (!ctl.dryrun) {
> > -                     execv(arg[0], arg);
> > -                     warn(_("failed to execute %s"), _PATH_SHUTDOWN);
> > +             if (!stat(_PATH_SHUTDOWN, &buf)) {
> > +                     arg[i++] = _PATH_SHUTDOWN;
> > +                     arg[i++] = "-h";
> > +                     arg[i++] = "-P";
> > +                     arg[i++] = "now";
> > +                     arg[i]   = NULL;
> > +             } else if (!stat(_PATH_POWEROFF, &buf)) {
> > +                     arg[i++] = _PATH_POWEROFF;
> > +                     arg[i]   = NULL;
> > +             } else {
> > +                     arg[i]   = NULL;
> > +             }
> > +
> > +             if (arg[0]) {
> > +                     if (ctl.verbose)
> > +                             printf(_("suspend mode: off; executing %s\n"),
> > +                                             arg[0]);
> > +                     if (!ctl.dryrun) {
> > +                             execv(arg[0], arg);
> > +                             warn(_("failed to execute %s"), arg[0]);
> > +                             rc = EXIT_FAILURE;
> > +                     }
> > +             } else {
> > +                     /* Failed to find shutdown command */
> > +                     warn(_("failed to find shutdown command"));
> >                       rc = EXIT_FAILURE;
>
> maybe we can also change  exit code to:
>
>             rc = EX_EXEC_ENOENT
>
> to be compatible with another utils.
>
>     Karel
>
> >               }
> >               break;
> > --
> > 2.7.4
> >
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

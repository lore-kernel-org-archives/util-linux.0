Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678Ab3D2J6M (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Apr 2013 05:58:12 -0400
Date: Mon, 29 Apr 2013 11:58:07 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 08/11] cal: allow day highlight testing
Message-ID: <20130429095807.GA22791@x2.net.home>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
 <1367169067-23705-9-git-send-email-kerolasa@iki.fi>
 <517DBDB7.8090506@draigBrady.com>
 <CAG27Bk0iSZDx=mJ_WM1sA5ins7g5zCqnTdVGLyogSZ4E9d57OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG27Bk0iSZDx=mJ_WM1sA5ins7g5zCqnTdVGLyogSZ4E9d57OA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 29, 2013 at 09:59:15AM +0100, Sami Kerola wrote:
> On 29 April 2013 01:24, Pádraig Brady <P@draigbrady.com> wrote:
> > On 04/28/2013 06:11 PM, Sami Kerola wrote:
> >> Requires similar trick as done with more to by pass check whether a
> >> session is or isn't interactive.
> >
> > I wonder should we have an option or env variable to force highlighting?
> > I've wanted a couple of times to pipe output like:
> >   cal --color=always | ansi2html.sh

 yep, coreutils way:

   --color[=WHEN]

 where WHEN is 'auto', 'never' or 'always'. 
 
 Sami, see lib/colors.c. It would be nice to have WHEN evaluation
 (conversion to some enum value) on one place and use the code 
 in dmesg --color[=WHEN] too.

> Your proposal makes totally sense. Karel, please wait a moment (till
> tomorrow) that I have a change to rewrite this change to be more
> useful. I'll send new patch to the list, and update my git sometime
> off-work-hour.

 Maybe we can use more colors in the cal(1) output. What about a
 weekend days, month name, week days line etc. ?


 I personally believe that there is still a lot of places where we can
 improve command line usability and readability. (See for example
 "dmesg -H" in the latest release.)

    Karel
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
